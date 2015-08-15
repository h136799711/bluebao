//
//  BoyeGoalLocaNotify.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeGoalLocaNotify.h"
#define  USERINFO     [MainViewController sharedSliderController].userInfo

@implementation BoyeGoalLocaNotify

//设置通知

+(void)setLocalNotifyGoal{
    
    NSDate * data = [[MyTool getCurrentDate:nil] dateByAddingTimeInterval:10];
    NSLog(@" data %@",data);
    [[LocalNotify sharedNotify]  fireNotification:@"goal" At:data WithContent:@"回家吃饭了" HasInterval:5];
    
}

+(void) cancelLocalNotify{
    [[LocalNotify sharedNotify] cancelNotification:@"goal"];
    
}


//默认通知的key

+(NSString *) defaultNotifyKey:(NSInteger)goalID{
    
    return [self getFullNotifyKey:USERINFO.uid goalID:goalID];
}

//获得完整通知key
+ (NSString *) getFullNotifyKey:(NSInteger ) uid goalID:(NSInteger)goalID{
    
    return [NSString stringWithFormat:@"boye_%ld_%ld",uid,goalID];
}

@end
