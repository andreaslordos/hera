//
//  cc.m
//  Hera
//
//  Created by Andreas Lordos on 7/20/22.
//

#import "cc_calendar.h"

@implementation cc_calendar
+(UIColor*)cellBgColor {
    return [UIColor colorWithRed:227.0f/255.0f
                            green:227.0f/255.0f
                            blue:227.0f/255.0f
                            alpha:1.0f];
}


+(UIColor*)textSelectedColor {
    return [UIColor whiteColor];
}

+(UIColor*)textDefaultColor {
    return [UIColor blackColor];
}

+(UIColor*)cellTodayBgColor {
    return [UIColor yellowColor];
}
@end
