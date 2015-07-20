//
//  CacheFacade.h
//  Bluetooth
//
//  Created by hebidu on 15/7/18.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Helper.h"

@interface CacheFacade : NSObject



+(CacheFacade *)sharedCache;

/**
 *  获取缓存信息
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
-(id)get:(NSString *)key;

/**
 *  设置缓存信息，使用默认时间
 *
 *  @param object    缓存数据
 *  @param key       缓存key
 */
- (void)setObject:(id)object forKey:(NSString *)key;

/**
 *  设置缓存信息
 *
 *  @param object    缓存数据
 *  @param key       缓存key
 *  @param timestamp 缓存时间（单位：秒）
 */
- (void)setObject:(id)object forKey:(NSString *)key WithExpireTime:(NSNumber *)timestamp;

/**
 *  清空所有缓存
 */
- (void)clearAll;

@end
