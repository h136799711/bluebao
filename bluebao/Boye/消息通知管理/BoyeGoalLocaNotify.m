//
//  BoyeGoalLocaNotify.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//
#import "BoyeDataBaseManager.h"
#import "BoyeGoalLocaNotify.h"
#define  USERINFO     [MainViewController sharedSliderController].userInfo

@implementation BoyeGoalLocaNotify

//设置通知

+(void)setLocalNotifyGoal:(BoyeGoaldbModel * )model{
    
    NSString * key = [self defaultNotifyKey:model.db_id];
    
    DLog(@"date=%@",model.fireDate);
  
    if (![CommonCache AlarmSwitchIsOn]) {
        return;
    }
    
    [[ LocalNotify sharedNotify]  fireNotification:key At:model.fireDate  WithContent:[NSString stringWithFormat:@" %@到运动时间了，目标 %ld ",model.date_time,model.target] HasInterval:NSCalendarUnitWeekday];
}

//取消通知

+(void) removeLocalNotifyKey:(NSInteger)goalID{
    
    NSString * key =  [self defaultNotifyKey:goalID];
    [[LocalNotify sharedNotify] cancelNotification:key];
}

//取消所有通知
+(void)removeAllLocalNotify{
    [[LocalNotify sharedNotify] cancelAll];
    DLog(@"移除所有闹铃");

}

//移除除当前用户以外其他所有通知
+(void)removeAllLocalNotifyOutUser:(NSInteger)uid{
    
    NSArray * array = [BoyeDataBaseManager getAllData];
    for (BoyeGoaldbModel * model in array) {
        if (model.uid != uid ) {
            [self removeLocalNotifyKey:model.db_id];
        }
    }
}




//默认通知的key
/**
 * @parma goalID  数据库中的 id
 */
+(NSString *) defaultNotifyKey:(NSInteger)goalID{
    
    return [self getFullNotifyKey:USERINFO.uid goalID:goalID];
}

//获得完整通知key
/**
 * @parma   uid   用户id
 *@parma   goalID  数据库标识
 **/
+ (NSString *) getFullNotifyKey:(NSInteger ) uid goalID:(NSInteger)goalID{
    
    return [NSString stringWithFormat:@"%ld_%ld",uid,goalID];
}


+(NSDate *)registerLocalNotify:(BoyeGoaldbModel *)model{
    
    NSDate * nowDate =  [NSDate date];
    NSString * dataFormatt = @"yyyy-MM-dd";
    NSString *  timestr = [MyTool getCurrentDateFormat:dataFormatt];
    NSString * datestring = [NSString stringWithFormat:@"%@ %@",timestr,model.date_time];
    
    
    NSDate  * date = [[MyTool  getDateFormatter:@"yyyy-MM-dd HH:mm"] dateFromString:datestring];
    
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:nowDate];
    
    NSInteger selectWeekday = model.weekday + 2;
    
    //转换成周日＝1 周一=2 周二＝3
    if (selectWeekday == 8) {
        selectWeekday = 1;
    }
    
    NSInteger intervalDay =  selectWeekday - comps.weekday;
    
    DLog(@"相差天数%ld" , (long)intervalDay);
    NSDate * fireDate = [date dateByAddingTimeInterval:intervalDay*24*3600];
    
    NSComparisonResult result = [date compare:nowDate];
    if ( result == NSOrderedAscending) {
        fireDate =  [date dateByAddingTimeInterval:7*24*3600];
    }
    
    model.fireDate = fireDate;
    
    return model.fireDate;
}

@end
