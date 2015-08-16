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
        if ([dictionary count] == 0) {
            _bicyDeata_id = 0;  //数据id
            _uuid = 0;
            _calorie =0;
            _cost_time =    0;
            _distance =   0;
            _heart_rate =    0;
            _speed =   0;
            _upload_time =   0;
            _total_distance = 0;
            _target_calorie = DEFAULT_GOAL;
        }else{
        _bicyDeata_id = [[dictionary valueForKey:@"id"] integerValue];  //数据id
        _uuid = [dictionary valueForKey:@"uuid"];
        _calorie = [[dictionary valueForKey:@"calorie"] integerValue];
        _cost_time =    [[dictionary valueForKey:@"cost_time"] integerValue];
        _distance =    [[dictionary valueForKey:@"distance"] integerValue];
        _heart_rate =    [[dictionary valueForKey:@"heart_rate"] integerValue];
        _speed =    [[dictionary valueForKey:@"speed"] integerValue];
        _upload_time =    [[dictionary valueForKey:@"upload_time"] integerValue];
        _total_distance = [[dictionary valueForKey:@"total_distance"] integerValue];
        _target_calorie = [[dictionary valueForKey:@"target_calorie" ] integerValue];
        }
    }
    return self;
}

-(void)setUuid:(NSString *)uuid{
    
    if (uuid == nil) {
        _uuid = @"";
    }
    _uuid = uuid;
}
@end

//-(NSInteger)getStringToINteger:(NSString *)integerString{
//
//    
//}