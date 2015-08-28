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

-(instancetype)init{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

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
            DLog(@"外围设备关闭了!");
        }
        
        if (dataString.length < 20){
            return self;
        }
        
        [self handleBluetoothData:dataString];

    }
    
    return self;
}

//处理数据
-(void) handleBluetoothData:(NSString *)dataString{
    
    
    //TODO: 有新数据接收时.
//    DLog(@"======================================");
    DLog(@" DEBUG= 获取到的数据=  %@",dataString);
    
   // DLog(@"%@,长度%lu",dataString,(unsigned long)dataString.length);
    
    NSRange cmdRang = NSMakeRange(0, 6);
    NSString * cmdStr = [[dataString substringWithRange:cmdRang] lowercaseString];
    
    if([cmdStr isEqualToString:@"5a0ee5"] && dataString.length == 32){
        
        //时间
        cmdStr = [[dataString substringWithRange:NSMakeRange(6, 4)] lowercaseString];
        //   DLog(@"时间  %@",cmdStr );
        self.bicyleModel.cost_time = [self getTimes:cmdStr];
        
        //速度
        cmdStr = [[dataString substringWithRange:NSMakeRange(10, 4)] lowercaseString];
        self.bicyleModel.speed = [self getTenHexadecimalFromSixteen:cmdStr] ;
//        DLog(@"速度 %@  %ld",cmdStr,self.bicyleModel.speed );
        
        //距离；
        cmdStr = [[dataString substringWithRange:NSMakeRange(14, 6)] lowercaseString];
        self.bicyleModel.distance = [self getDistance:cmdStr] ;
//        DLog(@"距离 %@  %ld",cmdStr, self.bicyleModel.distance);
        
        //热量
        cmdStr = [[dataString substringWithRange:NSMakeRange(20, 4)] lowercaseString];
        self.bicyleModel.calorie = [self getTenHexadecimalFromSixteen:cmdStr] ;
        DLog(@"=========热量 %@  %ld==========",cmdStr,self.bicyleModel.calorie );
        
        //总程
        cmdStr = [[dataString substringWithRange:NSMakeRange(24, 4)] lowercaseString];
        //            self.bicyleModel.total_distance = [self getTenHexadecimalFromSixteen:cmdStr] ;
        self.bicyleModel.total_distance = [self getTotalDistance:cmdStr];
//        DLog(@"总程 %@ %ld",cmdStr, self.bicyleModel.total_distance);
        
        //心率
        cmdStr = [[dataString substringWithRange:NSMakeRange(28, 2)] lowercaseString];
        self.bicyleModel.heart_rate = [self getTenHexadecimalFromSixteen:cmdStr] ;
//        DLog(@"心率 %@ %ld",cmdStr, self.bicyleModel.heart_rate );
        
        //效验
        cmdStr = [[dataString substringWithRange:NSMakeRange(30, 2)] lowercaseString];
        //        DLog(@"校验和 %@",cmdStr);
        _checksum = [self getTenHexadecimalFromSixteen:cmdStr] ;
        
        long sum = self.bicyleModel.heart_rate + self.bicyleModel.total_distance + self.bicyleModel.distance + self.bicyleModel.calorie +self.bicyleModel.speed+self.bicyleModel.cost_time;
        
        sum = (sum+229) % 255;
        sum = sum-1;
//        NSString *hexString = [[NSString alloc] initWithFormat:@"%1x",sum];
        
        DLog("检验是否通过=%ld,%ld",sum,(long)_checksum);
        if(sum != _checksum){
            self.bicyleModel.isMisdata = YES;
        }else{
            self.bicyleModel.isMisdata = NO;
        }
        //        DLog(@"data = %@",data);
        //        [self.descData addObject:data];
        //        NSDateFormatter * formatter = [NSDate defaultDateFormatter ];
        //
        //        NSString * curDateString = [formatter stringFromDate:[NSDate defaultCurrentDate]];
        //
        //        self.tvLog.text  = [self.tvLog.text stringByAppendingFormat:@"\n %@: %@",curDateString,data ];
        //
        //        DLog(@"======================================");
        
    }
    
    
}

-(NSInteger)  getTenHexadecimalFromSixteen:(NSString *)hexstring {
  
    UInt64 num =  strtoul([hexstring UTF8String], 0, 16);
    
    return  (NSInteger)num;
    
}

//获得时间
-( NSInteger) getTimes:(NSString * )cmdStr {
   
    NSInteger  min = [self getsubString:cmdStr index:0 length:2];
    NSInteger  scn = [self getsubString:cmdStr index:2 length:2];
   // DLog(@" -  hour- %ld -min-%ld  ",min,scn);

    return min * 60 + scn;
}

//获得路程
-(NSInteger) getDistance:(NSString *)cmdStr{
    
    NSInteger  roundnum = [self getsubString:cmdStr index:2 length:2];
    NSInteger  fraction = [self getsubString:cmdStr index:4 length:2];
    return roundnum *100 + fraction;
}

//获得总路程
-(NSInteger) getTotalDistance:(NSString *)cmdStr{
    
    NSInteger  roundnum = [self getsubString:cmdStr index:0 length:2];
    NSInteger  fraction = [self getsubString:cmdStr index:2 length:2];
    return roundnum *100 + fraction;
}

//获得字符串的指定位置并转化为字符串 ，
-(NSInteger) getsubString:(NSString *) dataString index:(NSInteger)index length:(NSInteger)length{

   NSString *  cmdStr = [[dataString substringWithRange:NSMakeRange(index, length)] lowercaseString];
    
    return [self getTenHexadecimalFromSixteen:cmdStr];
}


@end
