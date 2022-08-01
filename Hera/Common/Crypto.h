//
//  Crypto.h
//  Hera
//
//  Created by Andreas Lordos on 7/29/22.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataClass.h"
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface Crypto : NSObject

+(NSData*)serializeUser:(User*)user;
+(NSDictionary*)normalizeDates:(NSDictionary*)dict;
+ (NSString *) generateKeyWithLength:(int)length;
+ (NSData *) cryptOperation:(CCOperation)operation key:(NSString*)key data:(NSData*)data;
+ (NSData *)AES256EncryptWithKey:(NSString*)key data:(NSData*)data;
+ (NSData *)AES256DecryptWithKey:(NSString*)key data:(NSData*)data;

//+(User*)deserializeJson:(NSDictionary*)json;
@end

NS_ASSUME_NONNULL_END
