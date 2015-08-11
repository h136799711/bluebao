//
//  LocalNotify.h
//  bluebao
//
//  Created by hebidu on 15/8/11.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotify : NSObject

/**
 *  是否声音提醒
 */
@property (nonatomic,readonly) BOOL hasSound;

/**
 *  是否震动提醒
 */
@property (nonatomic,readonly) BOOL hasVibration;

/**
 *  发送通知
 *
 *  @param date     指定时间点发送
 *  @param content  指定文本内容
 *  @param interval 指定循环周期，为0时，只发送一次
 */
-(void) fireNotificationAt:(NSDate *)date :(NSString *) content :(NSCalendarUnit) interval;

+(LocalNotify *)sharedNotify;

@end
