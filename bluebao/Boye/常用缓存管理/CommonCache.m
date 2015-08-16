//
//  CommonCache.m
//  bluebao
//
//  Created by hebidu on 15/8/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "CommonCache.h"


@implementation CommonCache

/**
 *  获取目标
 *
 *  @return 目标消耗卡路里
 */
+(NSString *)getGoal{
    
    UserInfo * userinfo = [MainViewController sharedSliderController].userInfo;
    NSString * key = [NSString stringWithFormat:@"GlobalGoalCalorie_uid_%ld",(long)userinfo.uid];
    NSString * goal =  [[CacheFacade sharedCache]get:key];
    
    if (goal == nil) {
        return [NSString stringWithFormat:@"%d",DEFAULT_GOAL];
    }
    
    return goal;
}


+(void)setGoal:(NSNumber *)goal{
    
    NSNumber * timeStamp = [NSNumber numberWithDouble:[[NSDate distantFuture] timeIntervalSince1970]];
    UserInfo * userinfo = [MainViewController sharedSliderController].userInfo;
    NSString * key = [NSString stringWithFormat:@"GlobalGoalCalorie_uid_%ld",(long)userinfo.uid];
    
    [[CacheFacade sharedCache]setObject: goal forKey:key afterTimeStamp:timeStamp];
    
}


+(BOOL) AlarmSwitchIsOn{
    
    NSString * key = @"COMMON_ALARM_SWITCH";
    
    NSString * state = [[CacheFacade sharedCache] get:key];
    
    if(state == nil || [state isEqualToString:@"YES"]){
        
        return YES;
        
    }
    
    return NO;
}

+(void)setAlarmSwitch:(BOOL )state{
    NSString * key = @"COMMON_ALARM_SWITCH";
    if (state) {
        [[CacheFacade sharedCache] setObject:@"YES" forKey:key afterSeconds:30*24*3600];
    }else{
        [[CacheFacade sharedCache] setObject:@"NO" forKey:key afterSeconds:30*24*3600];
    }
}

@end
