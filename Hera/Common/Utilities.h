//
//  Utilities.h
//  Hera
//
//  Created by Andreas Lordos on 7/13/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject
@property NSCalendar* calendar;
+ (void)createSimpleAlert:(NSString *)alertTitle desc:(NSString *)alertText vc:(UIViewController *)vc;
+ (void)saveToUserDefaults:(NSString*)string_to_store keys:(NSString *)key_for_the_String;
+ (NSString*)retrieveUserDefault:(NSString*)key;
+ (BOOL)inUserDefaults:(NSString*)key;
+ (User*)getUserFromParent:(UIViewController*)vc;
+ (NSDictionary*)getUserAndContextFromParent:(UIViewController*)vc;
+ (NSManagedObjectContext*)getObjectContext;
+ (NSDate *)getDateByYearOffset:(int)year monthOffset:(int)month dayOffset:(int)day date:(NSDate *)date;
+ (NSDateComponents*)getTimeDeltaFrom:(NSDate*)date toDate:(NSDate*)date2;
+ (long)getDaysBetween:(NSDate*)date toDate:(NSDate*)date2;
+ (long)getDaysSince:(NSDate*)date;
+(NSData*)dictToJson:(NSDictionary*)dict;
+(NSDictionary*)JsonToDict:(NSData*)json;
@end

NS_ASSUME_NONNULL_END
