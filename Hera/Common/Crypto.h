//
//  Crypto.h
//  Hera
//
//  Created by Andreas Lordos on 7/29/22.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataClass.h"
#import <CommonCrypto/CommonCryptor.h>
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface Crypto : NSObject
+(NSString *)generateKeyWithLength:(int)length;
+(NSData *)cryptOperation:(CCOperation)operation key:(NSString*)key data:(NSData*)data iv:(NSString*)iv;
+(NSData *)AES256EncryptWithKey:(NSString*)key data:(NSData*)data iv:(NSString*)iv;
+(NSData *)AES256DecryptWithKey:(NSString*)key data:(NSData*)data iv:(NSString*)iv;
+(NSString*)generateIV;
@end

NS_ASSUME_NONNULL_END
