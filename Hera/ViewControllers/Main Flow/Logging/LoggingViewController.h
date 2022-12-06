//
//  LoggingViewController.h
//  Hera
//
//  Created by Andreas Lordos on 7/18/22.
//

#import <UIKit/UIKit.h>
#import "cc.h"
#import <FSCalendar/FSCalendar.h>
#import "Utilities.h"
#import "User+CoreDataClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoggingViewController : UIViewController <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource>
@property (weak , nonatomic) FSCalendar *calendar;

@end

NS_ASSUME_NONNULL_END
