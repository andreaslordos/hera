//
//  CalendarViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/20/22.
//

#import "CalendarViewController.h"
#import "DIYCalendarCell.h"
#import "get_predictions.h"

@interface CalendarViewController () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource>

@property (strong, atomic) NSDate *today;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;
@property (strong, nonatomic) NSCalendar *gregorian;
@property NSMutableDictionary *periodDates;
@property NSMutableDictionary *ovulationDates;

- (IBAction)didTapCalendar:(id)sender;
- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    _today = [[NSDate alloc] init];
    [self setAppearanceCalendar];
    get_predictions *predictions = [get_predictions alloc];
    predictions.user = [Utilities getUserFromParent:self];
    [predictions init];
    _periodDates = [predictions getPeriod];
    _ovulationDates = [predictions getOvulation];
}

- (void)viewWillAppear:(BOOL)animated {
    [_calendar setCurrentPage:[NSDate date] animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [self configureVisibleCells];
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
    [calendar setPlaceholderType:FSCalendarPlaceholderTypeNone]; // remove month
    
    [calendar registerClass:[DIYCalendarCell class] forCellReuseIdentifier:@"cell"];
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
    [comp1 year]  == [comp2 year];
}

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
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:6];
    return [self.gregorian dateByAddingComponents:offsetComponents toDate:_today options:0];

}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-1];
    return [self.gregorian dateByAddingComponents:offsetComponents toDate:_today options:0];
}


- (void)configureVisibleCells {
     NSArray *visibleCells = [_calendar visibleCells];
     for (FSCalendarCell* cell in visibleCells) {
         NSDate *date = [_calendar dateForCell:cell];
         FSCalendarMonthPosition position = [_calendar monthPositionForCell:cell];
        [self configureCell:cell forDate:date atMonthPosition:position];
    }
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

- (IBAction)didTapCalendar:(id)sender {
    [_calendar setCurrentPage:[NSDate date] animated:YES];
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    DIYCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
    return cell;
}


- (NSString*)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

- (void)configureCell:(DIYCalendarCell *)diyCell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    [diyCell setOvulationProbability:0.0];
    [diyCell setPeriodProbability:0.0];
    if ([_periodDates objectForKey:[self formatDate:date]]) {
        [diyCell setPeriodProbability:[[_periodDates objectForKey:[self formatDate:date]] floatValue]];
    }
    
    if ([_ovulationDates objectForKey:[self formatDate:date]]) {
        [diyCell setOvulationProbability:[[_ovulationDates objectForKey:[self formatDate:date]] floatValue]];
    }
}

@end
