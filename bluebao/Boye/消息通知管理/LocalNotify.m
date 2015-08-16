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

@interface LocalNotify (){
    NSString * _prefix;
}

@property (nonatomic,copy) NSString * prefix;

@end


@implementation LocalNotify



+(LocalNotify*)sharedNotify{
    static LocalNotify *_sharedNotify = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedNotify = [[self alloc] init];
        [_sharedNotify loadConfig];
    });
    
    return _sharedNotify;
}

#pragma mark --getter/setter



@synthesize hasVibration = _hasVibration;

@synthesize hasSound = _hasSound;

@synthesize isNotify = _isNotify;

//-(NSString *)prefix{
//    return _prefix;
//}

-(void)loadConfig{
    self->_isNotify=  [CommonCache AlarmSwitchIsOn];
    _prefix = @"itboye_local_notify_key";
    _hasSound = YES;
    _hasVibration = YES;
}

-(void) fireNotification:(NSString *)notifyID At:(NSDate *)date WithContent:(NSString *) content HasInterval:(NSCalendarUnit) interval{
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")){
        UIUserNotificationType types = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *mySettings =
        [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        
    }
    
    if (!self.isNotify) {
        return ;
    }
    
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {//判断系统是否支持本地通知
        
        NSDictionary * userinfo = @{
                                        _prefix:notifyID
                                        };
        
        
        notification.userInfo = userinfo;
        
        notification.fireDate = date;//本次开启立即执行的周期
        
        notification.repeatInterval = interval;//循环通知的周期
        
        notification.timeZone= [NSDate defaultDateFormatter].timeZone;
        
        notification.alertBody=content;//弹出的提示信息
        notification.applicationIconBadgeNumber=1; //应用程序的右上角小数字
        if (self.hasSound) {
            notification.soundName= UILocalNotificationDefaultSoundName ;//本地化通知的声音
//            notification.soundName= @"localnotify.mp3" ;//使用铃声
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

-(void)cancelNotification:(NSString *)notifyID{
    
    NSArray *localNotifications  = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[[self prefix]];
            // 如果找到需要取消的通知，则取消
            if (info != nil && [info isEqualToString:notifyID]) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}

-(void)cancelAll {
    
    NSArray *localNotifications  = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[self.prefix];
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
    
}

-(void)turnOff{
    self->_isNotify = false;
    [CommonCache setAlarmSwitch:NO];
}

-(void) turnOn{
    self->_isNotify = true;
    [CommonCache setAlarmSwitch:YES];
}


@end
