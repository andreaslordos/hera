//
//  colorConstants.m
//  Hera
//
//  Created by Andreas Lordos on 7/18/22.
//

#import "cc.h"

@implementation cc

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

+(UIColor*)bleedingButtonBg {
    return [UIColor colorWithRed:243/255.0
                                     green:29/255.0
                                      blue:34/255.0
                                     alpha:1];
}

+(UIColor*)emotionButtonBg {
    return [UIColor colorWithRed:255/255.0
                                     green:149/255.0
                                      blue:0/255.0
                                     alpha:1];
}

+(UIColor*)painButtonBg {
    return [UIColor colorWithRed:88/255.0
                                     green:86/255.0
                                      blue:214/255.0
                                     alpha:1];
}

@end
