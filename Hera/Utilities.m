//
//  Utilities.m
//  Hera
//
//  Created by Andreas Lordos on 7/13/22.
//

#import "Utilities.h"

@implementation Utilities

+ (void)createSimpleAlert:(NSString *)alertTitle desc:(NSString *)alertText vc:(UIViewController *)vc {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                               message:alertText
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    
    [alert addAction:okAction];
    [vc presentViewController:alert animated:YES completion:^{
    }];
}

+ (void)saveToUserDefaults:(NSString*)string_to_store keys:(NSString *)key_for_the_String
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    if (standardUserDefaults) {
        [standardUserDefaults setObject:string_to_store forKey:key_for_the_String];
        [standardUserDefaults synchronize];
    }
}

+ (NSString*)retrieveUserDefault:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (BOOL)inUserDefaults:(NSString*)key {
    return [self retrieveUserDefault:key] != nil;
}

@end
