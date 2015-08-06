//
//  BluetoothDataManager.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/6.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BluetoothDataManager.h"

@interface BluetoothDataManager (){
    
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
            
            self.bicyleModel.cost_time = [self getTenHexadecimalFromSixteen:cmdStr] ;
            
            cmdStr = [[dataString substringWithRange:NSMakeRange(10, 4)] lowercaseString];
            //        NSLog(@"速度 %@",cmdStr);
            self.bicyleModel.speed = [self getTenHexadecimalFromSixteen:cmdStr] ;
            
            cmdStr = [[dataString substringWithRange:NSMakeRange(14, 6)] lowercaseString];
            //        NSLog(@"距离 %@",cmdStr);
            self.bicyleModel.distance = [self getTenHexadecimalFromSixteen:cmdStr] ;
            
            cmdStr = [[dataString substringWithRange:NSMakeRange(20, 4)] lowercaseString];
            //        NSLog(@"热量 %@",cmdStr);
            self.bicyleModel.calorie = [self getTenHexadecimalFromSixteen:cmdStr] ;
            
            cmdStr = [[dataString substringWithRange:NSMakeRange(24, 4)] lowercaseString];
            //        NSLog(@"总程 %@",cmdStr);
            self.bicyleModel.total_distance = [self getTenHexadecimalFromSixteen:cmdStr] ;
            
            
            cmdStr = [[dataString substringWithRange:NSMakeRange(28, 2)] lowercaseString];
          
          
            //        NSLog(@"心率 %@",cmdStr);
            self.bicyleModel.heart_rate = [self getTenHexadecimalFromSixteen:cmdStr] ;
            
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
    
    NSLog(@"  ----蓝牙数据- %llu-",num);

    return  (NSInteger)num;
    

}
@end
