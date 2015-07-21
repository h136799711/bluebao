//
//  DeviceBindController.h
//  Bluetooth
//
//  Created by hebidu on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoyeBluetooth.h"
#import "PulsingRadarView.h"
#import "LNowDevice.h"
#import "DeviceInfoViewController.h"
#import "ButtonFactory.h"
#import "DeviceInfoCell.h"

@import CoreBluetooth;


@interface DeviceBindController : BoyeBluetoothBaseVC<BOYEBluetoothStateChangeDelegate,UITableViewDelegate,UITableViewDataSource>

//已缓存的UUID 数组
@property (strong,nonatomic) NSMutableArray * bindDeviceUUIDs;

@end
