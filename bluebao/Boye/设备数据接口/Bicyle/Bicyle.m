//
//  Bicyle.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "Bicyle.h"

@implementation Bicyle

//-(instancetype)

-(id)initWithBicyleRespDic:(NSDictionary *)dictionary{
    
    self = [super init];
    if (self) {
  
        _bicyDeata_id = [[dictionary valueForKey:@"id"] integerValue];  //数据id
        _uuid = [dictionary valueForKey:@"uuid"];

        _calorie = [[dictionary valueForKey:@"calorie"] integerValue];
        _cost_time =    [[dictionary valueForKey:@"cost_time"] integerValue];
        _distance =    [[dictionary valueForKey:@"distance"] integerValue];
        _heart_rate =    [[dictionary valueForKey:@"heart_rate"] integerValue];
        _speed =    [[dictionary valueForKey:@"speed"] integerValue];
        _upload_time =    [[dictionary valueForKey:@"upload_time"] integerValue];
        _total_distance = [[dictionary valueForKey:@"total_distance"] integerValue];

    }
    return self;
}

@end

//-(NSInteger)getStringToINteger:(NSString *)integerString{
//
//    
//}