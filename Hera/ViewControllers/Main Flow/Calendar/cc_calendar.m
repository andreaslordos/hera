//
//  cc.m
//  Hera
//
//  Created by Andreas Lordos on 7/20/22.
//

#import "cc_calendar.h"

@implementation cc_calendar
+(UIColor*)cellBgColor {
    return [UIColor lightGrayColor];
}

+(UIColor*)cellDisabledBgColor {
    return [UIColor grayColor];
}

+(UIColor*)textSelectedColor {
    return [UIColor whiteColor];
}

+(UIColor*)textDefaultColor {
    return [UIColor blackColor];
}

+(UIColor*)textDisabledColor {
    return [UIColor lightGrayColor];
}

@end
