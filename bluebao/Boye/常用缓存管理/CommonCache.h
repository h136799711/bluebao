//
//  CommonCache.h
//  bluebao
//
//  Created by hebidu on 15/8/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheFacade.h"

@interface CommonCache : NSObject

/**
 *  获取目标
 *
 *  @return 目标消耗卡路里
 */
+(NSString *)getGoal;
/**
 *  设置目标
 *
 */
+(void)setGoal:(NSNumber *)goal;

/**
 *获取用户账号信息
 *
 * @return 账号信息
 */

+(NSString *) getUserAccountInfoKey:(NSString *)keyString;

/**
 *缓存用户账号信息
 *
 * 
 */

+(void) saveUserAccountInfo:(NSString *)info key:(NSString *)keyString;

@end
