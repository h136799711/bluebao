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
    NSString * key = [NSString stringWithFormat:@"GlobalGoalCalorie_uid_%ld",userinfo.uid];
    NSString * goal =  [[CacheFacade sharedCache]get:key];
    
    return goal;
}


+(void)setGoal:(NSNumber *)goal{
    
    NSNumber * timeStamp = [NSNumber numberWithDouble:[[NSDate distantFuture] timeIntervalSince1970]];
    UserInfo * userinfo = [MainViewController sharedSliderController].userInfo;
    NSString * key = [NSString stringWithFormat:@"GlobalGoalCalorie_uid_%ld",userinfo.uid];
    
    [[CacheFacade sharedCache]setObject: goal forKey:key afterTimeStamp:timeStamp];
    
}




@end
