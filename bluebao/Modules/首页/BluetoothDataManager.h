//
//  BluetoothDataManager.h
//  bluebao
//
//  Created by boye_mac1 on 15/8/6.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BluetoothDataManager : NSObject


//校验值
@property (nonatomic) NSInteger checksum;

@property (nonatomic,strong) Bicyle  * bicyleModel;

-(instancetype)initWithBlueToothData:(NSString *)dataString;

@end
