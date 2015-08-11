//
//  LBSportShareModel.h
//  bluebao
//
//  Created by boye_mac1 on 15/8/11.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBSportShareModel : NSObject

/* 运动步数
 * step   ,运动多少步
 */

@property (nonatomic,assign)  NSInteger         step;  //运动了多少步

/* 运动距离
 * step   ,运动多少步
 */
@property (nonatomic,assign) CGFloat          distance;  //运动了多少公里
/* 运动消耗
 * step   ,运动多少步
 */
@property (nonatomic,assign) CGFloat          calorie; //消耗了多少卡

/*
 *单例
 */
+(LBSportShareModel *) sharedLBSportShareModel;

@end
