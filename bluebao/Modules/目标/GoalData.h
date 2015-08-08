//
//  GoalData.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/20.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoalData : NSObject<NSCoding>


@property (nonatomic,assign) NSInteger          goalID;

@property (nonatomic,copy) NSString             * timestr;//时间
@property (nonatomic,assign) NSInteger          goalNumber; //目标(卡)

@property (nonatomic,strong) NSDate             * dateTime;


@property (nonatomic,assign) NSInteger          consumeK; //消耗多少卡
@property (nonatomic,assign) NSInteger          maxIndex;


/**
 *默认目标
 *
 * goalNum  500;
 *
 * tiemStr 00:00
 **/

+(GoalData *) defauleGoal;


@end
