//
//  LastPeriodViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/12/22.
//

#import "LastPeriodViewController.h"

@interface LastPeriodViewController ()

@end

@implementation LastPeriodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datepicker.maximumDate = [NSDate date]; // set max date to today
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

- (void)finishLastPeriod {
    [self performSegueWithIdentifier:@"finishLastPeriod" sender:nil];
}
- (IBAction)didTapNotSure:(id)sender {
    [self finishLastPeriod];
}

- (IBAction)didTapContinue:(id)sender {
    [self finishLastPeriod];
}

@end
