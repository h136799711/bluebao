//
//  BoyeGoalLocaNotify.h
//  bluebao
//
//  Created by boye_mac1 on 15/8/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalNotify.h"
#import "BoyeGoaldbModel.h"

@interface BoyeGoalLocaNotify : NSObject


/**
 * 发通知
 *@param
 **/

+(void)setLocalNotifyGoal:(BoyeGoaldbModel * )model;

/**
 * 取消通知
 *@param*
 **/
+(void) removeLocalNotifyKey:(NSInteger)goalID;


/**
 *  取消所有通知
 **/

+(void)removeAllLocalNotify;

/**
 * 移除当前应用，用户以外其他所有通知
 **/

+(void)removeAllLocalNotifyOutUser:(NSInteger)uid;

/**
 * 根据目标获得有效的闹铃时间
 *
 **/
+(NSDate *)registerLocalNotify:(BoyeGoaldbModel *)model;

@end
