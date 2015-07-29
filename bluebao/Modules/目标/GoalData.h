//
//  GoalData.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/20.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoalData : NSObject



@property (nonatomic,copy) NSString             * timestr;//时间
@property (nonatomic,assign) NSInteger          goalNumber; //目标卡

@property (nonatomic,copy) NSString             * hour;//小时
@property (nonatomic,copy) NSString             * minute;//分钟
@property (nonatomic,strong) NSDate             * dateTime;





@property (nonatomic,assign) NSInteger          hundredPlace; //百位
@property (nonatomic,assign) NSInteger          tendPlace;//十位
@property (nonatomic,assign) NSInteger          digitPlace;//个位

@property (nonatomic,assign) NSInteger          consumeK; //消耗多少卡
@end
