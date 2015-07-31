//
//  DeviceInfoControllerViewController.h
//  Bluetooth
//
//  Created by hebidu on 15/7/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNowDevice.h"
#import "LNowBicyleData.h"
#import "ButtonFactory.h"
#import "BoyeBluetooth.h"

@import CoreBluetooth;

@interface DeviceInfoViewController : BoyeLeftBaseVC<BOYEBluetoothStateChangeDelegate>

/**
 *  设置当前准备操作的设备
 *
 *  @param device 设备描述
 */
-(void)setDevice:(LNowDevice *) device;

//在连接以及获取数据过程中出现错误时调用
-(void)errorHandler:(NSError *)error;

@end
