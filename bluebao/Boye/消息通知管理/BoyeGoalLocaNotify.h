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
 *
 **/
+(void)setLocalNotifyGoal;

/**
 * 取消通知
 *@param
 *
 **/
+(void) cancelLocalNotify;

@end
