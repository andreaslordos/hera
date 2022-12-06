//
//  cc.h
//  Hera
//
//  Created by Andreas Lordos on 7/20/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface cc_calendar : NSObject
+(UIColor*)cellBgColor;
+(UIColor*)textSelectedColor;
+(UIColor*)textDefaultColor;
+(UIColor*)cellTodayBgColor;
+(UIColor*)cellSelectedColor;
+(UIColor*)periodIndicatorColor;
+(UIColor*)ovulationIndicatorColor;
@end

NS_ASSUME_NONNULL_END
