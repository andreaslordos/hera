//
//  Utilities.h
//  Hera
//
//  Created by Andreas Lordos on 7/13/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject
+ (void)createSimpleAlert:(NSString *)alertTitle desc:(NSString *)alertText vc:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
