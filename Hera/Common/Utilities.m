//
//  Utilities.m
//  Hera
//
//  Created by Andreas Lordos on 7/13/22.
//

#import "Utilities.h"
#import "HeraTabBarController.h"
#import "AppDelegate.h"
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

+ (NSManagedObjectContext*)getObjectContext {
    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDel getContext];
    return context;
}

+ (User*)getUserFromParent:(UIViewController*)vc {
    return [[self getUserAndContextFromParent:vc] objectForKey:@"user"];
}

+ (NSDictionary*)getUserAndContextFromParent:(UIViewController*)vc {
    HeraTabBarController *parent = nil;
    parent = [vc tabBarController];
    NSManagedObjectContext *context = parent.context;
    User *user = [[context executeFetchRequest:[User fetchRequest] error:nil] firstObject]; // since fetch returns an array get the first object in the array
    NSDictionary *returnDic = [NSDictionary dictionaryWithObjectsAndKeys:user, @"user", context, @"context", nil];
    return returnDic;
}

+ (NSDate *)getDateByYearOffset:(int)year monthOffset:(int)month dayOffset:(int)day date:(NSDate *)date {
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:year];
    [offsetComponents setMonth:month];
    [offsetComponents setDay:day];
    return [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];
}

+ (NSDateComponents*)getTimeDeltaFrom:(NSDate*)date toDate:(NSDate*)date2 {
    NSCalendar *diff_calendar = [NSCalendar currentCalendar];
    int unitFlags = NSCalendarUnitDay;
    return [diff_calendar components:unitFlags fromDate:date  toDate:date2 options:0];
}

+ (long)getDaysBetween:(NSDate*)date toDate:(NSDate*)date2 {
    return [[self getTimeDeltaFrom:date toDate:date2] day];
}

+ (long)getDaysSince:(NSDate*)date {
    return [self getDaysBetween:date toDate:[NSDate date]];
}

+(NSData*)dictToJson:(NSDictionary*)dict {
    NSError* error = nil;
    NSData *data =  [NSJSONSerialization dataWithJSONObject:dict
                                            options:0
                                            error:&error];
    if (data == nil) {
        NSLog(@"Error :%@", error);
    }
    
    return data;
}

+(NSDictionary*)JsonToDict:(NSData*)json {
    NSError* error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json
                                             options:0
                                             error:&error];
    if (dict == nil) {
        NSLog(@"Error: %@", error);
    }
    
    return dict;
}

@end
