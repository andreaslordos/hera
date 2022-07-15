//
//  FaceIdSetupViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/13/22.
//

#import "FaceIdSetupViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Utilities.h"

@interface FaceIdSetupViewController ()
- (IBAction)didTapEnable:(id)sender;

@end

@implementation FaceIdSetupViewController

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

- (void)finishFaceID {
    [self performSegueWithIdentifier:@"doneWithFace" sender:nil];
}

- (IBAction)didTapEnable:(id)sender {
    LAContext *laContext = [[LAContext alloc] init];
    NSString *localizedReason;
    NSError *error;
    if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        if (error != NULL) {
            // handle error
            NSLog(@"Error not null");
            //[self showError:error];
        } else {
            
            if (@available(iOS 11.0.1, *)) {
                if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                    localizedReason = @"Unlock Hera using biometrics";
                    NSLog(@"FaceId support");
                }
                else {
                    localizedReason = @"Unlock Hera using passcode";
                    NSLog(@"No Biometric support");
                }
            } else {
                // Fallback on earlier versions
            }
            
            
            [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
                
                if (error != NULL) {
                    NSLog(@"Authentication error"); // comes here if you fail face id twice and try passcode or cancel
                } else if (success) {
                    NSLog(@"Authentication success");
                    // comes here if you succeed on face id
                    // programmatically switch to the next view
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self finishFaceID];
                        });
                } else {
                    NSLog(@"Authentication false");
                }
            }];
        }
    }
    else {
        // no authentication with biometrics enabled.
        [Utilities createSimpleAlert:@"Phone security not enabled" desc:@"You must set up a form of security (Face ID, Pin, Touch ID) in your iPhone settings first, or skip this step." vc:self];
    }
}

- (IBAction)didTapNotNow:(id)sender {
    [self finishFaceID];
}

@end
