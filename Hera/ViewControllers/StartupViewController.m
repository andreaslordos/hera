//
//  StartupViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/15/22.
//

#import "StartupViewController.h"
#import "Utilities.h"
#import "AuthenticateViewController.h"
#import "TermsAndConditionsVC.h"
@interface StartupViewController ()

@end

@implementation StartupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([Utilities inUserDefaults:@"completedSetup"]) {
//        //[self performSegueWithIdentifier:@"loginSegue" sender:nil];
//        AuthenticateViewController *svc= [self.storyboard instantiateViewControllerWithIdentifier @"AuthenticateViewController"];]
//        svc.delegate=self;
//        [self.navigationController pushViewController:svc animated:YES];
//
//    }
//    else {
//        [self performSegueWithIdentifier:@"setupSegue" sender:nil];
//    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    /
    if ([[segue identifier] isEqualToString:@"completedSetup"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        TermsAndConditionsVC *termsController = (TermsAndConditionsVC*)navigationController.topViewController;
        termsController.delegate = self;
    }
    else {
        AuthenticateViewController *authenticateVC = [segue destinationViewController];
    }
}

@end
