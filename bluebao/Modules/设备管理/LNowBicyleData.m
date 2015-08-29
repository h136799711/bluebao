//
//  LNowBicyleData.m
//  Bluetooth
//
//  Created by hebidu on 15/7/14.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "LNowBicyleData.h"
@interface LNowBicyleData()




@end
    


@implementation LNowBicyleData

-(NSString *)description{
    
    return  [[NSString alloc]initWithFormat:@"总程:%ld , 热量:%ld ,距离: %ld ,速度:%ld 时间:%ld 心率: %ld",(long)self->_totalDistance,(long)self->_quantityOfHeat,(long)self->_distance,(long)self->_speed,(long)self->_spendTime,(long)self->_heartRate];
    
    
}

@end
