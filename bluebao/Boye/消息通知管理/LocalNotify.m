//
//  LocalNotify.m
//  bluebao
//
//  Created by hebidu on 15/8/11.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "LocalNotify.h"
#import "NSDate+Helper.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation LocalNotify

+(LocalNotify*)sharedNotify{
    static LocalNotify *_sharedNotify = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedNotify = [[self alloc] init];
    });
    
    return _sharedNotify;
}

-(void)sethasSound:(BOOL) hasSound{
    _hasSound = hasSound;
}

-(void)sethasVibration:(BOOL) hasVibration{
    _hasVibration = hasVibration;
}

-(void) fireNotificationAt:(NSDate *)date :(NSString *) content :(NSCalendarUnit) interval{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {//判断系统是否支持本地通知
        
        notification.fireDate = [NSDate date];//本次开启立即执行的周期
        
        notification.repeatInterval = interval;//循环通知的周期
        
        notification.timeZone= [NSDate defaultDateFormatter].timeZone;
        
        notification.alertBody=content;//弹出的提示信息
        notification.applicationIconBadgeNumber=1; //应用程序的右上角小数字
        if (self.hasSound) {
            notification.soundName= UILocalNotificationDefaultSoundName ;//本地化通知的声音
        }else{
            notification.soundName = nil;
        }
        
        if(self.hasVibration){
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        notification.hasAction = NO;
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
//        return YES;
    }
    
//    return NO;
    
}

@end
