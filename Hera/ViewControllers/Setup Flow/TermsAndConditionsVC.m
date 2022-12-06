//
//  TermsAndConditions.m
//  Hera
//
//  Created by Andreas Lordos on 7/12/22.
//

#import "TermsAndConditionsVC.h"

@interface TermsAndConditionsVC ()
@property (strong, nonatomic) NSURL *tcsURL;
@end

@implementation TermsAndConditionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tcsURL = [NSURL URLWithString:@"https://www.google.com"]; // url leading to t&c's and privacy policy
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

// open t&c's page
- (IBAction)didTapTerms:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:self.tcsURL]) {
        [[UIApplication sharedApplication] openURL:self.tcsURL options:@{ } completionHandler:nil];
    }
}
@end
