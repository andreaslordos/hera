//
//  StartupNavigationController.m
//  Hera
//
//  Created by Andreas Lordos on 7/14/22.
//

#import "StartupNavigationController.h"
#import "Utilities.h"
#import "LoginViewController.h"
#import "TermsAndConditionsVC.h"

@interface StartupNavigationController ()

@property (nonatomic, retain) LoginViewController * LoginVC;
@property (nonatomic, retain) TermsAndConditionsVC * TCsVC;

@end

@implementation StartupNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.LoginVC = [[LoginViewController alloc] init];
    self.TCsVC = [[TermsAndConditionsVC alloc] init];
    
    if ([Utilities inUserDefaults:@"completedSetup"]) {
        [self setRootViewControllerWithID:1];
    }
    else {
        [self setRootViewControllerWithID:2];
    }
    [super viewWillAppear:YES];

//    if ([Utilities inUserDefaults:@"completedSetup"]) {
//        LoginViewController *loginVC;
//        [self pushViewController:loginVC animated:NO];
//    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) setRootViewControllerWithID:(int) viewControllerID
{
  if (viewControllerID == 1) {
    self.viewControllers = [NSArray arrayWithObject:self.LoginVC];
  } else
  {
    self.viewControllers = [NSArray arrayWithObject:self.TCsVC];
  }
}



@end
