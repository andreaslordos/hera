//
//  Network.m
//  Hera
//
//  Created by Andreas Lordos on 8/1/22.
//

#import "Network.h"

@implementation Network

+(void)HttpPostToUrl:(NSString*)url settingsString:(NSString*)settingsString callback:(void (^)(NSError *error, BOOL success, NSString *accessToken))callback {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    //create the Method "GET" or "POST"%@&password=%@&api_id=%@&to=%@&text=
    [urlRequest setHTTPMethod:@"POST"];

    //Convert the String to Data
    NSData *data1 = [settingsString dataUsingEncoding:NSUTF8StringEncoding];

    //Apply the data to the body
    [urlRequest setHTTPBody:data1];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            NSInteger success = [[responseDictionary objectForKey:@"success"] integerValue];
            if(success == 1)
            {
                NSLog(@"SUCCESS");
                callback(nil, YES, [responseDictionary objectForKey:@"accessToken"]);
            }
            else
            {
                NSLog(@"FAILURE");
                callback(parseError, NO, [responseDictionary objectForKey:@"accessToken"]);
            }
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

+(void)HttpSetUserData:(NSString*)url encryptedUser:(NSData*)encryptedData callback:(void (^)(NSError *error, BOOL success, NSString *accessToken))callback {
    NSString* base64 = [[NSString alloc] initWithData:encryptedData encoding:NSDataBase64Encoding64CharacterLineLength];
    NSString *userUpdate =[NSString stringWithFormat:@"type=set&message=%@", base64, nil];
    [self HttpPostToUrl:url settingsString:userUpdate callback:^(NSError * _Nonnull error, BOOL success, NSString * _Nonnull accessToken) {
        callback(error, success, accessToken);
    }];
}

+(void)HttpGetUserData:(NSString*)url URI:(NSString*)URI callback:(void (^)(NSError *error, BOOL success, NSString *accessToken))callback {
    NSString *userUpdate =[NSString stringWithFormat:@"type=get&message=%@", URI, nil];
    [self HttpPostToUrl:url settingsString:userUpdate callback:^(NSError * _Nonnull error, BOOL success, NSString * _Nonnull accessToken) {
        callback(error, success, accessToken);
    }];
}
@end
