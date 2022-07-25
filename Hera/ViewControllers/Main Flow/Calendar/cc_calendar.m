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

+(UIColor*)cellSelectedColor {
    return [UIColor colorWithRed:32./255.
                           green:178./255.
                           blue:211./255.
                           alpha:1.];
}

+(UIColor*)textDefaultColor {
    return [UIColor blackColor];
}

+(UIColor*)cellTodayBgColor {
    return [UIColor yellowColor];
}

+(UIColor*)periodIndicatorColor {
    return [UIColor colorWithRed:255./255.
                           green:114./255.
                           blue:118./255.
                           alpha:1.];
}

+(UIColor*)ovulationIndicatorColor {
    return [UIColor colorWithRed:173./255.
                           green:216./255.
                           blue:230./255.
                           alpha:1.];
}

@end
