//
//  PeriodLengthViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/12/22.
//

#import "PeriodLengthViewController.h"
#import "FaceIdSetupViewController.h"
#import "CycleCollectionFuture+CoreDataClass.h"
#import "Cycle+CoreDataClass.h"
#import "Period+CoreDataClass.h"
#import "Event+CoreDataClass.h"
#import "Utilities.h"

@interface PeriodLengthViewController ()
@property (strong, nonatomic) NSMutableArray *pickerData;
@end

@implementation PeriodLengthViewController

- (void)finishPeriodLength {
    [self performSegueWithIdentifier:@"finishPeriodDuration" sender:self];
    
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"finishPeriodDuration"]) {
        FaceIdSetupViewController *controller = (FaceIdSetupViewController*)segue.destinationViewController;
        controller.user = self.user;
        controller.context = self.context;
    }
}

- (int)getPeriodDuration {
    return (int)[self.picker selectedRowInComponent:0] + 1;
}

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
    self.user.averagePeriodDuration = 5.0; // set to default
    [self finishPeriodLength];
}

- (IBAction)didTapContinue:(id)sender {
    self.user.averagePeriodDuration = [self getPeriodDuration];
    Cycle *current_cycle = [[self.user.cyclesFuture cycles] lastObject];
    current_cycle.periodDuration = self.user.averagePeriodDuration;
    
    for (int i = 1; i < current_cycle.periodDuration; i++) {
        NSDate *periodDate = [Utilities getDateByYearOffset:0 monthOffset:0 dayOffset:i date:current_cycle.startDate];
        Period *periodEvent = [[Period alloc] initWithContext:self.context];
        periodEvent.date = periodDate;
        periodEvent.type = 0;
        periodEvent.intensity = 0.5;
        periodEvent.predicted = YES;
        //[current_cycle.events insertEventOrderedByDate:periodEvent];
    }
    
    [self finishPeriodLength];
    self.user.lastBackup = nil;
    self.user.isSynced = NO;
}
@end
