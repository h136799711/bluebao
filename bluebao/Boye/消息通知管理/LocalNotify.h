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
 *  是否提醒
 */
@property (nonatomic,readonly) BOOL isNotify;

/**
 *  是否声音提醒
 */
@property (nonatomic,readonly) BOOL hasSound;

/**
 *  是否震动提醒
 */
@property (nonatomic,readonly) BOOL hasVibration;


/**
 *  打开提醒
 */
-(void)turnOn;

/**
 *  关闭提醒
 */
-(void)turnOff;

 /**
 *  发送通知
 *
 *  @param notifyID 给该通知一个唯一的ID
 *  @param date     指定时间点发送
 *  @param content  指定文本内容
 *  @param interval 指定循环周期，为0时，只发送一次
 *
 */
-(void) fireNotification:(NSString *)notifyID At:(NSDate *)date WithContent:(NSString *) content HasInterval:(NSCalendarUnit) interval;

/**
 *  取消通知
 *  传入发送通知时，给的唯一ID
 */
-(void)cancelNotification:(NSString *)notifyID;

/**
 *  取消本APP的所有通知
 */
-(void)cancelAll;

+(LocalNotify *)sharedNotify;

@end
