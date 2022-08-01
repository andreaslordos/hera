//
//  Crypto.m
//  Hera
//
//  Created by Andreas Lordos on 7/29/22.
//

#import "Crypto.h"
#import <Groot/Groot.h>
#import "Utilities.h"
#import "Cycle+CoreDataClass.h"
#import "CycleCollectionFuture+CoreDataClass.h"
#import "CycleCollectionPast+CoreDataClass.h"
#import "EventCollection+CoreDataClass.h"
#import "Event+CoreDataClass.h"
#import "Period+CoreDataClass.h"
#import "Pain+CoreDataClass.h"
#import "Mood+CoreDataClass.h"
#import "Ovulation+CoreDataClass.h"
#import "User+CoreDataClass.h"

@implementation Crypto


-(NSDictionary*)returnSerializedEntity:(NSManagedObject*)obj {
    NSArray *attributeKeys = [[[obj entity] attributesByName] allKeys];
    NSDictionary *dictAttributes = [obj dictionaryWithValuesForKeys:attributeKeys];
    return dictAttributes;
}

+(NSMutableDictionary*)normalizeDates:(NSDictionary*)dict {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSString *newString;
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSMutableDictionary *mDict = [dict mutableCopy];
    NSArray *keys = [mDict allKeys];
    for(NSString *key in keys) {
        if ([[mDict objectForKey:key] isKindOfClass:[NSDate class]]) {
            newString = [dateFormat stringFromDate:[mDict objectForKey:key]];
            [mDict setObject:newString forKey:key];
        }
    }
    return mDict;
}

+(NSData*)serializeUser:(User*)user {
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    
    NSArray *attributeKeys = [[[user entity] attributesByName] allKeys];
    NSDictionary *dictAttributes = [self normalizeDates:[user dictionaryWithValuesForKeys:attributeKeys]];
        
    [json setObject:dictAttributes forKey:@"userAttributes"];

    NSArray *futureCycles = [user.cyclesFuture.cycles array];
    NSArray *pastCycles = [user.cyclesPast.cycles array];
    NSArray *allCycles = [NSArray arrayWithObjects:pastCycles, futureCycles, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"pastCycles", @"futureCycles", nil];
    for (int a = 0; a < [allCycles count]; a++) {
        NSMutableArray *cyclesArr = [NSMutableArray array];
        for (int i = 0; i < [allCycles[a] count]; i++) {
            Cycle *currentCycle = allCycles[a][i];
            NSMutableArray *serializedCycle = [NSMutableArray array];
            NSArray *currentEvents = [currentCycle.events.event array];
            for (int j = 0; j < [currentEvents count]; j++) {
                Event *currentEvent = currentEvents[j];
                NSArray *eventKeys = [[[currentEvent entity] attributesByName] allKeys];
                NSDictionary *dictEvent = [self normalizeDates:[currentEvent dictionaryWithValuesForKeys:eventKeys]];
                [serializedCycle addObject:dictEvent];
            }
            [cyclesArr addObject:serializedCycle];
        }
        [json setObject:cyclesArr forKey:keys[a]];
    }

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    return jsonData;
}


+ (NSString *) generateKeyWithLength:(int)length {
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789!@#$%^&*()_+,./;'[]<>?:{}";
    NSMutableString *s = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}

+ (NSString*) genereteIV {
    int ivLength   = kCCBlockSizeAES128;
    NSMutableData  *ivData = [NSMutableData dataWithLength:kCCBlockSizeAES128];
    int iv = SecRandomCopyBytes(kSecRandomDefault, ivLength, ivData.mutableBytes);
    NSString* myString = [@(iv) stringValue];
    return myString;
}

+ (NSData *) cryptOperation:(CCOperation)operation key:(NSString*)key data:(NSData*)data iv:(NSString*)iv
{
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keys[kCCKeySizeAES256 + 1];
    [key getCString:keys maxLength:sizeof(keys) encoding:NSUTF8StringEncoding];
    // Perform PKCS7Padding on the key.
    unsigned long bytes_to_pad = sizeof(keys) - [key length];
    if (bytes_to_pad > 0)
    {
        char byte = bytes_to_pad;
        for (unsigned long i = sizeof(keys) - bytes_to_pad; i < sizeof(keys); i++)
            keys[i] = byte;
    }
    NSUInteger dataLength = [data length];
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus status = CCCrypt(operation, kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding,
                                     keys, kCCKeySizeAES256,
                                     [iv UTF8String],
                                     [data bytes], dataLength, /* input */
                                     buffer, bufferSize, /* output */
                                     &numBytesDecrypted);
    if (status == kCCSuccess)
    {
        //the returned NSData takes ownership of buffer and will free it on dealloc
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer); //free the buffer;
    return nil;
}


+ (NSData *)AES256EncryptWithKey:(NSString*)key data:(NSData*)data iv:(NSString*)iv
{
    return [self cryptOperation:kCCEncrypt key:key data:data iv: iv];
}

+ (NSData *)AES256DecryptWithKey:(NSString*)key data:(NSData*)data iv:(NSString*)iv
{
    return [self cryptOperation:kCCDecrypt key:key data:data iv: iv];
}


@end
