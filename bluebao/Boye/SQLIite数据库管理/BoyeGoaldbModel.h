//
//  BoyeGoaldbModel.h
//  bluebao
//
//  Created by boye_mac1 on 15/8/14.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoyeGoaldbModel : NSObject
@property (nonatomic,assign) NSInteger     db_id;               //id
@property (nonatomic,assign) NSInteger     target;              //目标
@property (nonatomic,strong) NSString      * date_time;         //时间
@property (nonatomic,assign) NSInteger        uid;              //用户uid
@property (nonatomic,assign) NSInteger      weekday;            //星期
@property (nonatomic,strong) NSString       *create_time;       //插入时间

@property (nonatomic,strong) NSDate         * fireDate;  //提醒时间
@property (nonatomic,assign) NSInteger      goalIndex;

@end
