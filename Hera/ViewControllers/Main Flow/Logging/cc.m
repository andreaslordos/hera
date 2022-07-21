//
//  colorConstants.m
//  Hera
//
//  Created by Andreas Lordos on 7/18/22.
//

#import "cc.h"

@implementation cc

+(UIColor*)cellBgColor {
    return [UIColor colorWithRed:227.0f/255.0f
                            green:227.0f/255.0f
                            blue:227.0f/255.0f
                            alpha:1.0f];
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

+(UIColor*)cellSelectedColor {
    return [UIColor colorWithRed:32./255.
                                green:178./255.
                                blue:211./255.
                                alpha:1.];
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
