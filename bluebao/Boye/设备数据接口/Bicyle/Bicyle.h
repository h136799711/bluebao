//
//  Bicyle.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bicyle : NSObject

@property (nonatomic,assign) NSInteger          uid;
@property (nonatomic,copy) NSString             *uuid;//设备id
//@property (nonatomic,assign) long long          time;

@property (nonatomic,assign) CGFloat        speed;
@property (nonatomic,assign) CGFloat        heart_rate;
@property (nonatomic,assign) CGFloat        distance;
@property (nonatomic,assign) CGFloat        total_distance;
@property (nonatomic,assign) CGFloat        cost_time;
@property (nonatomic,assign) CGFloat        calorie;
@property (nonatomic,assign) CGFloat        upload_time;  //时间戳
@end
