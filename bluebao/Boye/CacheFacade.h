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
 *  @param key 键值
 *
 *  @return 存入的对象 或 nil
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
 *
 *  设置缓存信息
 *
 *
 *  @param object    存入对象
 *  @param key       键值
 *  @param seconds  seconds秒后 数据将过期 单位（秒）
 */
- (void)setObject:(id)object forKey:(NSString *)key afterSeconds:(double )seconds;

/**
 *  设置缓存信息
 *
 *  @param object    缓存数据
 *  @param key       缓存key
 *  @param timestamp 缓存时间（单位：秒）
 */
- (void)setObject:(id)object forKey:(NSString *)key afterTimeStamp:(NSNumber *)timestamp;

/**
 *  清空所有缓存
 */
- (void)clearAll;

@end
