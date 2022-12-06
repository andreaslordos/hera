//
//  Serialization.h
//  Hera
//
//  Created by Andreas Lordos on 8/3/22.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Serialization : NSObject
+(NSData*)serializeUser:(User*)user;
+(NSDictionary*)serializeDates:(NSDictionary*)dict;
+(void)deserializeUser:(NSDictionary*)userDict context:(NSManagedObjectContext*)context;
+(NSDate*)deserializeDate:(NSString*)dateString;
@end

NS_ASSUME_NONNULL_END
