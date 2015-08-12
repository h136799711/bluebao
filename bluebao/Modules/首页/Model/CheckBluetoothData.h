//
//  CheckBluetoothData.h
//  bluebao
//
//  Created by boye_mac1 on 15/8/12.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluetoothDataManager.h"
@interface CheckBluetoothData : NSObject

/**
 * 蓝牙数据是否可用
 **/
@property (nonatomic,assign) BOOL       isUsable;


/**
 *检查后返回的蓝牙数据
 *
 */
@property (nonatomic,assign) BluetoothDataManager * bluetoothData;

/**
 *
 *
 */

@property (nonatomic,assign) BluetoothDataManager * lastUsableData;

/*
 * 蓝牙数据检查
 *
 * return  有效的蓝牙数据
 */

-(BluetoothDataManager *) bluetoothDataCheck:(BluetoothDataManager *) blueData;

@end
