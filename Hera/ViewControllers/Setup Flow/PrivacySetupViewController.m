//
//  PrivacySetupViewController.m
//  Hera
//
//  Created by Andreas Lordos on 11/29/22.
//

#import "SettingTableViewCell.h"
#import "PrivacySetupViewController.h"
#import "NotificationPermsViewController.h"
#import "Utilities.h"
#import "User+CoreDataClass.h"
#import "Crypto.h"
#import <CommonCrypto/CommonCryptor.h>
#import "Network.h"
#import "Foundation/Foundation.h"


@interface PrivacySetupViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *securitySettings;
@end

@implementation PrivacySetupViewController

- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"doneWithPrivacy"]) {
        NotificationPermsViewController *controller = (NotificationPermsViewController*)segue.destinationViewController;
        controller.user = self.user;
        controller.context = self.context;
    }
}

- (void)finishPrivacySetup {
    [self performSegueWithIdentifier:@"doneWithPrivacy" sender:self];
}

- (IBAction)tappedContinue:(id)sender {
    [self finishPrivacySetup];
}



@end
