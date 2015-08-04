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

@property (nonatomic,assign) NSInteger        speed;
@property (nonatomic,assign) NSInteger        heart_rate;
@property (nonatomic,assign) NSInteger        distance;
@property (nonatomic,assign) NSInteger        total_distance;
@property (nonatomic,assign) NSInteger        cost_time;
@property (nonatomic,assign) NSInteger        calorie;
@property (nonatomic,assign) NSInteger        upload_time;  //时间戳

-(id)initWithBicyleRespDic:(NSDictionary *)dictionary;
@end
