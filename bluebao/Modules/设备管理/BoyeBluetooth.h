//
//  BoyeBluetooth.h
//  Bluetooth
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNowDevice.h"
#import "CacheFacade.h"

@import CoreBluetooth;

/**
 蓝牙相关状态事件
 */
enum BOYE_BLUETOOTH_STATE_EVENT{
    
    /**
     *  蓝牙状态改变，蓝牙关闭了、无效了等
     */
    STATE_CHANGE=1,
    
    /**
     *  发现一台外围蓝牙设备
     */
    STATE_DISCOVERED_DEVICE,
    
    /**
     *  发现服务
     */
    STATE_DISCOVERED_SERVICE,
    
    /**
     *  发现服务的特征
     */
    STATE_DISCOVERED_CHARACTERISTICS,
    
    /**
     *  特征的值更新了
     */
    STATE_UPDATE_VALUE,
    
    /**
     *  连接上一台设备
     */
    STATE_CONNECTED_DEVICE,
    
    /**
     *  断开一台设备
     */
    STATE_DISCONNECT_DEVICE,
    
    /**
     *  连接设备失败
     */
    STATE_FAIL_TO_CONNECT_DEVICE,
    
};


/**
 *  蓝牙状态变更委托
 */
@protocol BOYEBluetoothStateChangeDelegate <NSObject>

@required

- (void)bluetoothStateChange:(id)sender :(enum BOYE_BLUETOOTH_STATE_EVENT)stateEvent :(id)parms;

@end

@interface BoyeBluetooth : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

/**
 *  当前设备蓝牙状态
 */
@property (nonatomic) CBCentralManagerState state;

/**
 *  扫描到的设备
 *
 *  @param nonatomic nonatomic
 *  @param strong    strong
 *
 *  @return 扫描到的设备
 */
@property (nonatomic , strong) NSMutableArray *peripherals;

/**
 *  蓝牙状态发生改变时调用
 */
@property (nonatomic, weak) id <BOYEBluetoothStateChangeDelegate> delegate;


/**
 *  单例
 *
 *  @return <#return value description#>
 */
+(BoyeBluetooth *)sharedBoyeBluetooth;

/**
 *  当前连接的设备\最近一次连接的设备
 *
 *  @return 当前连接的设备
 */
- (LNowDevice *) connectedDevice;

/**
 *  蓝牙中心设备
 *
 *  @return 蓝牙中心设备
 */
- (CBCentralManager*)cbCentralManager;
/**
 *  添加一个新设备，如果存在则覆盖。
 */
-(void)addDevice:(LNowDevice *)device;
-(BOOL) avaliable;
/**
 *  扫描设备
 */
- (void)startScanDevice;

/**
 *  停止扫描设备
 */
- (void)stopScanDevice;

/**
 *  连接一台设备,根据uuid
 *
 *  @param uuid 连接一台设备,根据uuid
 */
- (void)connectDevice:(LNowDevice *)device;

/**
 *
 *  监听一个特征，若有消息可以通过委托事件
 * STATE_UPDATE_VALUE
 *
 *  @param uuid 特征的UUID字符串
 */
- (void)listenningCharacteristic:(NSString *)uuid;

/**
 *
 *  搜索指定服务的特征
 *
 *  @param uuid 服务的UUID 字符串
 */
- (void)discoverCharacteristic:(NSString *)uuid;

/**
 *
 *  搜索指定服务
 *
 *  @param uuid 服务的UUID 字符串集合
 */
- (void)discoverServices:(NSArray *)uuids;

/**
 *  是否上次连接过的设备
 *
 *  @return YES | NO
 */
-(BOOL)isLastConnectedDevice:(LNowDevice *)device;

@end
