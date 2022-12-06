//
//  Network.h
//  Hera
//
//  Created by Andreas Lordos on 8/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Network : NSObject
+(void)HttpPostToUrl:(NSString*)url settingsString:(NSString*)settingsString callback:(void (^)(NSError *error, BOOL success, NSString *accessToken))callback;
+(void)HttpSetUserData:(NSString*)url encryptedUser:(NSString*)encryptedData callback:(void (^)(NSError *error, BOOL success, NSString *accessToken))callback;
+(void)HttpGetUserData:(NSString*)url URI:(NSString*)URI callback:(void (^)(NSError *error, BOOL success, NSString *accessToken))callback;
@end

NS_ASSUME_NONNULL_END
