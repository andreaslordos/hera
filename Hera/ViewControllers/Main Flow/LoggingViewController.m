//
//  LoggingViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/18/22.
//

#import "LoggingViewController.h"

@interface LoggingViewController () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource>

@property (strong, atomic) NSDate *maxDate;

@end

@implementation LoggingViewController

- (void)setAppearance {
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 40, 320, 400)];
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    calendar.scope = FSCalendarScopeWeek; // show only previous week
    calendar.firstWeekday = 2; // set first day to monday
    calendar.appearance.selectionColor = [UIColor blueColor]; // set selection color to blue
    calendar.appearance.headerMinimumDissolvedAlpha = 0.0; // hide header details
    calendar.appearance.weekdayTextColor = [UIColor blackColor]; // make day color black
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase; // Mon -> M, Tue -> T, etc.
    calendar.appearance.borderRadius = 0.0;
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    //calendar.center = [self.view convertPoint:self.view.center fromView:self.view.superview];
    calendar.center = CGPointMake(CGRectGetMidX(self.view.bounds), calendar.center.y);

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

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    if ([self pastOrPresent:date]) {
        // color normally
        return [UIColor lightGrayColor];
    }
    else {
        // give disabled color
        return [UIColor darkGrayColor];
    }
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    if ([self pastOrPresent:date]) {
        // color normally
        return [UIColor blackColor];
    }
    else {
        // give disabled color
        return [UIColor grayColor];
    }
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date {
    return [UIColor whiteColor];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return _maxDate; // set today's date as maximum selectable date
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
