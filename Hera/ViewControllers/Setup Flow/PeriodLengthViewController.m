//
//  PeriodLengthViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/12/22.
//

#import "PeriodLengthViewController.h"

@interface PeriodLengthViewController ()
@property (strong, nonatomic) NSMutableArray *pickerData;
@end

@implementation PeriodLengthViewController

- (void)finishPeriodLength {
    [self performSegueWithIdentifier:@"finishPeriodDuration" sender:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _picker.delegate = self;
    _picker.dataSource = self;
    _pickerData = [[NSMutableArray alloc] init];
    [_pickerData addObject:@"1 day"];
    for (int i = 2; i <= 31; i++) {
        [_pickerData addObject:[[@(i) stringValue] stringByAppendingString:@" days"]];
    }
    [self.picker selectRow:4 inComponent:0 animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
        return[_pickerData objectAtIndex:row];
}

- (IBAction)didTapNotSure:(id)sender {
    [self finishPeriodLength];
    // set up core data
}

- (IBAction)didTapContinue:(id)sender {
    [self finishPeriodLength];
    // set up core data
}
@end
