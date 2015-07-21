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
        NSLog(@"BoyeBluetooh初始化");
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
    NSLog(@"连接设备=%@",device);
    
    NSLog(@"peripherals=%@",self.peripherals);
    for (int i=0; i< [self.peripherals count]; i++) {
        
        LNowDevice * device = (LNowDevice *)self.peripherals[i];
        
        if([device.uuid isEqualToString:device.uuid]){
            
            //缓存到本地
            [self setLastConnectDeviceUUID:device.uuid];
            
            self.connectedDevice= device;
            //连接时重置数据
            self.connectedDevice.service = nil;
            self.connectedDevice.character = nil;
            
            NSLog(@"准备连接设备：%@",device.peripheral);
            if(device.peripheral == nil){
                NSLog(@"无法连接设备！设备对象不能为nil");
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
    }
}

- (void)stopScanDevice{
    NSLog(@"bluetooth call stopScanDevice");
    if(self.cbCentralManager.state == CBCentralManagerStatePoweredOn){
        [self.cbCentralManager stopScan];
    }
}

-(void)discoverServices:(NSArray *)uuids{
    NSLog(@"蓝牙开始搜索服务:%@",uuids);
    [self.connectedDevice.peripheral discoverServices:uuids];
    NSLog(@"当前连接的设备:%@",self.connectedDevice);

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


#pragma mark -- CBPeripheralDelegate
//xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/CoreBluetooth/Reference/CBPeripheral_Class/index.html#//apple_ref/occ/cl/CBPeripheral

//发现服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    NSLog(@"发现了外围设备的一个服务: %@", peripheral.services);
    
    for (CBService *service in peripheral .services) {
        
        NSString * uuidString = service.UUID.UUIDString;
        NSLog(@"发现了服务: %@", uuidString);
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
    
    NSLog(@"获取到Service的UUID:%@", service.UUID);
    
    NSLog(@"发现了外围设备的服务提供的特征: %@", service.characteristics);
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        
//        CBCharacteristicProperties prop =  characteristic.properties;
        //TODO: 手动连接
//        if(prop & CBCharacteristicPropertyNotify){
//            NSLog(@"setNotifyValue");
//            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//        }
//        if(prop & CBCharacteristicPropertyRead){
//            NSLog(@"read");
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
        NSLog(@"Error changing notification state: %@",[error localizedDescription]);
        NSLog(@"Error%@",error);
    }
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc]initWithObjects:@[characteristic] forKeys:@[@"data"]];
    
    if(error != nil){
        [info setObject:error forKey:@"error"];
    }
    [self.delegate bluetoothStateChange:self :STATE_UPDATE_VALUE :info];
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"数据变化了通知消息");
    
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc]initWithObjects:@[characteristic] forKeys:@[@"data"]];
    
    if(error != nil){
        [info setObject:error forKey:@"error"];
    }
    [self.delegate bluetoothStateChange:self :STATE_UPDATE_VALUE :info];
    
}

#pragma  mark -- CBCentralManagerDelegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSLog(@"中心设备更新状态了");
    self.state = central.state;
    
    [self.delegate bluetoothStateChange:self :STATE_CHANGE :nil];
}

//连接上一台设备
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"中心设备连接上一台设备: %@",peripheral);
    NSLog(@"当前连接的一台设备: %@",self.connectedDevice.peripheral);
    
    self.connectedDevice.peripheral.delegate = self;
    NSMutableDictionary * info = [[NSMutableDictionary alloc]initWithObjects:@[peripheral] forKeys:@[@"data"]];
    
    [self.delegate bluetoothStateChange:self :STATE_CONNECTED_DEVICE :info];
    
}

//发现一台设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"中心设备发现一台外围设备");
    
    //名称等于UART-BLE时
    if([peripheral.name isEqualToString:@"UART-BLE"]){
        
        LNowDevice *device = [[LNowDevice alloc]initWithPeripheral:peripheral withRssi:RSSI];
        
        [self addDevice:device];
         
        //调用delegate
        [self.delegate bluetoothStateChange:self :STATE_DISCOVERED_DEVICE :device];
        
    }
    
    
}

//断开一台设备连接
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
   
    NSLog(@"断开设备连接:%@", peripheral.identifier);
    
    if (error) {
        NSLog(@"断开设备%@时发生错误: %@",peripheral.identifier, error.localizedDescription);
    }
    
    NSDictionary * info = [[NSDictionary alloc]initWithObjects:@[peripheral,error] forKeys:@[@"data",@"error"]];
    [self.delegate bluetoothStateChange:self :STATE_DISCONNECT_DEVICE :info];
}


//连接一台设备失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error  {
    NSLog(@"连接%@设备失败！error=%@",peripheral.name,error);
    
    NSDictionary * info = [[NSDictionary alloc]initWithObjects:@[peripheral,error] forKeys:@[@"data",@"error"]];
    [self.delegate bluetoothStateChange:self :STATE_FAIL_TO_CONNECT_DEVICE :info];
    
}

//访问到当前已连接设备
-(void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{
    
    NSLog(@"访问设备");
    NSLog(@"访问设备个数 %lu",(unsigned long)[peripherals count]);
    
}

//重新连接一台已知设备
-(void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{
    
    NSLog(@"重新连接已知设备");
    NSLog(@"参数个数 %lu",(unsigned long)[peripherals count]);
    
}

//APP重新从后台转到前台
-(void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict{
    
    NSLog(@"重新RestoreState");
    NSLog(@"重新%@",dict);
    
}










@end
