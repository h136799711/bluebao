//
//  CacheFacade.m
//  Bluetooth
//
//  Created by hebidu on 15/7/18.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "CacheFacade.h"

@interface CacheFacade ()
{
    
}
@property (copy,nonatomic) NSString * prefix;

@property double cacheTime;

@end

@implementation CacheFacade


+(CacheFacade *)sharedCache{
    
    static CacheFacade *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

-(instancetype) init{
   self = [super init];
    self.prefix = @"itboye_";
    return self;
}

/**
 *  获取缓存信息
 *
 *  @param key
 *
 *  @return 值
 */
-(id)get:(NSString *)key{
    
    NSNumber * currentTimeStamp = [NSDate currentTimeStamp];
    
    double expire_time =   [[NSUserDefaults standardUserDefaults] doubleForKey:[self getExpireTimeKey:key]];
    
    if(expire_time < currentTimeStamp.doubleValue){
        //已经过期则返回nil，并清除缓存
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:[self getKey:key]];
        return nil;
    }
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self getKey:key]];
}

/**
 *  设置缓存信息
 *
 *  @param object 存入对象
 *  @param key    存入键
 */
- (void)setObject:(id)object forKey:(NSString *)key{
    
    NSNumber * expire_time = [NSDate currentTimeStamp];
    
    [self setObject:object forKey:key WithExpireTime:expire_time];
}
/**
 *  设置缓存信息
 *
 *  @param object 存入对象
 *  @param key    存入键
 */
- (void)setObject:(id)object forKey:(NSString *)key WithExpireTime:(NSNumber *)timestamp{
    
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:[self getKey:key]];
    
    [[NSUserDefaults standardUserDefaults] setDouble: (timestamp.doubleValue+self.cacheTime) forKey:[self getExpireTimeKey:key]];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
/**
 *  清空所有缓存
 */
- (void)clearAll{
    
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
}
/**
 *  缓存数据KEY生成
 *
 *  @param key 原Key
 *
 *  @return boye加密后的使用key
 */
-(NSString * )getKey:(NSString *)key{
    return [[NSString alloc]initWithFormat:@"%@%@",self.prefix,key];
}

/**
 *  缓存时间标记 KEY 生成
 *
 *  @param key key 原Key
 *
 *  @return boye加密后的使用key
 */
-(NSString * )getExpireTimeKey:(NSString *)key{
    return [[NSString alloc]initWithFormat:@"%@expire_time_%@",self.prefix,key];
}


@end