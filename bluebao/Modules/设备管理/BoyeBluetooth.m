//
//  BoyeBluetooth.m
//  Bluetooth
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeBluetooth.h"

@interface BoyeBluetooth ()
{
}


@property (nonatomic,strong) CBCentralManager *cbCentralManager;

//当前连接的peripheral
@property (nonatomic,strong) LNowDevice *connectedDevice;

@property(nonatomic) CBService* intrestService;

@property(nonatomic,copy)NSString * lastConnectedDeviceUUID;

@end



@implementation BoyeBluetooth

@synthesize peripherals = _peripherals;

- (NSString *) lastConnectedDeviceUUID{
    
    if(_lastConnectedDeviceUUID == nil){
        _lastConnectedDeviceUUID = [[CacheFacade sharedCache] get:@"lastConnectedDeviceUUID"];
    }
    
    return _lastConnectedDeviceUUID;
}

#pragma mark 构造函数
+ (BoyeBluetooth *)sharedBoyeBluetooth
{
    static BoyeBluetooth *sharedBoyeBluetoothInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedBoyeBluetoothInstance = [[self alloc] init];
    });
    
    return sharedBoyeBluetoothInstance;
}

- (id)init{
    
    if(self =[super init]){
        DLog(@"BoyeBluetooh初始化");
        self.cbCentralManager = [[CBCentralManager alloc] initWithDelegate:self
                                                                     queue:nil];
        self.peripherals = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}

-(void)setLastConnectDeviceUUID:(NSString *)uuid{
   [[CacheFacade sharedCache] setObject:uuid forKey:@"lastConnectedDeviceUUID"];
}

#pragma mark 属性getter

-(LNowDevice *)connectedDevice{
    return _connectedDevice;
}

#pragma  mark 公开操作方法实现


-(BOOL)isLastConnectedDevice:(LNowDevice *)device{
    if(self.lastConnectedDeviceUUID != nil && [device.uuid isEqualToString:self.lastConnectedDeviceUUID]){
        return YES;
    }
    return NO;
}

-(void)addDevice:(LNowDevice *)device{
    
    for (int i=0; i< [self.peripherals count]; i++) {
        
        LNowDevice * tmpDevice =  self.peripherals[i];
        if( [tmpDevice.uuid isEqualToString:device.uuid]){
            [self.peripherals removeObjectAtIndex:i];
            break;
        }
    }
    
    [self.peripherals addObject:device];
    
}

- (void)connectDevice:(LNowDevice *)device{
    DLog(@"连接设备=%@",device);
    
    DLog(@"peripherals=%@",self.peripherals);
    for (int i=0; i< [self.peripherals count]; i++) {
        
        LNowDevice * device = (LNowDevice *)self.peripherals[i];
        
        if([device.uuid isEqualToString:device.uuid]){
            
            //缓存到本地
            [self setLastConnectDeviceUUID:device.uuid];
            
            self.connectedDevice= device;
            //连接时重置数据
            self.connectedDevice.service = nil;
            self.connectedDevice.character = nil;
            
            [[CacheFacade sharedCache] setObject:device.uuid forKey:@"UUID"];
            
            DLog(@"准备连接设备：%@",device.peripheral);
            if(device.peripheral == nil){
                DLog(@"无法连接设备！设备对象不能为nil");
                break;
            }
            [self.cbCentralManager connectPeripheral:device.peripheral options:nil];
            break;
        }else{
            self.connectedDevice = nil;
        }
        
    }
}
- (void)startScanDevice{
    
    if(self.cbCentralManager.state == CBCentralManagerStatePoweredOn){
        [self.cbCentralManager scanForPeripheralsWithServices:nil options:nil];
    }else{
       
    }
    
}

-(BOOL) avaliable{
    
     return [self alertStateDescIfNeed:self.cbCentralManager.state];
    
}

- (void)stopScanDevice{
    DLog(@"bluetooth call stopScanDevice");
    if(self.cbCentralManager.state == CBCentralManagerStatePoweredOn){
        [self.cbCentralManager stopScan];
    }
}

-(void)discoverServices:(NSArray *)uuids{
    DLog(@"蓝牙开始搜索服务:%@",uuids);
    [self.connectedDevice.peripheral discoverServices:uuids];
    DLog(@"当前连接的设备:%@",self.connectedDevice);

}

-(void)discoverCharacteristic:(NSString *)serviceUuid{
    
    for (CBService* service in self.connectedDevice.service) {
        if([service.UUID.UUIDString isEqualToString:serviceUuid]){
            [self.connectedDevice.peripheral discoverCharacteristics:nil forService:service];
            break;
        }
    }
    
}

-(void)listenningCharacteristic:(NSString *)uuid{
    for (CBCharacteristic *characteristic in self.connectedDevice.character) {
        if([characteristic.UUID.UUIDString isEqualToString:uuid]){
            CBCharacteristicProperties  prop = characteristic.properties;
            
            if( ( prop & CBCharacteristicPropertyRead) == CBCharacteristicPropertyRead){
                
                [self.connectedDevice.peripheral readValueForCharacteristic:characteristic];
            }
            
            if((prop & CBCharacteristicPropertyNotify) == CBCharacteristicPropertyNotify){
                [self.connectedDevice.peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
        
        }
    }
}


#pragma mark  -- 辅助私有方法
/**
 *  弹出蓝牙提示框如果需要的话
 *
 *  @param state 蓝牙状态
 */
-(BOOL)alertStateDescIfNeed:(CBCentralManagerState)state{
    
    NSString  *desc;
    BOOL needAlert = true;
    switch (state) {
        case CBCentralManagerStatePoweredOff:
//            desc = @"当前设备未开启蓝牙";
            desc = @"请开启设备的蓝牙功能!";
            break;
            
        case CBCentralManagerStatePoweredOn:
        {
            needAlert = false;
            desc = @"设备已开启蓝牙且可用";
        }
            break;
            
        case CBCentralManagerStateResetting:
            desc = @"当前蓝牙连接重置了";
            break;
            
        case CBCentralManagerStateUnauthorized:
            desc = @"请允许APP访问设备蓝牙功能";
            break;
            
        case CBCentralManagerStateUnknown:
            desc = @"未知蓝牙状态";
            break;
            
        default:
            desc = @"请换一台支持蓝牙4.0的设备";
            
            break;
    }
    
    DLog(@"中心设备当前状态=%@",desc);
    if(needAlert){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统消息"
                                                        message:desc delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [self stopScanDevice];
    }
    
    return !needAlert;
}

#pragma mark -- CBPeripheralDelegate
//xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/CoreBluetooth/Reference/CBPeripheral_Class/index.html#//apple_ref/occ/cl/CBPeripheral

//发现服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    DLog(@"发现了外围设备的一个服务: %@", peripheral.services);
    
    for (CBService *service in peripheral .services) {
        
//        NSString * uuidString = service.UUID.UUIDString;
//        DLog(@"发现了服务: %@", uuidString);
        [self.connectedDevice.service addObject:service];
        
    }
    
 
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc]initWithObjects:@[peripheral] forKeys:@[@"data"]];
    
    if(error != nil){
        [info setObject:error forKey:@"error"];
    }
    
    
    [self.delegate bluetoothStateChange:self :STATE_DISCOVERED_SERVICE :info];
    
}

//
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    DLog(@"获取到Service的UUID:%@", service.UUID);
    
    DLog(@"发现了外围设备的服务提供的特征: %@", service.characteristics);
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        
//        CBCharacteristicProperties prop =  characteristic.properties;
        //TODO: 手动连接
//        if(prop & CBCharacteristicPropertyNotify){
//            DLog(@"setNotifyValue");
//            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//        }
//        if(prop & CBCharacteristicPropertyRead){
//            DLog(@"read");
//            [peripheral readValueForCharacteristic:characteristic];
//        }
        
        [self.connectedDevice.character addObject:characteristic];
    }
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc]initWithObjects:@[service] forKeys:@[@"data"]];
    
    if(error != nil){
        [info setObject:error forKey:@"error"];
    }
    
    [self.delegate bluetoothStateChange:self :STATE_DISCOVERED_CHARACTERISTICS :info];
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    if (error) {
        DLog(@"Error changing notification state: %@",[error localizedDescription]);
        DLog(@"Error%@",error);
    }
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc]initWithObjects:@[characteristic] forKeys:@[@"data"]];
    
    if(error != nil){
        [info setObject:error forKey:@"error"];
    }
    [self.delegate bluetoothStateChange:self :STATE_UPDATE_VALUE :info];
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    DLog(@"数据变化了通知消息");
    
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc]initWithObjects:@[characteristic] forKeys:@[@"data"]];
    
    if(error != nil){
        [info setObject:error forKey:@"error"];
    }
    [self.delegate bluetoothStateChange:self :STATE_UPDATE_VALUE :info];
    
}

#pragma  mark -- CBCentralManagerDelegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    DLog(@"中心设备更新状态了");
    self.state = central.state;
    
    [self.delegate bluetoothStateChange:self :STATE_CHANGE :nil];
}

//连接上一台设备
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    DLog(@"中心设备连接上一台设备: %@",peripheral);
    DLog(@"当前连接的一台设备: %@",self.connectedDevice.peripheral);
    
    self.connectedDevice.peripheral.delegate = self;
    NSMutableDictionary * info = [[NSMutableDictionary alloc]initWithObjects:@[peripheral] forKeys:@[@"data"]];
    
    [self.delegate bluetoothStateChange:self :STATE_CONNECTED_DEVICE :info];
    
}

//发现一台设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    DLog(@"中心设备发现一台外围设备");
    
    //名称等于UART-BLE时
//    if([peripheral.name isEqualToString:@"UART-BLE"]){
    
        LNowDevice *device = [[LNowDevice alloc]initWithPeripheral:peripheral withRssi:RSSI];
        
        [self addDevice:device];
         
        //调用delegate
        [self.delegate bluetoothStateChange:self :STATE_DISCOVERED_DEVICE :device];
        
//    }
    
    
}

//断开一台设备连接
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
   
    DLog(@"断开设备连接:%@", peripheral.identifier);
    
    if (error) {
        DLog(@"断开设备%@时发生错误: %@",peripheral.identifier, error.localizedDescription);
    }
    
    NSDictionary * info = [[NSDictionary alloc]initWithObjects:@[peripheral,error] forKeys:@[@"data",@"error"]];
    [self.delegate bluetoothStateChange:self :STATE_DISCONNECT_DEVICE :info];
}


//连接一台设备失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error  {
    DLog(@"连接%@设备失败！error=%@",peripheral.name,error);
    
    NSDictionary * info = [[NSDictionary alloc]initWithObjects:@[peripheral,error] forKeys:@[@"data",@"error"]];
    [self.delegate bluetoothStateChange:self :STATE_FAIL_TO_CONNECT_DEVICE :info];
    
}

//访问到当前已连接设备
-(void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{
    
    DLog(@"访问设备");
    DLog(@"访问设备个数 %lu",(unsigned long)[peripherals count]);
    
}

//重新连接一台已知设备
-(void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{
    
    DLog(@"重新连接已知设备");
    DLog(@"参数个数 %lu",(unsigned long)[peripherals count]);
    
}

//APP重新从后台转到前台
-(void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict{
    
    DLog(@"重新RestoreState");
    DLog(@"重新%@",dict);
    
}










@end
