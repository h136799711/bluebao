//
//  CheckBluetoothData.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/12.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "CheckBluetoothData.h"

@implementation CheckBluetoothData

-(instancetype) init{
    
    self = [super init];
    if (self) {
        
    }
    return self;
}


///  数据可用，如果out ，set，  不可用，out ，在，有效期之后，

-(BOOL) checkBluetoothDataUsable:(BluetoothDataManager *) blueData{
    
//    BOOL ret = YES;
    
    if( [self get] == nil ){
        
//        ret = YES;
        
        [self setOutDate];
        return YES;
    }
       
    
    if (blueData.bicyleModel.calorie == 0
               && blueData.bicyleModel.distance == 0
               && blueData.bicyleModel.heart_rate == 0
    ) {
               return  NO;
    }
    
  
    
    [self setOutDate];
    
    return YES;

//  类方法
+(BOOL) checkDataUsable:(BluetoothDataManager * )blueData{
    
   return  [[self alloc] checkBluetoothDataUsable:blueData];
}
//数据是否为 0
-(BOOL) isDataNull:(NSInteger)datanum {
    if (datanum== 0) {
        return YES;
    }
    return NO;
}

-(BOOL) isSettingTimeOut{
    
    if ([self get]== nil ) {
        
        self.isOutTime = YES;
        NSLog(@" 数据不可用，不在有效时间范围内 ");

        return YES;
    }else{
        
        self.isOutTime = NO;
        NSLog(@" 数据不可用，在有效时间范围内 ");
        return NO;
    }
}

//设置时间段 、时间段内 返回上一个数据 ，过了时间，返回
-(void)  setOutDate{
    
    [[CacheFacade sharedCache] setObject:[self timeDateOutstr] forKey:[self timeDateOutKey] afterSeconds:8];
    
}

-(NSString *) get {
  return  [[CacheFacade sharedCache] get:[self timeDateOutKey]];
}

-(NSString *) timeDateOutstr{
    return @"isOut";
}

-(NSString *)timeDateOutKey{
    
    return @"dataIsout";
}
@end
