//
//  LNowBicyleData.h
//  Bluetooth
//
//  Created by hebidu on 15/7/14.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNowBicyleData : NSObject

//热量
@property (nonatomic)NSInteger quantityOfHeat;
//心率
@property (nonatomic)NSInteger heartRate;
//本次距离
@property (nonatomic)NSInteger distance;
//总距离
@property (nonatomic)NSInteger totalDistance;
//使用时间
@property (nonatomic)NSInteger spendTime;
//速度
@property (nonatomic)NSInteger speed;
//校验值
@property (nonatomic) NSInteger checksum;

@end
