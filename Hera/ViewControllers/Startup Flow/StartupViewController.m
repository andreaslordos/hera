//
//  StartupViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/15/22.
//

#import "StartupViewController.h"
#import "Utilities.h"
@interface StartupViewController ()

@end

@implementation StartupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([Utilities inUserDefaults:@"completedSetup"]) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"setupSegue" sender:nil];
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
