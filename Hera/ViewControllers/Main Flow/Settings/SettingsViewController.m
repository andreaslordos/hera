//
//  SettingsViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/28/22.
//

#import "SettingsViewController.h"
#import "SettingsTableViewCell.h"
#import "Crypto.h"
#import "User+CoreDataClass.h"
@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *securitySettings;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.securitySettings = [NSArray arrayWithObjects:@"Face ID and Login", @"Keep History", @"Birth Control", @"Last Sync", @"Transfer Hera to a new device", nil];
    [self.tableView reloadData];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"securitySetting"];
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
        [self performSegueWithIdentifier:@"qrCode" sender:self];
    }
}

@end
