//
//  SettingsPageViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/29/22.
//

#import "SettingsPageViewController.h"
#import "SettingTableViewCell.h"
#import "User+CoreDataClass.h"
#import "Utilities.h"
#import "Crypto.h"
#import <CommonCrypto/CommonCryptor.h>
#import "Network.h"
#import "Foundation/Foundation.h"
#import "dispatch/dispatch.h"
#import "qrCodeViewController.h"
#import "Serialization/Serialization.h"


@interface SettingsPageViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *securitySettings;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSDictionary *qrData;
@property (weak, nonatomic) NSString *url;
- (IBAction)tappedScanner:(id)sender;
@end

@implementation SettingsPageViewController

- (void)viewDidLoad {
    self.user = [Utilities getUserFromParent:self];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.url = @"https://31c1-163-114-132-6.ngrok.io/application/";
    //self.url = @"http://127.0.0.1:8000/application/";
    self.securitySettings = [NSArray arrayWithObjects:@"Face ID and Login", @"Keep History", @"Birth Control", @"Last Sync", @"Transfer Hera to a new device", nil];
    [self.tableView reloadData];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"qrCode"]) {
        qrCodeViewController *controller = (qrCodeViewController*)segue.destinationViewController;
        controller.qrData = self.qrData;
    }
    else if ([segue.identifier isEqualToString:@"scannerSegue"]) {
        qrScannerViewController *controller = (qrScannerViewController*)segue.destinationViewController;
        controller.delegate = self;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"securitySetting"];
    [cell setName:[self.securitySettings objectAtIndex:indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.securitySettings count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        // selected transfer to a new device
        NSData *serializedUser = [Serialization serializeUser:self.user];
        NSString *key = [Crypto generateKeyWithLength:16];
        NSString *IV = [Crypto generateIV];
        NSData *encryptedUser = [Crypto AES256EncryptWithKey:key data:serializedUser iv:IV];
        NSString *encryptedUserString = [encryptedUser base64EncodedStringWithOptions:0];
        
        [Network HttpSetUserData:self.url encryptedUser:encryptedUserString callback:^(NSError *error, BOOL success, NSString *accessToken) {
            if (success) {
                NSLog(@"My response back from the server after an unknown amount of time");
                NSString *URI = accessToken;
                NSDictionary *qrDict = [NSDictionary dictionaryWithObjectsAndKeys: URI, @"URI", key, @"key", IV, @"IV", nil];
                // TODO: PASS IMAGE INTO NEXT SEGUE
                self.qrData = qrDict;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"qrCode" sender:self];
                });

            }
            else {
                NSLog(@"%@", error);
            }
        }];
    }
}

- (IBAction)tappedScanner:(id)sender {
    [self performSegueWithIdentifier:@"scannerSegue" sender:self];
}

- (void)didScan:(NSDictionary *)dict {
    self.QRdata = dict;
    [Network HttpGetUserData:self.url URI:[self.QRdata objectForKey:@"URI"] callback:^(NSError * _Nonnull error, BOOL success, NSString * _Nonnull message) {
        if (success) {
            NSData *encryptedData = [[NSData alloc] initWithBase64EncodedString:message options:0];
            NSData *decryptedMessage = [Crypto AES256DecryptWithKey:[self.QRdata objectForKey:@"key"] data:encryptedData iv:[self.QRdata objectForKey:@"IV"]];
            NSDictionary *data = [Utilities JsonToDict:decryptedMessage];
            NSDictionary *usercontext = [Utilities getUserAndContextFromParent:self];
            [Serialization deserializeUser:data context:[usercontext objectForKey:@"context"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [Utilities createSimpleAlert:@"New user imported" desc:@"Data transfer complete!" vc:self];
            });
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}
@end
