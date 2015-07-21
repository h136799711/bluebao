//
//  LNowDevice.h
//  Bluetooth
//
//  Created by hebidu on 15/7/10.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreBluetooth;

@interface LNowDevice : NSObject
//<NSCoding>

/* ADDataServiceUUIDs */

/* 设备名称 */
@property (nonatomic,readonly)NSString * name;

/* 设备UUID */
@property (nonatomic,readonly)NSString * uuid;

/* 设备rssi信号 */
@property (nonatomic)NSNumber* rssi;

@property (nonatomic,readonly) CBPeripheral *peripheral;

/* 链接状态 */
@property (nonatomic,readonly) CBPeripheralState state;

/**
 *  设备包含的服务
 */
@property (nonatomic , strong) NSMutableArray *service;

/**
 *  设备包含的特征
 */
@property (nonatomic , strong) NSMutableArray *character;



- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral;
- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral withRssi:(NSNumber *)rssi;

//@property (nonatomic,readonly)NSNumber *dataLocalName;

//NSLog(@"设备CBAdvertisementDataLocalNameKey= %@",[advertisementData valueForKey:CBAdvertisementDataLocalNameKey]);
//NSLog(@"设备CBAdvertisementDataManufacturerDataKey= %@",[advertisementData valueForKey:CBAdvertisementDataManufacturerDataKey]);
//NSLog(@"设备CBAdvertisementDataServiceDataKey= %@",[advertisementData valueForKey:CBAdvertisementDataServiceDataKey]);
//
//NSLog(@"设备CBAdvertisementDataServiceUUIDsKey= %@",[advertisementData valueForKey:CBAdvertisementDataServiceUUIDsKey]);
//NSLog(@"设备CBAdvertisementDataOverflowServiceUUIDsKey= %@",[advertisementData valueForKey:CBAdvertisementDataOverflowServiceUUIDsKey]);
//NSLog(@"设备CBAdvertisementDataTxPowerLevelKey= %@",[advertisementData valueForKey:CBAdvertisementDataTxPowerLevelKey]);
//NSLog(@"设备CBAdvertisementDataIsConnectable= %@",[advertisementData valueForKey:CBAdvertisementDataIsConnectable]);
//NSLog(@"设备CBAdvertisementDataSolicitedServiceUUIDsKey= %@",[advertisementData valueForKey:CBAdvertisementDataSolicitedServiceUUIDsKey]);


@end
