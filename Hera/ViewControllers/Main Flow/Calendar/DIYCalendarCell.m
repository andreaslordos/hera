//
//  DIYCalendarCell.m
//  Hera
//
//  Created by Andreas Lordos on 7/22/22.
//

#import "DIYCalendarCell.h"
#import "FSCalendarExtensions.h"
#import "cc_calendar.h"

@implementation DIYCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle"]];
        [self.contentView insertSubview:circleImageView atIndex:0];
        self.circleImageView = circleImageView;
        
        CAShapeLayer *selectionLayer = [[CAShapeLayer alloc] init];
        selectionLayer.actions = @{@"hidden":[NSNull null]};
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        
        self.shapeLayer.hidden = YES;
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [[cc_calendar cellBgColor] colorWithAlphaComponent:1.0];
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundView.frame = CGRectInset(self.bounds, 1, 1);
    self.circleImageView.frame = self.backgroundView.frame;
    self.selectionLayer.frame = self.bounds;

    if (self.selectionType == SelectionTypeSingle) {
        
        CGFloat diameter = MIN(self.selectionLayer.fs_height, self.selectionLayer.fs_width);
        self.selectionLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.contentView.fs_width/2-diameter/2, self.contentView.fs_height/2-diameter/2, diameter, diameter)].CGPath;
        
    }
}

- (void)configureAppearance {
    [super configureAppearance];
    // Override the build-in appearance configuration
    if (self.isPlaceholder) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.eventIndicator.hidden = YES;
    }
}

- (void)setSelectionType:(SelectionType)selectionType {
    if (_selectionType != selectionType) {
        _selectionType = selectionType;
        [self setNeedsLayout];
    }
}

- (void)setEventProbability:(CGFloat)probability fillColor:(UIColor*)color {
    
    self.selectionLayer.fillColor = color.CGColor;

    CGFloat indicatorHeight = probability * self.selectionLayer.bounds.size.height / 2.0;
    CGRect rect = CGRectMake(self.selectionLayer.bounds.origin.x,
                             self.selectionLayer.bounds.size.height - indicatorHeight,
                             self.selectionLayer.bounds.size.width,
                             indicatorHeight);
    self.selectionLayer.path = [UIBezierPath bezierPathWithRect:rect].CGPath;
}

- (void)setPeriodProbability:(CGFloat)probability {
    [self setEventProbability:probability fillColor:[cc_calendar periodIndicatorColor]];
}

- (void)setOvulationProbability:(CGFloat)probability {
    [self setEventProbability:probability fillColor:[cc_calendar ovulationIndicatorColor]];
}

@end
