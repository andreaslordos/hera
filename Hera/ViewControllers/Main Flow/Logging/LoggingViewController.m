//
//  LoggingViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/18/22.
//

#import "LoggingViewController.h"

@interface LoggingViewController () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource>

@property (strong, atomic) NSDate *today;
@property (strong, nonatomic) NSString *lastTypeSelected;
@property (strong, nonatomic) NSString *lastOptionSelected;
@property (weak, nonatomic) IBOutlet UIButton *periodButton;
@property (weak, nonatomic) IBOutlet UIButton *emotionButton;
@property (weak, nonatomic) IBOutlet UIButton *painButton;
@property (weak, nonatomic) IBOutlet UIButton *option1;
@property (weak, nonatomic) IBOutlet UIButton *option2;
@property (weak, nonatomic) IBOutlet UIButton *option3;
@property (weak, nonatomic) IBOutlet UIButton *option4;
@property (weak, nonatomic) IBOutlet UILabel *option1label;
@property (weak, nonatomic) IBOutlet UILabel *option2label;
@property (weak, nonatomic) IBOutlet UILabel *option3label;
@property (weak, nonatomic) IBOutlet UILabel *option4label;
@property (weak, nonatomic) IBOutlet UIButton *infobutton;
- (IBAction)didTapPeriodButton:(id)sender;
- (IBAction)didTapPainButton:(id)sender;
- (IBAction)didTapEmotionButton:(id)sender;
- (IBAction)didTapOption1:(id)sender;
- (IBAction)didTapOption2:(id)sender;
- (IBAction)didTapOption3:(id)sender;
- (IBAction)didTapOption4:(id)sender;
- (IBAction)didTapAdd:(id)sender;

@end

@implementation LoggingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _today = [NSDate date];
    [self setAppearanceButtons];
    [self setAppearanceCalendar];
    User *user = [Utilities getUserFromParent:self];
    NSLog(@"face ID Enabled: %d", user.faceIdEnabled);
    NSLog(@"last cycle start date: %@", user.lastCycleStart);
    NSLog(@"period length: %f", user.averagePeriodDuration);
}

- (void)setAppearanceCalendar {
    
    // create calendar object
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width - 20, 400)];
    
    calendar.dataSource = self;
    calendar.delegate = self;
    
    // define interaction and scope of calendar object
    calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
    calendar.scope = FSCalendarScopeWeek; // show only previous week
    calendar.firstWeekday = 2; // set first day to monday
    // set default appearance settings
    calendar.appearance.selectionColor = cc.cellSelectedColor; // set selection color to blue
    calendar.appearance.headerMinimumDissolvedAlpha = 0.0; // hide header details
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase; // Mon -> M, Tue -> T, etc.
    calendar.appearance.borderRadius = 0.0; // make cells rectangular
    calendar.appearance.weekdayTextColor = [UIColor blackColor]; // make day color black
    calendar.appearance.titleOffset = CGPointMake(9., 15.); // set day number to bottom right corner
    calendar.appearance.subtitleOffset = CGPointMake(-10., -15.); // set month to top left corner
    calendar.center = CGPointMake(CGRectGetMidX(self.view.bounds), calendar.center.y); // center calendar
    calendar.appearance.headerTitleColor = [UIColor blackColor];
    [calendar selectDate:_today];
    // add calendar to view
    [self.view addSubview:calendar];
    [self.view sendSubviewToBack:calendar];
    self.calendar = calendar;
}


- (void)setButtonColor:(UIColor*)color {
    _option1.layer.borderColor = color.CGColor;
    _option1.tintColor = color;
    _option2.layer.borderColor = color.CGColor;
    _option2.tintColor = color;
    _option3.layer.borderColor = color.CGColor;
    _option3.tintColor = color;
    _option4.layer.borderColor = color.CGColor;
    _option4.tintColor = color;
    _infobutton.tintColor = color;
}

- (void)setAppearanceButtons {
    [self setButtonColor:cc.bleedingButtonBg];
    _option1.layer.borderWidth = 4.;
    _option2.layer.borderWidth = 4.;
    _option3.layer.borderWidth = 4.;
    _option4.layer.borderWidth = 4.;
    [self setInfoButtonText:@"Bleeding"];
    _lastTypeSelected = @"Bleeding";
}

- (BOOL)pastOrPresent:(NSDate *)date {
    NSComparisonResult result = [date compare:_today];
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
    return _today; // set today's date as maximum selectable date
}

- (void)setInfoButtonText:(NSString *)desc {
    NSString *fullStr = [desc stringByAppendingString:@"  i"];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString: fullStr];
 
    NSRange boldRange = [fullStr rangeOfString:fullStr];
    UIFont *boldFont = [UIFont fontWithName:@"Helvetica-bold" size: 15];
    [attributedText addAttribute:NSFontAttributeName value:boldFont range: boldRange];

    [_infobutton setAttributedTitle:attributedText forState:UIControlStateNormal];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)resetButtons {
    _option1.backgroundColor = [UIColor systemBackgroundColor];
    _option2.backgroundColor = [UIColor systemBackgroundColor];
    _option3.backgroundColor = [UIColor systemBackgroundColor];
    _option4.backgroundColor = [UIColor systemBackgroundColor];
    _option1.tintColor = [UIColor colorWithCGColor:_option1.layer.borderColor];
    _option2.tintColor = [UIColor colorWithCGColor:_option2.layer.borderColor];
    _option3.tintColor = [UIColor colorWithCGColor:_option3.layer.borderColor];
    _option4.tintColor = [UIColor colorWithCGColor:_option4.layer.borderColor];
}

- (void)setButtonLabels:(NSArray*)labels {
    _option1label.text = labels[0];
    _option2label.text = labels[1];
    _option3label.text = labels[2];
    _option4label.text = labels[3];
}

- (IBAction)didTapAdd:(id)sender {
    if (_lastTypeSelected != nil && _lastOptionSelected != nil && [_calendar selectedDate] != nil) {
        // store data in core data
        [Utilities createSimpleAlert:@"Success" desc:@"Added successfully" vc:self];
    }
    else {
        [Utilities createSimpleAlert:@"Error" desc:@"Select an option before adding" vc:self];
    }
}

- (IBAction)didTapOption4:(id)sender {
    [self resetButtons];
    _option4.backgroundColor = [UIColor colorWithCGColor:_option4.layer.borderColor];
    _option4.tintColor = [UIColor whiteColor];
    _lastOptionSelected = @"4";
    _option4.alpha = 1.;
}

- (IBAction)didTapOption3:(id)sender {
    [self resetButtons];
    _option3.backgroundColor = [UIColor colorWithCGColor:_option3.layer.borderColor];
    _option3.tintColor = [UIColor whiteColor];
    _lastOptionSelected = @"3";
    _option3.alpha = 1.;
}

- (IBAction)didTapOption2:(id)sender {
    [self resetButtons];
    _option2.backgroundColor = [UIColor colorWithCGColor:_option2.layer.borderColor];
    _option2.tintColor = [UIColor whiteColor];
    _lastOptionSelected = @"2";
    _option2.alpha = 1.;
}

- (IBAction)didTapOption1:(id)sender {
    [self resetButtons];
    _option1.backgroundColor = [UIColor colorWithCGColor:_option1.layer.borderColor];
    _option1.tintColor = [UIColor whiteColor];
    _lastOptionSelected = @"1";
    _option1.alpha = 1.;
}

- (IBAction)didTapEmotionButton:(id)sender {
    [self setButtonColor:cc.emotionButtonBg];
    [self setInfoButtonText:@"Mood"];
    [self setButtonLabels:[NSArray arrayWithObjects:@"Happy", @"Sensitive", @"Sad", @"PMS", nil]];
    [self resetButtons];
    _lastTypeSelected = @"Emotion";
    [self setButtonAlphas:_emotionButton];
}

- (IBAction)didTapPainButton:(id)sender {
    [self setButtonColor:cc.painButtonBg];
    [self setInfoButtonText:@"Pain"];
    [self setButtonLabels:[NSArray arrayWithObjects:@"Cramps", @"Headache", @"Ovulation", @"Tender Breasts", nil]];
    [self resetButtons];
    _lastTypeSelected = @"Pain";
    [self setButtonAlphas:_painButton];
}

- (IBAction)didTapPeriodButton:(id)sender {
    [self setButtonColor:cc.bleedingButtonBg];
    [self setInfoButtonText:@"Bleeding"];
    [self setButtonLabels:[NSArray arrayWithObjects:@"Light", @"Moderate", @"Heavy", @"Spotting", nil]];
    [self resetButtons];
    _lastTypeSelected = @"Period";
    [self setButtonAlphas:_periodButton];
    
}

- (void)setButtonAlphas:(UIButton*)button {
    _painButton.alpha = .25;
    _periodButton.alpha = .25;
    _emotionButton.alpha = .25;
    button.alpha = 1.;
}
@end
