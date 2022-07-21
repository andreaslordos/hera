//
//  CalendarViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/20/22.
//

#import "CalendarViewController.h"

@interface CalendarViewController () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource>

@property (strong, atomic) NSDate *today;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _today = [[NSDate alloc] init];
    [self setAppearanceCalendar];
}

- (void)setAppearanceCalendar {
    
    // create calendar object
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width - 20, self.view.frame.size.height - 80)];
    
    calendar.dataSource = self;
    calendar.delegate = self;

    // define interaction and scope of calendar object
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    calendar.scope = FSCalendarScopeMonth; // show month view
    calendar.firstWeekday = 2; // set first day to monday
    
    // set default appearance settings
    calendar.appearance.selectionColor = cc_calendar.cellSelectedColor; // set selection color to blue
    calendar.appearance.headerMinimumDissolvedAlpha = 0.0; // hide header details
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase; // Mon -> M, Tue -> T, etc.
    calendar.appearance.borderRadius = 0.0; // make cells rectangular
    calendar.appearance.weekdayTextColor = [UIColor blackColor]; // make day color black
    calendar.appearance.titleOffset = CGPointMake(9., 15.); // set day number to bottom right corner
    calendar.appearance.subtitleOffset = CGPointMake(-10., -15.); // set month to top left corner
    calendar.center = CGPointMake(CGRectGetMidX(self.view.bounds), calendar.center.y); // center calendar
    [calendar selectDate:_today];
    calendar.appearance.headerTitleColor = [UIColor blackColor];

    [calendar setPagingEnabled:NO]; // multiple months on the same screen
    [calendar setPlaceholderType:FSCalendarPlaceholderTypeNone];
    
    // add calendar to view
    [self.view addSubview:calendar];
    [self.view sendSubviewToBack:calendar];
    self.calendar = calendar;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    [dateFor setDateFormat:@"MMM"];
    return [dateFor stringFromDate:date];
}

- (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];

    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];

    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    if ([self isSameDay:_today otherDay:date]) {
        return cc_calendar.cellTodayBgColor;
    }
    else {
        return cc_calendar.cellBgColor;
    }
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleDefaultColorForDate:(NSDate *)date {
    if ([self isSameDay:_today otherDay:date]) {
        return cc_calendar.cellTodayBgColor;
    }
    else {
        return cc_calendar.cellBgColor;
    }
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleSelectionColorForDate:(NSDate *)date {
    return cc_calendar.textSelectedColor;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    return cc_calendar.textDefaultColor;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date {
    return cc_calendar.textSelectedColor;
}

// 6 months forward calendar
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:6];
    return [gregorian dateByAddingComponents:offsetComponents toDate:_today options:0];

}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-1];
    return [gregorian dateByAddingComponents:offsetComponents toDate:_today options:0];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSCalendar *diff_calendar = [NSCalendar currentCalendar];
    //declare your unitFlags
    int unitFlags = NSCalendarUnitWeekOfYear | NSCalendarUnitDay | NSCalendarUnitMonth;

    NSDateComponents *dateComponents = [diff_calendar components:unitFlags fromDate:date  toDate:_today options:0];

    long monthsInBetween = [dateComponents month];
    long weeksInBetween = [dateComponents weekOfYear];
    long daysInBetween = [dateComponents day];
    
    NSString *descriptor = @"";
    long length = 0;
    if (monthsInBetween >= 12) {
        descriptor = @"year";
        length = 1;
    }
    else if (monthsInBetween > 0) {
        descriptor = @"month";
        length = monthsInBetween;
    }
    else if (weeksInBetween > 0) {
        descriptor = @"week";
        length = weeksInBetween;
    }
    else if (daysInBetween > 0) {
        descriptor = @"day";
        length = daysInBetween;
    }
    else {
        [_titleBar setTitle:@"Today"];
        return;
    }
    
    if (length > 1) {
        descriptor = [descriptor stringByAppendingString:@"s"];
    }
    descriptor = [[NSString stringWithFormat:@"%lu ", length] stringByAppendingString:descriptor];
    
    NSString *title = [descriptor stringByAppendingString:@" ago"];
    
    [_titleBar setTitle:title];
}
@end
