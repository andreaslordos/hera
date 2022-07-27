//
//  NotificationPermsViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/14/22.
//

#import "NotificationPermsViewController.h"
#import "UserNotifications/UserNotifications.h"
#import "UserNotificationsUI/UserNotificationsUI.h"
#import "Utilities.h"

@interface NotificationPermsViewController ()

@end

@implementation NotificationPermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)completedSetup {
    //TODO: Stop storing completedSetup in User Defaults
    [Utilities saveToUserDefaults:@"YES" keys:@"completedSetup"];
    [self.context save:nil];
    [self performSegueWithIdentifier:@"doneWithSetup" sender:nil];
}

- (void)registerForNotifications {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
      if (!granted) {
        NSLog(@"Notifications not granted");
      }
    }];
}

- (IBAction)tappedEnableNotif:(id)sender {
    [self registerForNotifications];
    [self completedSetup];
}

- (IBAction)tappedNotNow:(id)sender {
    [self completedSetup];
}

@end
