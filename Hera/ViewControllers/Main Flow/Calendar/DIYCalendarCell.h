//
//  DIYCalendarCell.h
//  Hera
//
//  Created by Andreas Lordos on 7/22/22.
//

#import <Foundation/Foundation.h>
#import <FSCalendar/FSCalendar.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SelectionType) {
    SelectionTypeNone,
    SelectionTypeSingle,
};

@interface DIYCalendarCell : FSCalendarCell

@property (weak, nonatomic) UIImageView *circleImageView;

@property (weak, nonatomic) CAShapeLayer *selectionLayer;

@property (assign, nonatomic) SelectionType selectionType;

- (void)setPeriodProbability:(CGFloat)probability;
- (void)setOvulationProbability:(CGFloat)probability;

@end

NS_ASSUME_NONNULL_END
