//
//  Crypto.m
//  Hera
//
//  Created by Andreas Lordos on 7/29/22.
//

#import "Crypto.h"
#import "Utilities.h"

@implementation Crypto


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

+ (NSString*) generateIV {
    int ivLength   = kCCBlockSizeAES128;
    return [self generateKeyWithLength:ivLength];
}

+ (NSData *) cryptOperation:(CCOperation)operation key:(NSString*)key data:(NSData*)data iv:(NSString*)iv
{
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keys[kCCKeySizeAES128 + 1];
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
                                     keys, kCCKeySizeAES128,
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
