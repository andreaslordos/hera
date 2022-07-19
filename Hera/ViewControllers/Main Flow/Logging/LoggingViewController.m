//
//  LoggingViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/18/22.
//

#import "LoggingViewController.h"

@interface LoggingViewController () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource>

@property (strong, atomic) NSDate *maxDate;
@property (weak, nonatomic) IBOutlet UIButton *periodButton;
@property (weak, nonatomic) IBOutlet UIButton *emotionButton;
@property (weak, nonatomic) IBOutlet UIButton *painButton;

@end

@implementation LoggingViewController

- (void)setAppearance {
    
    // create calendar object
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width - 20, 400)];
    
    // define interaction and scope of calendar object
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    calendar.scope = FSCalendarScopeWeek; // show only previous week
    calendar.firstWeekday = 2; // set first day to monday
    
    // set default appearance settings
    calendar.appearance.selectionColor = [UIColor blueColor]; // set selection color to blue
    calendar.appearance.headerMinimumDissolvedAlpha = 0.0; // hide header details
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase; // Mon -> M, Tue -> T, etc.
    calendar.appearance.borderRadius = 0.0; // make cells rectangular
    calendar.appearance.weekdayTextColor = [UIColor blackColor]; // make day color black
    calendar.appearance.titleOffset = CGPointMake(9., 15.); // set day number to bottom right corner
    calendar.appearance.subtitleOffset = CGPointMake(-10., -15.); // set month to top left corner
    calendar.center = CGPointMake(CGRectGetMidX(self.view.bounds), calendar.center.y); // center calendar
    
    // add calendar to view
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    self.calendar = calendar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _maxDate = [NSDate date];
    [self setAppearance];
}

- (BOOL)pastOrPresent:(NSDate *)date {
    NSComparisonResult result = [date compare:_maxDate];
    if (result==NSOrderedAscending) {
        return YES;
    }
    else {
        return NO;
    }
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    [dateFor setDateFormat:@"MMM"];
    return [dateFor stringFromDate:date];
}


- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    if ([self pastOrPresent:date]) {
        // color normally
        return cc.cellBgColor;
    }
    else {
        return cc.cellDisabledBgColor;
    }
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleDefaultColorForDate:(NSDate *)date {
    if ([self pastOrPresent:date]) {
        // color normally
        return cc.cellBgColor;
    }
    else {
        return cc.cellDisabledBgColor;
    }
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleSelectionColorForDate:(NSDate *)date {
    return cc.textSelectedColor;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    if ([self pastOrPresent:date]) {
        // color normally
        return cc.textDefaultColor;
    }
    else {
        return cc.textDisabledColor;
    }
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date {
    return cc.textSelectedColor;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return _maxDate; // set today's date as maximum selectable date
}

- (IBAction)didTapPeriodButton:(id)sender {
}

- (IBAction)didTapEmotionButton:(id)sender {
}

- (IBAction)didTapPainButton:(id)sender {
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
