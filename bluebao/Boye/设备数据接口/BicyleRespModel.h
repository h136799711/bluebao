//
//  BicyleRespModel.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BicyleRespModel : NSObject

@property (nonatomic,assign) NSInteger          uid;
@property (nonatomic,copy) NSString             *uuid;//设备id
@property (nonatomic,assign) long long          time;


@end


/*
 calorie = 0;
 "cost_time" = 0;
 distance = 0;
 "heart_rate" = 0;
 speed = 0;
 "total_distance" = 0;
 "upload_time" = 0;
 **/
//数据下载返回数据
