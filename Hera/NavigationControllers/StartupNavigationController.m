//
//  StartupNavigationController.m
//  Hera
//
//  Created by Andreas Lordos on 7/14/22.
//

#import "StartupNavigationController.h"
#import "Utilities.h"

@interface StartupNavigationController ()

@end

@implementation StartupNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([Utilities inUserDefaults:@"completedSetup"]) {
        [self performSegueWithIdentifier:@"completedSetup" sender:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
