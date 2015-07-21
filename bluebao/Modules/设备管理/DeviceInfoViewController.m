//
//  DeviceInfoControllerViewController.m
//  Bluetooth
//
//  Created by hebidu on 15/7/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "DeviceInfoViewController.h"

@interface DeviceInfoViewController ()


@property (nonatomic,strong)BoyeBluetooth * bluetooth;

@property (nonatomic,strong)LNowDevice * device;


@property (nonatomic) BOOL isPolling;

@property (nonatomic,strong) NSArray * interestServices;

@property (nonatomic,strong) NSString *  interestCharacteristicUUID;

@property (nonatomic,strong) NSMutableArray * descData;

@property (strong,nonatomic)UIButton * bindBtn;
@property (weak,nonatomic) UIToolbar * toolbar;
@property (weak, nonatomic) IBOutlet UILabel *lblUUID;
@property (weak, nonatomic) IBOutlet UITextView *tvLog;

@end

@implementation DeviceInfoViewController


//感兴趣的特征UUID


#pragma mark getter/setter


@synthesize bluetooth = _bluetooth;

@synthesize interestServices = _interestServices;

@synthesize interestCharacteristicUUID = _interestCharacteristicUUID;

#pragma mark getter/setter

-(NSString *)interestCharacteristicUUID{
    
    if(self->_interestCharacteristicUUID == nil){
        self->_interestCharacteristicUUID = @"FFF1";
    }
    
    return self->_interestCharacteristicUUID;
}

-(NSArray *)interestServices{
    
    if(self->_interestServices == nil){
        self->_interestServices =  @[@"FFF0"];
    }
    
    return self->_interestServices;
}

-(BoyeBluetooth *)bluetooth{
    if(_bluetooth == nil){
        _bluetooth =  [BoyeBluetooth sharedBoyeBluetooth];
        _bluetooth.delegate = self;
    }
    
    return _bluetooth;
}
-(void)setDevice:(LNowDevice *)device{
    _device = device;
}

#pragma mark 继承

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self checkHadBindCurrentDevice];
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"视图消失!");
    
}

#pragma 自定义方法

-(void)errorHandler:(NSError *)error{
    //TODO: 错误处理
    NSLog(@"\n===============================\n");
    NSLog(@"\n发生错误 %@\n",error);
    NSLog(@"\n===============================\n");
}

-(void)updateValue:(NSString *)hexString{
    
    NSLog(@"当前设备： %ld",(long)self.bluetooth.connectedDevice.state);
    NSLog(@"当前设备： %@",self.bluetooth.connectedDevice.peripheral);
    
    if([[hexString lowercaseString] isEqualToString:@"da"]){
        NSLog(@"外围设备关闭了!");
    }
    
    if (hexString.length < 20){
        return;
    }
    
    //TODO: 有新数据接收时.
    NSLog(@"======================================");
    
    NSLog(@"%@,长度%lu",hexString,(unsigned long)hexString.length);
    
    NSRange cmdRang = NSMakeRange(0, 6);
    NSString * cmdStr = [[hexString substringWithRange:cmdRang] lowercaseString];
    
    if([cmdStr isEqualToString:@"5a0ee5"] && hexString.length == 32){
        
        LNowBicyleData *data = [[LNowBicyleData alloc] init];
        
        cmdStr = [[hexString substringWithRange:NSMakeRange(6, 4)] lowercaseString];
//        NSLog(@"时间  %@",cmdStr );
        data.spendTime = cmdStr.integerValue;
        
        cmdStr = [[hexString substringWithRange:NSMakeRange(10, 4)] lowercaseString];
//        NSLog(@"速度 %@",cmdStr);
        data.speed = cmdStr.integerValue;
        
        cmdStr = [[hexString substringWithRange:NSMakeRange(14, 4)] lowercaseString];
//        NSLog(@"距离 %@",cmdStr);
        data.distance = cmdStr.integerValue;
        
        cmdStr = [[hexString substringWithRange:NSMakeRange(18, 4)] lowercaseString];
//        NSLog(@"热量 %@",cmdStr);
        data.quantityOfHeat = cmdStr.integerValue;
        
        cmdStr = [[hexString substringWithRange:NSMakeRange(22, 4)] lowercaseString];
//        NSLog(@"总程 %@",cmdStr);
        data.totalDistance = cmdStr.integerValue;
        cmdStr = [[hexString substringWithRange:NSMakeRange(26, 2)] lowercaseString];
//        NSLog(@"心率 %@",cmdStr);
        data.heartRate = cmdStr.integerValue;
        
        cmdStr = [[hexString substringWithRange:NSMakeRange(28, 2)] lowercaseString];
//        NSLog(@"校验和 %@",cmdStr);
        data.checksum = cmdStr.integerValue;
        
        NSLog(@"data = %@",data);
        [self.descData addObject:data];
        NSDateFormatter * formatter = [NSDate defaultDateFormatter ];
        
        NSString * curDateString = [formatter stringFromDate:[NSDate defaultCurrentDate]];
        
        self.tvLog.text  = [self.tvLog.text stringByAppendingFormat:@"\n %@: %@",curDateString,data ];
        
        NSLog(@"======================================");
        
    }
    
}

//更新UI
- (void)updateUI{
    
//    NSMutableString * serDesc = [[NSMutableString alloc] init];
//    NSDateFormatter * gmt8 = [[NSDateFormatter alloc]init];
//    gmt8.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
//    gmt8.dateFormat = @"yyyy年MM月dd日 hh:mm:ss";
//   
//    [serDesc appendFormat:@"更新时间 = %@\n",  [gmt8 stringFromDate:[NSDate date]]];
//    [serDesc appendFormat:@"================\n"];
//    
//    for (LNowBicyleData *data in self.descData) {
//        [serDesc appendFormat:@" %@ \n",data.description];
//    }
//    
//    [serDesc appendFormat:@"================\n"];
//    
//    self.tvLog.text = serDesc.lowercaseString;
    
}

-(void)connectDevice{
    
    //TODO: 上传用户绑定记录
    
    
    [self.bluetooth connectDevice:self.device];
    [self.bindBtn setEnabled:NO];
}

-(void)initView{
    
    self.navigationItem.title = @"设备详情";
    self.toolbar = (UIToolbar *)[self.view viewWithTag:1001];
    
    self.bindBtn = [[UIButton alloc]init];
    
    [self.bindBtn  setTitle:@"绑定" forState:UIControlStateNormal];
    [self.bindBtn  setTitle:@"绑定中..." forState:UIControlStateDisabled];
    [self.bindBtn  addTarget:self action:@selector(connectDevice) forControlEvents:UIControlEventTouchUpInside];
    
    self.bindBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [ButtonFactory decorateButton:self.bindBtn  forType:BOYE_BTN_PRIMARY];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:self.bindBtn];
    NSMutableArray *items = [[NSMutableArray alloc]init];
    
    [items addObject: item];
    
    [self.toolbar setItems:items];
    UIButton * btn = self.bindBtn ;
    NSMutableArray * bindConstraint = [[NSMutableArray alloc]initWithArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[btn]-0-|"
                                                                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                                                                    metrics:nil
                                                                                                                      views:NSDictionaryOfVariableBindings(btn)]];
    
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[btn]-0-|"
                                                                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                                                                    metrics:nil
                                                                                                                      views:NSDictionaryOfVariableBindings(btn)]];
    [self.toolbar addConstraints:bindConstraint];
    
    self.lblUUID.text = self.device.uuid;
}
-(void)checkHadBindCurrentDevice{
    
    NSLog(@"蓝牙对象是否已连接=%ld",(self.device.state & CBPeripheralStateConnected));
    NSLog(@"本例对象uuid=%@",self.device.uuid);
    NSLog(@"蓝牙对象uuid=%@",self.bluetooth.connectedDevice);
    
    if ((self.device.state & CBPeripheralStateConnected) == CBPeripheralStateConnected){
        [self.bindBtn setTitle:@"已绑定" forState:UIControlStateDisabled];
        [self.bindBtn setEnabled:NO];
    }else{
        
        if ((self.device.state & CBPeripheralStateDisconnected) == CBPeripheralStateDisconnected) {
            [self.bindBtn setTitle:@"已断开，请重新绑定" forState:UIControlStateDisabled];
            [self.bindBtn setEnabled:YES];
        }
        
        if([self.bluetooth isLastConnectedDevice:self.device]){
            [self.bindBtn setTitle:@"重新绑定" forState:UIControlStateNormal];
            [self.bindBtn setEnabled:YES];
        }
        
    }
    
}

//初始化
- (void)setUp{
    
    [self initView];

    
}

#pragma mark --Boyebluetooth  委托实现

-(void)bluetoothStateChange:(id)sender :(enum BOYE_BLUETOOTH_STATE_EVENT)stateEvent :(id)parms{
    NSDictionary * info = (NSDictionary *)parms;
    
    NSLog(@"委托蓝牙状态变更！%u",stateEvent);
    
    switch (stateEvent) {
        case STATE_CHANGE:
            [self bluetoothUpdateState];
            break;
        case STATE_CONNECTED_DEVICE:
            NSLog(@"连接上一台设备!");
            [self didConnectDevice];
            break;
        case STATE_DISCONNECT_DEVICE:
            NSLog(@"断开上一台设备!");
            [self disConnectDevice];
            break;
        case STATE_DISCOVERED_SERVICE:
            [self didDiscoverServices:[info objectForKey:@"error"]];
            break;
        case STATE_DISCOVERED_CHARACTERISTICS:
            [self didDiscoverCharacteristicsForService:[info objectForKey:@"data"] error:[info objectForKey:@"error"]];
            break;
        case STATE_UPDATE_VALUE:
        {
            CBCharacteristic * characteristic = (CBCharacteristic *)[info objectForKey:@"data"];
            
            NSString * dataValue = [self dataToString:characteristic.value];
            [self updateValue:dataValue];
            
        }
        default:
            break;
    }
    
}

#pragma mark -- CBPeripheralDelegate

/**
 *  蓝牙状态变更
 *
 *  @param state 蓝牙状态
 */
-(void)bluetoothUpdateState{
    
    NSString  *desc;
    BOOL needAlert = true;
    switch (self.bluetooth.state) {
        case CBCentralManagerStatePoweredOff:
            desc = @"当前设备未开启蓝牙";
            break;
            
        case CBCentralManagerStatePoweredOn:
        {
            needAlert = false;
            desc = @"设备已开启蓝牙且可用";
            NSLog(@"自动开始扫描");
            [self.bluetooth connectDevice:self.device];
        }
            break;
            
        case CBCentralManagerStateResetting:
            desc = @"当前蓝牙连接重置了";
            break;
            
        case CBCentralManagerStateUnauthorized:
            desc = @"APP无权限使用蓝牙";
            break;
            
        case CBCentralManagerStateUnknown:
            desc = @"当前设备状态未知";
            break;
        default:
            desc = @"当前设备不支持蓝牙4.0";
            
            break;
    }
    
    NSLog(@"中心设备当前状态=%@",desc);
    if(needAlert){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统消息"
                                                        message:desc delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
}


-(void)disConnectDevice{
    NSLog(@"设备详情控制器接受到设备已连接消息！");
    [self.bindBtn setEnabled:YES];
    
}

-(void)didConnectDevice{
    NSLog(@"设备详情控制器接受到设备已连接消息！");
    
    [self checkHadBindCurrentDevice];
    //自动扫描服务操作
    [self.bluetooth discoverServices:nil];
}

//发现服务
-(void)didDiscoverServices:(NSError *)error{
    
    //180A = Device Information
    //180F = Battery
    //180D = Heart Rate
    NSLog(@"发现的服务:%@",self.bluetooth.connectedDevice.service);
    
    for (CBService *service in self.bluetooth.connectedDevice.service) {
        for (NSString * uuid in self.interestServices) {
            if([uuid isEqualToString:service.UUID.UUIDString]){
                NSLog(@"感兴趣的服务,并自动扫描特征: %@",service);
                [self.bluetooth discoverCharacteristic:uuid];
                
            }
        }
        
    }
    
}

//
-(void)didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    NSLog(@"获取到Service的UUID:%@", service.UUID);
    
    NSLog(@"发现了外围设备的服务提供的特征: %@", service.characteristics);
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        [self.bluetooth listenningCharacteristic:characteristic.UUID.UUIDString];
    }
    
    
}


- (NSString * )dataToString:(NSData *)value{
    
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [value bytes];
    
    for (int i=0; i < [value length]; i++) {
        [hexString appendFormat:@"%02x", *p++];
    }
    
    return [hexString lowercaseString];
    
}

@end
