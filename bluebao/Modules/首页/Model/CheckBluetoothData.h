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
@property (nonatomic,assign) BOOL       isOutTime;

/**
 *检查后返回的蓝牙数据
 */
@property (nonatomic,strong) BluetoothDataManager * bluetoothData;

/**
 *上次可用蓝牙数据
 */

@property (nonatomic,strong) BluetoothDataManager * lastUsableData;

/*
 * 蓝牙数据检查
 *
 * return  有效的蓝牙数据
 */

//-(BluetoothDataManager *) bluetoothDataCheck:(BluetoothDataManager *) blueData;

/*
 * 检查蓝牙数据的可用性
 */
-(BOOL) checkBluetoothDataUsable:(BluetoothDataManager *) blueData;

//检查数据可用
+(BOOL) checkDataUsable:(BluetoothDataManager * )blueData;

@end
