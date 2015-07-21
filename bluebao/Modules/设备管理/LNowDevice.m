//
//  LNowDevice.m
//  Bluetooth
//
//  Created by hebidu on 15/7/10.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "LNowDevice.h"

@implementation LNowDevice

@synthesize uuid = _uuid;

@synthesize name = _name;

@synthesize rssi = _rssi;

-(CBPeripheralState )state{
    return _peripheral.state;
}
-(NSMutableArray *)service{
    if(_service == nil){
        _service = [[NSMutableArray alloc]init];
    }
    
    return  _service;
}

-(NSMutableArray *)character{
    if(_character == nil) {
        _character = [[NSMutableArray alloc]init];
    }
    
    return _character;
}

-(NSString *)name{
    if(_name == nil){
        return @"未知";
    }
    return _name;
}

-(NSString *)uuid{
    if(_uuid == nil){
        return @"D0123CE7-9886-6ca2-f222-084d24d50D1E";
    }
    return _uuid;
}
-(instancetype)initWithPeripheral:(CBPeripheral *)peripheral   withRssi:(NSNumber *)rssi{
    
    self = [self initWithPeripheral:peripheral];
    
    self.rssi = rssi;
    
    return self;
}

-(instancetype)initWithPeripheral:(CBPeripheral *)peripheral{
    if(self = [super init]){
        if (peripheral == nil) {
            return self;
        }
        self->_peripheral = peripheral;
        self->_name = peripheral.name;
        self->_uuid = peripheral.identifier.UUIDString;
        self->_rssi = 0;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
//    [aCoder encodeObject:self.NAME forKey:@"name"];
//    [aCoder encodeObject:self.peripheral forKey:@"peripheral"];
}

//- (NSNumber *)RSSI_PERCENT{
//    NSNumber* percent = [NSNumber alloc] ;
//    return (NSNumber)(self.RSSI/100.0);
//}


//设备名称=UART-BLE
//2015-07-10 09:33:04.270 Bluetooth[997:643090] 设备UUID= <__NSConcreteUUID 0x170035d40> 4D2E058E-1D12-84E9-C981-72A7736C5489
//2015-07-10 09:33:04.270 Bluetooth[997:643090] 设备信号= -64
//2015-07-10 09:33:04.270 Bluetooth[997:643090] 设备CBAdvertisementDataLocalNameKey= UART-BLE
//2015-07-10 09:33:04.270 Bluetooth[997:643090] 设备CBAdvertisementDataManufacturerDataKey= (null)
//2015-07-10 09:33:04.270 Bluetooth[997:643090] 设备CBAdvertisementDataServiceDataKey= (null)
//2015-07-10 09:33:04.270 Bluetooth[997:643090] 设备CBAdvertisementDataServiceUUIDsKey= (
//                                                                                     "Heart Rate"
//                                                                                     )
//2015-07-10 09:33:04.271 Bluetooth[997:643090] 设备CBAdvertisementDataOverflowServiceUUIDsKey= (null)
//2015-07-10 09:33:04.271 Bluetooth[997:643090] 设备CBAdvertisementDataTxPowerLevelKey= (null)
//2015-07-10 09:33:04.271 Bluetooth[997:643090] 设备CBAdvertisementDataIsConnectable= 1
//2015-07-10 09:33:04.271 Bluetooth[997:643090] 设备CBAdvertisementDataSolicitedServiceUUIDsKey= (null)


@end
