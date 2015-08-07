//
//  BluetoothDataManager.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/6.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BluetoothDataManager.h"

@interface BluetoothDataManager (){
    
    int count ;
}

@end
@implementation BluetoothDataManager


-(Bicyle *)bicyleModel{
    if (_bicyleModel == nil) {
        _bicyleModel = [[Bicyle alloc] init];
    }
    return _bicyleModel;
}

-(instancetype)initWithBlueToothData:(NSString *)dataString{
    
    self =  [super init];
    if (self) {
        count = 0;
        //TODO:.....
        if([[dataString lowercaseString] isEqualToString:@"da"]){
            NSLog(@"外围设备关闭了!");
        }
        
        if (dataString.length < 20){
            return self;
        }
        
        
        
        //TODO: 有新数据接收时.
        NSLog(@"======================================");
        
        NSLog(@"%@,长度%lu",dataString,(unsigned long)dataString.length);
        
        NSRange cmdRang = NSMakeRange(0, 6);
        NSString * cmdStr = [[dataString substringWithRange:cmdRang] lowercaseString];
        
        if([cmdStr isEqualToString:@"5a0ee5"] && dataString.length == 32){
            
            cmdStr = [[dataString substringWithRange:NSMakeRange(6, 4)] lowercaseString];
            
          //   NSLog(@"时间  %@",cmdStr );
//            self.bicyleModel.cost_time = [self getTenHexadecimalFromSixteen:cmdStr] ;
            self.bicyleModel.cost_time = [self getTimes:cmdStr];
            
            cmdStr = [[dataString substringWithRange:NSMakeRange(10, 4)] lowercaseString];
            self.bicyleModel.speed = [self getTenHexadecimalFromSixteen:cmdStr] ;
                    NSLog(@"速度 %@  %ld",cmdStr,self.bicyleModel.speed );

            cmdStr = [[dataString substringWithRange:NSMakeRange(14, 6)] lowercaseString];
            self.bicyleModel.distance = [self getTenHexadecimalFromSixteen:cmdStr] ;
                    NSLog(@"距离 %@  %ld",cmdStr, self.bicyleModel.distance);

            cmdStr = [[dataString substringWithRange:NSMakeRange(20, 4)] lowercaseString];
            
            self.bicyleModel.calorie = [self getTenHexadecimalFromSixteen:cmdStr] ;
            NSLog(@"热量 %@  %ld",cmdStr,self.bicyleModel.calorie );

            cmdStr = [[dataString substringWithRange:NSMakeRange(24, 4)] lowercaseString];
            self.bicyleModel.total_distance = [self getTenHexadecimalFromSixteen:cmdStr] ;
            NSLog(@"总程 %@ %ld",cmdStr, self.bicyleModel.total_distance);

            
            cmdStr = [[dataString substringWithRange:NSMakeRange(28, 2)] lowercaseString];
          
//            5a0ee5 6231 0a45 002329 001e00000033
            
            self.bicyleModel.heart_rate = [self getTenHexadecimalFromSixteen:cmdStr] ;
                    NSLog(@"心率 %@ %ld",cmdStr, self.bicyleModel.heart_rate );

            cmdStr = [[dataString substringWithRange:NSMakeRange(30, 2)] lowercaseString];
            //        NSLog(@"校验和 %@",cmdStr);
            _checksum = [self getTenHexadecimalFromSixteen:cmdStr] ;
            
            
            //        NSLog(@"data = %@",data);
            //        [self.descData addObject:data];
            //        NSDateFormatter * formatter = [NSDate defaultDateFormatter ];
            //
            //        NSString * curDateString = [formatter stringFromDate:[NSDate defaultCurrentDate]];
            //        
            //        self.tvLog.text  = [self.tvLog.text stringByAppendingFormat:@"\n %@: %@",curDateString,data ];
            //        
            //        NSLog(@"======================================");
            
        }
        

    }
    
    return self;
}

-(NSInteger)  getTenHexadecimalFromSixteen:(NSString *)hexstring {
  
    UInt64 num =  strtoul([hexstring UTF8String], 0, 16);
    
    return  (NSInteger)num;
    
}

//获得时间
-( NSInteger) getTimes:(NSString * )cmdStr {
   
    NSString * minstr =  [cmdStr substringToIndex:2];
    NSString * scnstr = [cmdStr substringFromIndex:2];
    NSInteger  min = [self getTenHexadecimalFromSixteen:minstr];
    NSInteger  scn = [self getTenHexadecimalFromSixteen: scnstr];
    NSLog(@" -  hour- %@ %ld -min- %@- %ld ",minstr,min,scnstr,scn);

    return min * 60 + scn;
}

//获得路程
-(NSInteger) getDistance:(NSString *)cmdStr{
    
    NSString * minstr =  [cmdStr substringToIndex:2];
    NSString * scnstr = [cmdStr substringFromIndex:2];
    NSInteger  min = [self getTenHexadecimalFromSixteen:minstr];
    NSInteger  scn = [self getTenHexadecimalFromSixteen: scnstr];
    NSLog(@" -  hour- %@ %ld -min- %@- %ld ",minstr,min,scnstr,scn);

    return min *100 + scn;
}

-(NSInteger) getsubString:(NSString *) dataString index:(NSInteger)index length:(NSInteger)length{

    
   NSString *  cmdStr = [[dataString substringWithRange:NSMakeRange(index, length)] lowercaseString];
    
    return [self getTenHexadecimalFromSixteen:cmdStr];
}


@end
