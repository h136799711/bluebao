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
        return [self defaultGoal];
    }
    
    return goal;
}


+(void)setGoal:(NSNumber *)goal{
    
    NSNumber * timeStamp = [NSNumber numberWithDouble:[[NSDate distantFuture] timeIntervalSince1970]];
    UserInfo * userinfo = [MainViewController sharedSliderController].userInfo;
    NSString * key = [NSString stringWithFormat:@"GlobalGoalCalorie_uid_%ld",(long)userinfo.uid];
    
    [[CacheFacade sharedCache]setObject: goal forKey:key afterTimeStamp:timeStamp];
    
}

+(NSString *)defaultGoal{
    
    return @"500";
}


/**
 *获取用户密码
 *
 * @return 密码
 */

+(NSString *) getUserAccountInfoKey:(NSString *)keyString{
    
    NSString * key = [NSString stringWithFormat:@"%@_",keyString];
    NSString * result = [[CacheFacade sharedCache] get:key];
    return result;
}

+(void) saveUserAccountInfo:(NSString *)info key:(NSString *)keyString{
    
    NSString * key = [NSString stringWithFormat:@"%@_",keyString];
    
    [[CacheFacade  sharedCache] setObject:info forKey:key afterSeconds:3600*24*30];
}



@end
