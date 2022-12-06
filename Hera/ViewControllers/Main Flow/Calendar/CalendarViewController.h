//
//  CalendarViewController.h
//  Hera
//
//  Created by Andreas Lordos on 7/20/22.
//

#import <UIKit/UIKit.h>
#import <FSCalendar/FSCalendar.h>
#import "cc_calendar.h"
#import "Utilities.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalendarViewController : UIViewController<FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource>
@property (weak , nonatomic) FSCalendar *calendar;
@end

NS_ASSUME_NONNULL_END
