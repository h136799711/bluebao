//
//  ViewController.m
//  Bluetooth
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "DeviceBindController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface DeviceBindController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrl;

@property (nonatomic,strong)BoyeBluetooth *bluetooth;
@property (strong, nonatomic)  UITableView *tvDevices;
@property (strong,nonatomic) PulsingRadarView *indicator ;
@property (nonatomic,strong)NSMutableArray * lnowDevice;
//@property (nonatomic,strong)CBCentralManager * cbCentralManager;
@property (nonatomic,strong)LNowDevice * connected;

@property (strong, nonatomic)  UIView *bindView;
@property (strong,nonatomic) UIView * unBindView;
@property (strong , nonatomic) PulsingRadarView  *radarView;
@property (strong , nonatomic) UILabel  *lblTip;
@property (strong , nonatomic) UIButton *searchBtn;
@property (nonatomic) CGFloat searchTimeFlag ;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation DeviceBindController

//最大扫描时长(秒) - 未找到设备-找到设备后重置
static const int MAX_SCAN_SECONDS = 6;

//@synthesize lnowDevice = _lnowDevice;

@synthesize indicator = _indicator;
//@synthesize cbCentralManager = _cbCentralManager;

#pragma mark getter|setter

- (PulsingRadarView *)indicator{
    
    if (self->_indicator == nil){
        self->_indicator = [[PulsingRadarView alloc]init];
    }
    
    return self->_indicator;
}

//- (NSMutableArray *)lnowDevice{
//    if (self->_lnowDevice == nil) {
//        self->_lnowDevice = [[NSMutableArray alloc] init];
//    }
//    return self->_lnowDevice;
//}

#pragma mark 视图响应


- (void)segmentChangedValue:(id)sender{
    NSLog(@"%@",sender);
    if([sender isKindOfClass:[UISegmentedControl class]]){
        UISegmentedControl * ctrl = (UISegmentedControl *)sender;
        NSLog(@"选中第%ld", (long)ctrl.selectedSegmentIndex);
        if(ctrl.selectedSegmentIndex == 0){
            if(! (self.bluetooth.connectedDevice != nil && (self.bluetooth.connectedDevice.state & CBPeripheralStateConnected) == CBPeripheralStateConnected) ){
                [self scanDevice];
            }
            
            [self showBindView];
        }else{
            
            [self stopScanDevice];
            [self showUnBindView];
        }
    }
}

#pragma mark 自定义方法

/**
 *  刷新tableview，
 */
-(void)refreshTableView{
    if([self.bluetooth.peripherals count] > 0){
        [self showDataView];
        [self.tvDevices reloadData];
        
    }else{
        
        [self showBindView];
    }
    
}

-(void)checkStopCondition{
    //是否自动扫描，针对存在已缓存的扫描设备时，不扫描。
    
    NSLog(@"搜索时间%f",self.searchTimeFlag);
    
    if( self.searchTimeFlag > MAX_SCAN_SECONDS){
        [self stopScanDevice];
    }
    
    self.searchTimeFlag++;
    
}

-(void)showBindView{
    self.bindView.hidden = NO;
    self.unBindView.hidden = YES;
    self.tvDevices.hidden = YES;
//    self.view.backgroundColor = [UIColor colorWithRed:(248/255.0) green:(248/255.0) blue:(248/255.0) alpha:1];
}

-(void) showUnBindView{
    self.bindView.hidden = YES;
    self.unBindView.hidden = NO;
    self.tvDevices.hidden = NO;
//    self.view.backgroundColor = [UIColor colorWithRed:(248/255.0) green:(248/255.0) blue:(248/255.0) alpha:1];
}

-(void)showDataView{
    self.bindView.hidden = YES;
    self.tvDevices.hidden = NO;
    self.unBindView.hidden = YES;
//    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)scanDevice{
    
    [self showBindView];
    NSLog(@"开始扫描设备！");
    self.searchTimeFlag = 0;
    self.lblTip.text = @"正在搜索设备...";
    [self.bluetooth startScanDevice];
    [self.indicator startAnimate];
    
    self.searchBtn.hidden = YES;
    
    [self mockData];
     //开启定时器
    [self.timer setFireDate:[NSDate distantPast]];
}

-(void)stopScanDevice{
    
    NSLog(@"停止扫描设备！");
    self.searchTimeFlag = 0;
    [self.indicator stopAnimate];
    if ([self.bluetooth.peripherals count] > 0) {
        
        [self showDataView];
        
    }else{
        [self showBindView];
        self.lblTip.text = @"没有发现设备";
        self.searchBtn.hidden = NO;
        [self.indicator reset];
    }
    
    [self.bluetooth stopScanDevice];
    
    [self.timer setFireDate:[NSDate distantFuture]];
    
}


#pragma mark 初始化


-(void)initView{
    self.view.backgroundColor = [UIColor colorWithRed:(248/255.0) green:(248/255.0) blue:(248/255.0) alpha:1];
    self.bindView = [[UIView alloc]init];
    self.unBindView = [[UIView alloc]init];
    self.tvDevices = [[UITableView alloc]init];
    self.tvDevices.dataSource = self;
    self.tvDevices.delegate = self;
    
    //test
    
//    self.bindView.backgroundColor = [UIColor whiteColor];
    self.unBindView.backgroundColor = [UIColor grayColor];
    
    PulsingRadarView * radarView = self.indicator ;
    radarView.radarWidth = 30;
    radarView.radarHeight = 30;
    radarView.tag = 1001;
//    radarView.backgroundColor = [UIColor grayColor];
    UIView *radarContainer = [[UIView alloc]init];
    
//    radarContainer.backgroundColor = [UIColor blackColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请确定设备已经开启，并且在手机附近";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 2;
    label.font = [UIFont fontWithName:@"华文细黑" size:14.0];
    
    self.lblTip = [[UILabel alloc] init];
    UILabel *lblTip = self.lblTip;
    
    lblTip.text = @"正在搜索设备...";
    lblTip.tag = 1010;
    lblTip.textColor = [UIColor blackColor];
    lblTip.textAlignment = NSTextAlignmentCenter;
    lblTip.numberOfLines = 1;
    lblTip.font = [UIFont fontWithName:@"华文细黑" size:12.0];
    
    self.searchBtn = [[UIButton alloc]init];
    
    UIButton *btn = self.searchBtn;
    
    [btn setTitle:@"重新搜索" forState:UIControlStateNormal];
    
    //TODO : 点击搜索按钮，开始扫描设备
    [ButtonFactory decorateButton:btn forType:BOYE_BTN_DANGER];
    
    UILabel *label2 = [[UILabel alloc] init];
    
    label2.text = @"解除绑定视图";
    label2.backgroundColor  = [UIColor whiteColor];
    
    [radarContainer addSubview: radarView];
    
    [self.bindView addSubview:radarContainer];
    [self.bindView addSubview:label];
    [self.bindView addSubview: self.lblTip];
    [self.bindView addSubview: btn];
    [self.unBindView addSubview:label2];
    
    [self.view addSubview:self.tvDevices];
    [self.view addSubview:self.bindView];
    [self.view addSubview:self.unBindView];
    
    //约束
    self.tvDevices.translatesAutoresizingMaskIntoConstraints = NO;
    radarContainer.translatesAutoresizingMaskIntoConstraints = NO;
    radarView.translatesAutoresizingMaskIntoConstraints = NO;
    lblTip.translatesAutoresizingMaskIntoConstraints = NO;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    self.bindView.translatesAutoresizingMaskIntoConstraints = NO;
    self.unBindView.translatesAutoresizingMaskIntoConstraints = NO;
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict  setObject:self.bindView forKey:@"bindView"];
    [dict  setObject:self.unBindView forKey:@"unBindView"];
    [dict  setObject:self.tvDevices forKey:@"tvDevices"];
    
    
    
    NSMutableArray * bindConstraint = [[NSMutableArray alloc]initWithArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[bindView]-15-|"
                                                                       options:NSLayoutFormatAlignAllCenterX
                                                                       metrics:nil
                                                                         views:dict]];
    
    [bindConstraint  addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[bindView]-|"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:dict]];
    
    [bindConstraint  addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[unBindView]-15-|"
                                                                                  options:NSLayoutFormatAlignAllCenterX
                                                                                  metrics:nil
                                                                                    views:dict]];
    
    [bindConstraint  addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[unBindView]-|"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:dict]];
    [bindConstraint addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[tvDevices]-15-|"
                                                                                options:0 metrics:nil views:dict]];
    
    [bindConstraint addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[tvDevices]-|"
                                                                                options:0 metrics:nil views:dict]];
    
    [self.view addConstraints:bindConstraint];
    
    //view视图的子视图布局
    
    //解绑视图
    [self.unBindView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label2]-10-|"
                                                                             options:NSLayoutFormatAlignAllCenterX
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(label2)]];
    
    [self.unBindView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[label2]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(label2)]];
    //绑定视图布局
    [self.bindView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]-20-|"
                                                                           options:NSLayoutFormatAlignAllCenterX
                                                                           metrics:nil
                                                                             views:NSDictionaryOfVariableBindings(label)]];
    [self.bindView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[lblTip]-30-|"
                                                                           options:NSLayoutFormatAlignAllCenterX
                                                                           metrics:nil
                                                                             views:NSDictionaryOfVariableBindings(lblTip)]];
    
    [self.bindView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[radarContainer]-30-|"
                                                                           options:NSLayoutFormatAlignAllCenterX
                                                                           metrics:nil
                                                                             views:NSDictionaryOfVariableBindings(radarView,radarContainer)]];
    
    [self.bindView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[radarContainer(==150)]-20-[lblTip]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:NSDictionaryOfVariableBindings(lblTip,radarView,radarContainer)]];

    [self.bindView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lblTip]-20-[label]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:NSDictionaryOfVariableBindings(lblTip,label)]];
    
    [self.bindView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-20-[btn]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:NSDictionaryOfVariableBindings(label,btn)]];
    
    [self.bindView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[btn]-40-|"
                                                                           options:NSLayoutFormatAlignAllCenterX
                                                                           metrics:nil
                                                                             views:NSDictionaryOfVariableBindings(btn)]];
    
    [radarContainer addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[radarView]-5-|"
                                                                            options:NSLayoutFormatAlignAllCenterX
                                                                            metrics:nil
                                                                              views:NSDictionaryOfVariableBindings(radarView,radarContainer)]];
    
    [radarContainer addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[radarView]-5-|"
                                                                            options:NSLayoutFormatAlignAllCenterY
                                                                            metrics:nil
                                                                              views:NSDictionaryOfVariableBindings(radarView,radarContainer)]];

    [self showBindView];
}

-(void)initLisenter{
    
    [self.segCtrl addTarget:self action:@selector(segmentChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.searchBtn addTarget:self action:@selector(scanDevice) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setUp{
    
    //设备蓝牙
    self.bluetooth = [BoyeBluetooth sharedBoyeBluetooth];
    [self.bluetooth  setDelegate:self];
    
    [self initView];
    [self initLisenter];
    
    NSDateFormatter * formatter = [NSDate defaultDateFormatter ];
    
    [self scanDevice];
    
}

-(void)mockData{
    
}

#pragma mark 继承方法

- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
    self.navigationController.navigationBarHidden = NO;
    self.segCtrl.alpha = 0;
    [super viewDidLoad];
    
    [self setUp];
    [self _initNavs];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSLog(@"viewDidAppear");
    if(self.timer == nil){
        //开启定时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkStopCondition) userInfo:nil repeats:YES ];
    }else{
        
        [self.timer setFireDate:[NSDate distantPast]];
    }
    
    self.bluetooth.delegate = self;
    [self refreshTableView];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self stopScanDevice];
//    [self.timer invalidate];
    [self.timer setFireDate:[NSDate distantFuture]];
//    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [self stopScanDevice];
    [super didReceiveMemoryWarning];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger cnt = [self.bluetooth.peripherals count];
    
    return cnt;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellTableIdentifier = @"CellTableIndentifier";
    
    DeviceInfoCell *cell = (DeviceInfoCell*)[tableView dequeueReusableCellWithIdentifier:cellTableIdentifier];//复用cell
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DeviceInfoCell" owner:self options:nil];//加载自定义cell的xib文件
        cell = [array objectAtIndex:0];
    }
    
    NSUInteger row = indexPath.row;
    LNowDevice * device =  (LNowDevice *)[self.bluetooth.peripherals objectAtIndex:row];
    
    NSLog(@"tableView cellForRowAtIndexPath");
    
    cell.name = device.name;
    cell.name = @"蓝堡动感单车";
    cell.uuid = device.uuid;
    NSLog(@"设备状态 = %ld",(long)device.state);
    
    if((device.state & CBPeripheralStateConnected)){
        cell.state = @"状态:已连接";
    }else if((device.state & CBPeripheralStateConnecting)){
        cell.state = @"状态:连接中";
    }else{
        cell.state = @"状态:未连接";
        [cell setGray];
    }
    cell.rssi = device.rssi;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//cell的右边有一个小箭头，距离右边有十几像素；
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        return @"搜索到的设备";
    }
    
    return @"搜索到的设备";
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CGSize size = [self.tvDevices.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return 60;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    
    LNowDevice *device = self.bluetooth.peripherals[row];
    
    
    DeviceInfoViewController * deviceInfoCtrl  = [self.storyboard instantiateViewControllerWithIdentifier:@"DeviceInfoViewController"];
    [deviceInfoCtrl setDevice:device];
    
    [self.navigationController pushViewController:deviceInfoCtrl animated:YES];
    
}


#pragma  mark -- 蓝牙相关处理

/**
 *  委托
 *
 *  @param sender     bluetooth对象
 *  @param stateEvent 事件
 *  @param parms      参数，依据事件不一致，参数不同
 */
-(void)bluetoothStateChange:(id)sender :(enum BOYE_BLUETOOTH_STATE_EVENT)stateEvent :(id)parms{
    BoyeBluetooth * bluetooth = (BoyeBluetooth *)sender;
    if(bluetooth == nil){
        NSLog(@"error!!");
        return;
    }
    switch (stateEvent) {
        case STATE_CONNECTED_DEVICE:
        {
            NSLog(@"连接上一台设备!");
            
            NSMutableDictionary * info = (NSMutableDictionary *)parms;
            
            [self didConnectDevice:[info objectForKey:@"data"]];
            
        }
            break;
        case STATE_CHANGE:
            [self bluetoothUpdateState:bluetooth.state];
            break;
        case STATE_DISCOVERED_DEVICE:
        {
            NSLog(@"parms = %@",parms);
            LNowDevice * device = (LNowDevice *)parms;
            
            [self bluetoothDidDiscoverDevice:bluetooth.connectedDevice RSSI:device.rssi];
        }
            break;
        case   STATE_DISCONNECT_DEVICE:
        {
            [self refreshTableView];
        }
            break;
        default:
            break;
    }
}

-(void)didConnectDevice:(CBPeripheral *)data{
    
    [self refreshTableView];
    
}

/**
 *  蓝牙状态变更
 *
 *  @param state 蓝牙状态
 */
-(void)bluetoothUpdateState:(CBCentralManagerState)state{
    
    NSString  *desc;
    BOOL needAlert = true;
    switch (state) {
        case CBCentralManagerStatePoweredOff:
            desc = @"当前设备未开启蓝牙";
            break;
            
        case CBCentralManagerStatePoweredOn:
        {
            needAlert = false;
            desc = @"设备已开启蓝牙且可用";
            NSLog(@"自动开始扫描");
            [self.bluetooth startScanDevice];
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
        [self stopScanDevice];
    }
}

/**
 *  发现设备时 回调
 *
 *  @param peripheral 发现的设备
 *  @param RSSI       信号强度
 */
-(void)bluetoothDidDiscoverDevice :(LNowDevice *)device RSSI:(NSNumber *)RSSI{
    
    //重置
    self.searchTimeFlag = 0;
    //重新更新tableview数据
    [self refreshTableView];
    
}


#pragma mark -- 导航条 返回 --

-(void)_initNavs{
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.bounds = CGRectMake(0, 0, 12, 22.5);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1;
    UIBarButtonItem* letfItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = letfItem;
}

#pragma mark --返回 --
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
