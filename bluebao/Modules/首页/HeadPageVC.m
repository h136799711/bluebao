//
//  HeadPageVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "HeadPageVC.h"
#import "HeadInfoCell.h"
#import "HeadCollectionViewCell.h"
#import "BMICell.h"
#import "DrawProgreView.h"
#import "BicyleReqModel.h"
#import "BoyeConnectView.h"
#import "CheckBluetoothData.h"


@interface HeadPageVC ()<BOYEBluetoothStateChangeDelegate>{
    
    UITableView             * _tableView;
    NSArray                 * _labelarray;
    UICollectionView        *headCollectionView;
    NSInteger               itemWidth;   //宽度
    NSArray                 *_imageName;
    NSArray                 *_sortArray;
    
    NSInteger        _upTimeInterval; //上传时间间隔
}

@property (nonatomic,strong) BoyeBluetooth              * boyeBluetooth;            //蓝牙
@property (nonatomic,strong) BluetoothDataManager       *currentBluetothData;       // 当前蓝牙数据解析类
@property (nonatomic,strong) BluetoothDataManager       *lastUsedBluetothData;       // 当前蓝牙数据解析类

@property (nonatomic,strong) Bicyle                     * bicylelb;                 // 蓝堡Bicycle数据类
@property (nonatomic,strong) NSDate                     * nextUpLoadDateTime;       //下一个上传时间
@property (nonatomic,strong) BoyeConnectView            * connectView;              //连接跑步机
@end

@implementation HeadPageVC
-(Bicyle *)bicylelb{
    
    if ( _bicylelb == nil ) {
        _bicylelb = [[Bicyle alloc] init];
    }
    return _bicylelb;
}
-(NSDate *)nextUpLoadDateTime{
    
    if (_nextUpLoadDateTime == nil) {
        _nextUpLoadDateTime = [NSDate date];
    }
    return _nextUpLoadDateTime;
}
-(BluetoothDataManager *)currentBluetothData{
    
    if (_currentBluetothData == nil) {
        _currentBluetothData = [[BluetoothDataManager alloc] init];
    }
    return _currentBluetothData;
}

-(BluetoothDataManager *)lastUsedBluetothData{
    if (_lastUsedBluetothData == nil) {
        _lastUsedBluetothData = [[BluetoothDataManager alloc] init];
    }
    return _lastUsedBluetothData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [[CacheFacade sharedCache] setObject:@"500" forKey:BOYE_TODAY_TARGET_CALORIE];
    self.title =@"蓝堡动感单车";

    //初始化数据上传时间
    [self _initUpTime];
    
    _labelarray = @[@"心率",@"速度",@"时间",@"运动消耗",@"路程"];
    _imageName = @[@"xinlv.png",@"sd.png",@"time.png",@"sport.png",@"road.png"];
    _sortArray = @[@"体脂肪率",@"体水分率",@"体年龄",@"基础代谢",@"肌肉含量",@"内脏含量",@"骨骼含量",@"皮下脂肪"];
    [self _initViews];
    
    [self test];
    
}

/**
 * 初始化数据上传时间
 *
 **/

-(void)_initUpTime{
    
    _upTimeInterval = 10;
    _nextUpLoadDateTime = [NSDate date];
    [self nextLoadTime];;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
     //蓝牙
    self.boyeBluetooth  = [BoyeBluetooth sharedBoyeBluetooth];
    self.boyeBluetooth.delegate = self;
   
    self.userInfo = [MainViewController sharedSliderController].userInfo;
    [headCollectionView reloadData];

   
    if ([MainViewController sharedSliderController].isVCCancel == NO) {
        [self doViewAppearBefore];
        [MainViewController sharedSliderController].isVCCancel  = YES;
    }

  
}

-(void) doViewAppearBefore{
    
    
    self.userInfo = [MainViewController sharedSliderController].userInfo;
    
    [headCollectionView reloadData];
    NSLog(@" ---- current设备UUID %@  ",self.boyeBluetooth.connectedDevice.uuid);
    
    
    [self getBicyleData];

}

#pragma mark -- 初始化 --

-(void)_initViews{

    itemWidth = (SCREEN_WIDTH - 50-15*3)/4.0;

    [self _initHeadInfoTableView];
}


#pragma mark -- 首页表 --

-(void)_initHeadInfoTableView{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = [self headerView];
    _tableView.tableFooterView = [self footerView];
    [self.view addSubview:_tableView];

    
}
#pragma mark --  主页表 --

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return  _labelarray.count+1;
}

#pragma mark ---  tableViewDelegate --

//UITableView 蓝堡踏步机
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row <_labelarray.count) {
        static  NSString * identifier = @"headCell";
        
        HeadInfoCell * headCell = (HeadInfoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (headCell == nil) {
            headCell = [[HeadInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            headCell.signImageView.image = [UIImage imageNamed:_imageName[indexPath.row]];
            headCell.signLabelSort.text = _labelarray[indexPath.row];
        }

        
        //判断是否是今天
        if (self.dateChooseView.isToday && self.connectView.isConnect == YES) {
            //TODO.....
            _bicylelb = _currentBluetothData.bicyleModel;
            
            headCell.signLabelValue.text = [BBManageCode getHeaderStrRow:indexPath.row bicyle:_bicylelb];

        }else{
            
            headCell.signLabelValue.text = [BBManageCode getHeaderStrRow:indexPath.row bicyle:_bicylelb];
        }
        
        return headCell;

    }else{
        
        static  NSString * identifier = @"bmiCell";
        
        BMICell * cell = (BMICell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[BMICell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
        
        cell.weight = self.userInfo.weight;
        cell.bmiValue = [MyTool getBMINumWeight:self.userInfo.weight height:self.userInfo.height];

        return cell;
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _labelarray.count) {
        
        return 60;
    }else{
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@" cell");

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark --   表头  ---
-(UIView *)headerView{
    
    //日期
    CGRect rect = CGRectMake(0, 0, _tableView.width, 240);
    self.headView = [[UIView alloc] initWithFrame:rect];
 
    //日期改变
    self.dateChooseView = [[DateChooseView alloc] init];
    self.dateChooseView .center = CGPointMake(self.headView.center.x, 20);
    self.dateChooseView .delegate = self;
    [self.headView addSubview:self.dateChooseView ];
    
    //设备连接
    CGRect  conrect = CGRectMake(0, self.dateChooseView .bottom, self.dateChooseView .width, 30);
    _connectView = [[BoyeConnectView alloc] initWithFrame:conrect];
    _connectView.center = CGPointMake(self.headView.center.x, conrect.origin.y + _connectView.height/2.0);
    [self.headView addSubview:_connectView];
    
    
    #pragma mark -- drawProgreView ---
    CGFloat   width =  rect.size.height - _connectView.bottom-3;
    self.drawProgreView = [[DrawProgreView alloc] initWithFrame:CGRectMake(0, 0, width,width)];
    self.drawProgreView.center = CGPointMake(self.headView.width/2.0, _connectView.bottom + self.drawProgreView.height/2.0 );
    [self.headView addSubview:self.drawProgreView];
    
    [self.drawProgreView showCircleView];
    return self.headView ;
}


#pragma mark --DateChooseViewDelegate  切换日期，查看历史记录   --

-(void)dateChooseView:(DateChooseView *)dateChooseView datestr:(NSString *)datestr{
    
    
//    NSLog(@"date  %@",datestr);
  
     //1、选泽日期是今日，
    if (self.dateChooseView.isToday) {
        NSLog(@"today");
        
        //设备未连接，获取当日数据，已连接不做处理

        if (self.connectView.isConnect == NO) {
            [self getBicyleData];
        }
        
     //2、选泽日期是非当日，
    }else{
        //非今日，查看历史数据
        
        [self getBicyleData];
        
        NSLog(@"NO today");
    }
    
    //刷新
    [_tableView reloadData];
}



#pragma mark --  展示目标 任务完成度 -
-(void) showFinishProgre{
  
#pragma mark -- TODO..获得默认卡路里....

    // 1、选中日期是当天
    if (self.dateChooseView.isToday== YES && self.connectView.isConnect == YES ) {
        //处于正在连接状态，取缓存目标值
            //获得缓存卡路里
            _drawProgreView.finishNum = _currentBluetothData.bicyleModel.calorie;
            _drawProgreView.goalNum = [[CommonCache getGoal] integerValue];

        } else{
            //处于未连接创状态  ，取获取目标值 即 self。bicyle。goal
//            NSLog(@"*******isNotConnect*****OR NoToday**获取历史数据展示********************************");
            // 2、选中日期非当天日期， 直接展示数据

            _drawProgreView.finishNum = self.bicylelb.calorie;
            _drawProgreView.goalNum = self.bicylelb.target_calorie;
    }
    
    // * *  如果goalNum = 0 转化为 500  判断是否为 0
//    _drawProgreView.goalNum = [MyTool  getDefaultGoalValue:_drawProgreView.goalNum];
    
    [_drawProgreView showCircleView];

    
    // 3 . 如果一点没有做 ，则按默认处理 ，
    
    LBSportShareModel * lanbao = [LBSportShareModel sharedLBSportShareModel];
    
    lanbao.distance = self.bicylelb.distance;
    lanbao.calorie = self.bicylelb.calorie;

}

-(BOOL) isGoalfinishZero:(NSInteger) goalValue finish:(NSInteger) finishValue{
    
    if (goalValue == 0 && finishValue == 0) {
        return YES;
        
    }else{
        return 0;
    }
}


#pragma mark --- 身体指标 ---
-(UIView *)footerView{
    
    CGFloat  minLineSpacing = 15;
    CGFloat  minInteritemSpacing = 15;
    
    UIView * view  = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, itemWidth *2 +minInteritemSpacing+10);
    //初始化collection view
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = minLineSpacing;      //水平间距
    flowLayout.minimumInteritemSpacing = minInteritemSpacing; //垂直间距
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth-10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);//整体相对页面的位置，上左下右
    //collectionView
    CGRect frame = CGRectMake(20,20,SCREEN_WIDTH-20*2,180);
    headCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    headCollectionView.scrollEnabled = YES;
    headCollectionView.delegate = self;
    headCollectionView.dataSource = self;
    headCollectionView.alwaysBounceVertical = YES;
    headCollectionView.backgroundColor = [UIColor clearColor];
    
    [headCollectionView registerClass:[HeadCollectionViewCell class] forCellWithReuseIdentifier:@"HeadCollectionViewCell"];
    
    [view addSubview:headCollectionView];
    return view;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _sortArray.count;
    //    return dataSource.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}
#pragma mark ---collectionViewCell --
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeadCollectionViewCell" forIndexPath:indexPath];

    cell.labelUnit.text = indexPath.row == 2?@"岁":@"%";
   
    #pragma mark -- TODO...
    
    cell.infoValue = [BBManageCode getPersonHealthCondition:indexPath.row userInfo:self.userInfo];

    cell.labelSort.text = _sortArray[indexPath.row];
    return cell;
}

#pragma mark  -- 单车数据请求 HTTP --

-(void)getBicyleData{
    
    BicyleReqModel * reqModel = [[BicyleReqModel alloc] init];
    reqModel.uid = self.userInfo.uid;
//    reqModel.uuid = @"OTO458-1082"; //LR-866
    reqModel.uuid = self.boyeBluetooth.connectedDevice.uuid;
    reqModel.time = [[_dateChooseView.newbDate  dateDayTimeStamp] integerValue];

     [BoyeBicyleManager  requestBicyleData:reqModel :^(NSDictionary *successdDic) {
        
        if (successdDic) {
            //数据请求成功
            self.bicylelb = [[Bicyle alloc] initWithBicyleRespDic:successdDic];
            
            //任务完成度
            [self showFinishProgre];
            [_tableView reloadData];
        }
    } :^(NSString *error) {

    }];
}



//刷新界面数据
-(void)refreshData:(Bicyle *) bicyle{
 
    self.bicylelb = bicyle;
    [_tableView reloadData];
}

//数据上传
-(void) upLoadBicyleData{
   
    //
    BicyleReqModel * reqModel = [[BicyleReqModel alloc] init];

    reqModel.uid = self.userInfo.uid;
    
//    reqModel.uuid = @"OTO458-1082"; //LR-866
    reqModel.uuid = self.boyeBluetooth.connectedDevice.uuid;
  
    reqModel.bicyleModel = _currentBluetothData.bicyleModel;

    #pragma mark -- TODO:..........

    reqModel.bicyleModel.target_calorie = [[CommonCache getGoal]integerValue];

    [BoyeBicyleManager requestBicyleDataUpload:reqModel
                                          complete:^(BOOL bicyleSuccessed) {
                                              if (bicyleSuccessed) {
                                                  NSLog(@"bicyleSuccessed");
                                                  
                                              }
        }];
}




#pragma mark --- 蓝牙数据处理 Delegate ----

-(void)bluetoothStateChange:(id)sender :(enum BOYE_BLUETOOTH_STATE_EVENT)stateEvent :(id)parms{
    NSDictionary * info = (NSDictionary *)parms;
    
    NSLog(@"首页委托蓝牙状态变更！%u",stateEvent);
    
    static  BOOL  isconnect = NO;
    switch (stateEvent) {
        case STATE_CHANGE:
            
            //            [self bluetoothUpdateState];
            isconnect = NO;
            break;
        case STATE_CONNECTED_DEVICE:
            NSLog(@"连接上一台设备!");
//                        [self didConnectDevice];
            isconnect = YES;
            NSLog(@" ***  \r  connectDevice uuid %@  ",self.boyeBluetooth.connectedDevice.uuid);
            
            break;
        case STATE_DISCONNECT_DEVICE:
            NSLog(@"断开上一台设备!");
            //            [self disConnectDevice];
            isconnect = NO;
            break;
        case STATE_DISCOVERED_SERVICE:
            //            [self didDiscoverServices:[info objectForKey:@"error"]];
            isconnect = NO;
            break;
        case STATE_DISCOVERED_CHARACTERISTICS:
            //            [self didDiscoverCharacteristicsForService:[info objectForKey:@"data"] error:[info objectForKey:@"error"]];
            isconnect = NO;
            break;
        case STATE_UPDATE_VALUE:
        {
            isconnect = YES;
            
            CBCharacteristic * characteristic = (CBCharacteristic *)[info objectForKey:@"data"];
            
            NSString * dataValue = [self dataToString:characteristic.value];
            [self updateValue:dataValue];
            
        }
        default:
            break;
    }
    
    self.connectView.isConnect = isconnect;
    
}

#pragma mark --获取并解析蓝牙数据 --
-(void)updateValue:(NSString *)dataString{

    NSLog(@" datastring: %@",dataString);
    //析蓝牙数据
    BluetoothDataManager * bluetoothData = [[BluetoothDataManager alloc] initWithBlueToothData:dataString];
   
    #pragma mark -- TODO.蓝牙数据检查...
    CheckBluetoothData * check = [[CheckBluetoothData alloc] init];
   BOOL isable = [check checkBluetoothDataUsable:bluetoothData];
    
    if (isable == YES ) {  //数据有效
        _lastUsedBluetothData = bluetoothData;
    
    }else{    //数据无效

        if (check.isOutTime) {
    #pragma makr -- TODO ...
           
        bluetoothData.bicyleModel.calorie = _lastUsedBluetothData.bicyleModel.calorie;
            
        }else{

        }
    }
    
    _currentBluetothData = bluetoothData;

    
    //刷新首页
    if (self.dateChooseView.isToday) {
        
        if ([NSDate currDateIsOutSetingTime:_nextUpLoadDateTime]) {
            
            [self upLoadBicyleData];
            //下次上传时间
            [self nextLoadTime];
        }
        [_tableView reloadData];
        [self showFinishProgre];
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

#pragma mark -- 下次上传时间
-(void) nextLoadTime{
    
    _nextUpLoadDateTime = [_nextUpLoadDateTime dateByAddingTimeInterval:_upTimeInterval];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)test{
    
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testgoal) userInfo:nil repeats:YES];

}
-(void)testgoal{
  
    static NSInteger count = 0;
    count ++;
    count = count %25; ;
    BluetoothDataManager * bluetoothData = [[BluetoothDataManager alloc] init];
    bluetoothData.bicyleModel.calorie = arc4random() %5;
    
    if (count >= 12) {
        bluetoothData.bicyleModel.calorie = 0;
    }
    NSLog(@"%ld --- %ld",bluetoothData.bicyleModel.calorie,count);

    if ([CheckBluetoothData checkDataUsable:bluetoothData]) {
        _currentBluetothData = bluetoothData;
    }

    
}
//#pragma mark -- 将要消失||隐藏
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//    
//    LBSportShareModel * lanbao = [LBSportShareModel sharedLBSportShareModel];
//    
//       
//    NSLog(@"***************************** distance %f -- calorie %f ",lanbao.distance,lanbao.calorie);
//    
//}

@end
