//
//  LoginScreenViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/18/22.
//

#import "LoginScreenViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Utilities.h"

@interface LoginScreenViewController ()
- (IBAction)didTapUnlock:(id)sender;

@end

@implementation LoginScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self didTapUnlock:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)finishFaceID {
    [self performSegueWithIdentifier:@"loginComplete" sender:nil];
}

- (IBAction)didTapUnlock:(id)sender {
    LAContext *laContext = [[LAContext alloc] init];
    NSString *localizedReason;
    NSError *error;
    if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        if (error != NULL) {
            [Utilities createSimpleAlert:@"Error" desc:error.localizedDescription vc:self];
        } else {
            if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                localizedReason = @"Unlock Hera using biometrics";
            }
            else {
                localizedReason = @"Unlock Hera using passcode";
            }
            
            [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
                
                if (success) {
                    NSLog(@"Authentication success");
                    // comes here if you succeed on face id
                    // programmatically switch to the next view
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self finishFaceID];
                        });
                }
            }];
        }
    }
    else {
        // no authentication with biometrics enabled.
        [Utilities createSimpleAlert:@"Phone security not enabled" desc:@"You must set up a form of security (Face ID, Pin, Touch ID) in your iPhone settings first, or skip this step." vc:self];
    }
}
@end
