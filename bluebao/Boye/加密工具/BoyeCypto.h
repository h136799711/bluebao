//
//  BoyeCypto.h
//  bluebao
//
//  Created by hebidu on 15/8/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@interface BoyeCypto : NSObject

/**
 *  md5加密
 *
 *  @param text 传入明文
 *
 *  @return md5加密后的密文（小写）
 */
+(NSString *)md5:(NSString *)text;

/**
 *  sha1加密
 *
 *  @param text 传入明文
 *
 *  @return sha1加密后的密文 (小写)
 */
+(NSString *)sha1:(NSString *)text;


/**
 *  base64 加密
 *
 *  @param text 明文
 *
 *  @return 密文
 */
+(NSString *)base64Encode:(NSString *)text;

/**
 *  base64 解密
 *
 *  @param text 明文
 *
 *  @return 密文
 */
+(NSString *)base64Decode:(NSString *)text;

/**
 *  DES 解密
 *
 *  @param text des加密后的密文
 *  @param key  加密的密钥
 *
 *  @return 解密后的明文
 */
+ (NSString *)desDecrypt:(NSString *)text WithKey:(NSString *)key;

/**
 *  DES 加密
 *
 *  @param text des加密后的密文
 *  @param key  密钥
 *
 *  @return 加密后的密文
 */
+(NSString *)desEncode:(NSString *)text :(NSString *)key;

/**
 *  aes256加密
 *
 *  @param text 明文
 *  @param key  密钥
 *
 *  @return 密文
 */
+(NSString *)aes256Encrypt:(NSString *)text :(NSString * )key;

/**
 *  aes256解密
 *
 *  @param encodeText 密文
 *  @param key        密钥
 *
 *  @return 明文
 */
+ (NSString *)aes256Decrypt:(NSString *)encodeText  :(NSString *)key;


@end
