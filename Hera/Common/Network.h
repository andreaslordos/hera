//
//  Network.h
//  Hera
//
//  Created by Andreas Lordos on 8/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Network : NSObject
+(void)HttpPostToUrl:(NSString*)url encryptedUser:(NSData*)encryptedData callback:(void (^)(NSError *error, BOOL success, NSString *accessToken))callback;
@end

NS_ASSUME_NONNULL_END
