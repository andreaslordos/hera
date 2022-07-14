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
+ (void)saveToUserDefaults:(NSString*)string_to_store keys:(NSString *)key_for_the_String;
+ (NSString*)retrieveUserDefault:(NSString*)key;
+ (BOOL)inUserDefaults:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
