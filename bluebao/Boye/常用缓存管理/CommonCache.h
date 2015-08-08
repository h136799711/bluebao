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

@end
