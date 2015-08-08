//
//  BoyeCypto.m
//  bluebao
//
//  Created by hebidu on 15/8/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeCypto.h"

@implementation BoyeCypto

+(NSString *)md5:(NSString *)text
{
    const char *cStr = [text UTF8String];
    unsigned char result[16];
    
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

+(NSString *)sha1:(NSString *)text{
    
    const char *cStr = [text UTF8String];

    NSData *data = [NSData dataWithBytes:cStr length:text.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}


+(NSString *)base64Encode:(NSString *)text{
    
    NSData* originData = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return encodeResult;
    
}

+(NSString *)base64Decode:(NSString *)text{
    
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:text options:0];
    
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodeStr;
}

#pragma mark des加密

+(NSString *)desEncode:(NSString *)text :(NSString *)key{
    NSString *ciphertext = nil;
    const char *textBytes = [text UTF8String];
    NSUInteger dataLength = [text length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(
                                          kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
        
    }
    
    return ciphertext;
    
//    NSStringEncoding EnC = NSUTF8StringEncoding;
//    NSData *data = [text dataUsingEncoding:EnC];
//    char keyPtr[kCCKeySizeAES256+1];
//    bzero(keyPtr, sizeof(keyPtr));
//    
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:EnC];
//        
//    NSUInteger dataLength = [data length];
//    
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//        
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
//                                                    kCCAlgorithmDES,
//                                                    kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                                    keyPtr, kCCBlockSizeDES,
//                                                    NULL,
//                                                    [data bytes], dataLength,
//                                                    buffer, bufferSize,
//                                                    &numBytesEncrypted);
//    
//    if (cryptStatus == kCCSuccess) {
//        
//        return [[NSString alloc] initWithBytes:buffer length:numBytesEncrypted encoding:NSUTF8StringEncoding];
//        
//    }
//    
//    free(buffer);
//    return nil;
}


+ (NSString *)desDecrypt:(NSString *)text WithKey:(NSString *)key
{
    
    NSData* cipherData = [GTMBase64 decodeString:text];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
//    NSData* data = [[NSData alloc] initWithBase64EncodedString:text options:0];
//    
////    NSLog(@"des解密= %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    
//    char keyPtr[kCCKeySizeAES256+1];
//    bzero(keyPtr, sizeof(keyPtr));
//        
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//        
//    NSUInteger dataLength = [data length];
//        
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//        
//    size_t numBytesDecrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                          keyPtr, kCCBlockSizeDES,
//                                          NULL,
//                                          [data bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesDecrypted);
//    
//    if (cryptStatus == kCCSuccess) {
//          return [[NSString alloc] initWithBytes:buffer length:numBytesDecrypted encoding:NSUTF8StringEncoding];
//    }
//        
//     free(buffer);
//     return nil;
}


+(NSString *)aes256Encrypt:(NSString *)text :(NSString * )key{
    
    
    
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
        
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
        
    size_t numBytesEncrypted = 0;
    
    char iv[] = {'1','2','3','4','5','6','7','8','1','2','3','4','5','6','7','8'};
    // 第1种方式
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                                kCCAlgorithmAES128,
                                                kCCOptionPKCS7Padding ,
                                                keyPtr,
                                                kCCKeySizeAES128,
                                              iv /* initialization vector (optional) */,
                                              [data bytes], dataLength, /* input */
                                              buffer, bufferSize, /* output */
                                                  &numBytesEncrypted);
    // 第2种方式
//TODO: 此方式加密有问题，只能处理长度16以下的明文
//    CCCryptorRef cryptorRef = nil;
//    CCCryptorStatus cryptStatus = CCCryptorCreateWithMode(kCCEncrypt,
//                                                          kCCModeCBC, kCCAlgorithmAES128,
//                                                          ccPKCS7Padding, iv, keyPtr,
//                                                          kCCKeySizeAES128,NULL,0, 0, 0, &cryptorRef);
//    cryptStatus = CCCryptorUpdate(cryptorRef, [data bytes], dataLength, buffer, bufferSize, &numBytesEncrypted);
//    cryptStatus = CCCryptorFinal(cryptorRef, buffer, bufferSize, &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
            NSData * encodeData =  [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
            NSString* encodeResult = [encodeData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            return encodeResult;
    }
    
    free(buffer);
    return nil;
}
    
+ (NSString *)aes256Decrypt:(NSString *)encodeText  :(NSString *)key {
    
    //解密有问题，只能处理长度16以下的明文
//    NSData* data = [[NSData alloc] initWithBase64EncodedString:encodeText options:0];
     NSData* data =  [GTMBase64 decodeString:encodeText];;
    char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    NSLog(@"%zu",bufferSize);
    size_t numBytesDecrypted = 0;
    char iv[] = {'1','2','3','4','5','6','7','8','1','2','3','4','5','6','7','8'};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                                kCCOptionPKCS7Padding,
                                              keyPtr, kCCKeySizeAES128,
                                              iv /* initialization vector (optional) */,
                                              [data bytes], dataLength, /* input */
                                              buffer, bufferSize, /* output */
                                              &numBytesDecrypted);
    NSString * result = nil;
    
//    NSLog(@"bufferSize= %ld",bufferSize);
// TODO: 需要拼接
//    CCCryptorRef cryptorRef = nil;
//    CCCryptorStatus cryptStatus = CCCryptorCreateWithMode(
//                                                          kCCDecrypt,
//                                                          kCCModeCBC,
//                                                          kCCAlgorithmAES128,
//                                                          ccPKCS7Padding,
//                                                          iv,
//                                                          keyPtr,
//                                                          kCCKeySizeAES128 , NULL , 0 ,  0 ,
//                                                          0
//                                                          , &cryptorRef);
    // 每次只翻译部分字节，只能字节拼接
//    cryptStatus = CCCryptorUpdate(cryptorRef, [data bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
//    
//    NSLog(@"numBytesDecrypted = %zu bufferSize=%ld",numBytesDecrypted,bufferSize);
//    NSString * result = [[NSString alloc] initWithBytes:buffer length:numBytesDecrypted encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"result = %@",result);
//    
//    cryptStatus = CCCryptorFinal(cryptorRef, buffer, bufferSize, &numBytesDecrypted);
//    NSLog(@"numBytesDecrypted = %zu output= %ld",numBytesDecrypted,CCCryptorGetOutputLength(cryptorRef, dataLength, YES));
    
    
//    result = [[NSString alloc] initWithBytes:buffer length:numBytesDecrypted encoding:NSUTF8StringEncoding];
//    NSLog(@"result = %@",result);
    if (cryptStatus == kCCSuccess) {
        result = [[NSString alloc] initWithBytes:buffer length:numBytesDecrypted encoding:NSUTF8StringEncoding];
//        NSLog(@"result = %@",result);
        
//        result =  [result stringByAppendingString:[[NSString alloc] initWithBytes:buffer length:numBytesDecrypted encoding:NSUTF8StringEncoding]];
        
    }
    
    free(buffer);
    return result;
    
    
}

@end
