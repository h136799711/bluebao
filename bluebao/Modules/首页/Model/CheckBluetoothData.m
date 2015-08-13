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

-(BluetoothDataManager *)lastUsableData{
    if (_lastUsableData == nil) {
        _lastUsableData = [[BluetoothDataManager alloc] init];
    }
    return _lastUsableData;
}
///  数据可用，如果out ，set，  不可用，out ，在，有效期之后，传什么，书神马

-(BOOL) checkBluetoothDataUsable:(BluetoothDataManager *) blueData{
    
    if (blueData.bicyleModel.calorie != 0) {
        
        NSLog(@" 数据可用 ");

            [self setOutDate];

        return YES;
        
    }else{      //数据不合理，
        
        if ([self get] == nil) {  //过期，或没有缓存，

            self.isOutTime = YES;
            
            NSLog(@" 数据不可用，不在有效时间范围内 ");

        }else{
          
            self.isOutTime = NO;
            NSLog(@" 数据不可用，在有效时间范围内 ");
        }
    }
    return NO;
}




//  类方法
+(BOOL) checkDataUsable:(BluetoothDataManager * )blueData{
    
   return  [[self alloc] checkBluetoothDataUsable:blueData];
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
