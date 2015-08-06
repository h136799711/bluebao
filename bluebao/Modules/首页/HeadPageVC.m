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
-(NSDate *)lastUpLoadDateTime{
    if (_nextUpLoadDateTime == nil) {
        _nextUpLoadDateTime = [NSDate date];
        _nextUpLoadDateTime = [self nextUploadDataTime];
    }
    return _nextUpLoadDateTime;
}
-(BluetoothDataManager *)currentBluetothData{
    
    if (_currentBluetothData == nil) {
        _currentBluetothData = [[BluetoothDataManager alloc] init];

    }
    
    return _currentBluetothData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"蓝堡踏步机";
    
    _upTimeInterval = 10;
    
    _labelarray = @[@"心率",@"速度",@"时间",@"运动消耗",@"路程"];
    _imageName = @[@"xinlv.png",@"sd.png",@"time.png",@"sport.png",@"road.png"];
    _sortArray = @[@"体脂肪率",@"体水分率",@"体年龄",@"基础代谢",@"肌肉含量",@"内脏含量",@"骨骼含量",@"皮下脂肪"];
    [self _initViews];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
     //蓝牙
    self.boyeBluetooth  = [BoyeBluetooth sharedBoyeBluetooth];
    self.boyeBluetooth.delegate = self;
    
    [self doViewAppearBefore];
  
}

-(void) doViewAppearBefore{
    
    
    self.userInfo = [MainViewController sharedSliderController].userInfo;
    
    [headCollectionView reloadData];
    
    
    NSLog(@" ---- current %@  ",self.boyeBluetooth.connectedDevice.uuid);
    
    
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
        if (self.dateChooseView.isToday) {
            //TODO.....
            
            headCell.signLabelValue.text = [BBManageCode getHeaderStrRow:indexPath.row bicyle:_currentBluetothData.bicyleModel];

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
        
        return 80;
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

#pragma mark -- 目标 ---
-(UIView *)headerView{
    
    //日期
    CGRect rect = CGRectMake(0, 0, _tableView.width, 200);
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
    
   self.drawProgreView = [[DrawProgreView alloc] init];
    CGFloat   width =  rect.size.height - _connectView.bottom-20;
    self.drawProgreView.bounds = CGRectMake(0, 0, width,width);
    self.drawProgreView.center = CGPointMake(self.headView.width/2.0, _connectView.bottom + self.drawProgreView.height/2.0 +10);
    [self.headView addSubview:self.drawProgreView];
    
    
    return self.headView ;
}

    

#pragma mark -- 切换日期，查看历史记录   --

-(void)dateChooseView:(DateChooseView *)dateChooseView datestr:(NSString *)datestr{
    
    
//    NSLog(@"date  %@",datestr);
  
    if (self.dateChooseView.isToday) {
        NSLog(@"today");
        
     //TODO.....
        //设备连接，更新UI数据上传
        if (!self.connectView.isConnect) {
            //是今日，且设备未连接，则显示今日
            [self getBicyleData];
        }
        
    //非今日，查看历史数据
    }else{
        NSLog(@"NO today");
        [self getBicyleData];
    }
    
    //刷新
    [_tableView reloadData];
}

#pragma mark --- 身体指标 ---
-(UIView *)footerView{
    
  
    UIView * view  = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    //初始化collection view
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;      //水平间距
    flowLayout.minimumInteritemSpacing = 10; //垂直间距
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
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
    if (indexPath.row == 2) {

            cell.infoValue = self.userInfo.age;
        
    }else{
           cell.infoValue = 10;
        
        
        
        
    }

    cell.labelSort.text = _sortArray[indexPath.row];
    return cell;
}

#pragma mark  -- 单车数据请求 HTTP --

-(void)getBicyleData{
    
    BicyleReqModel * reqModel = [[BicyleReqModel alloc] init];
    reqModel.uid = self.userInfo.uid;
    reqModel.uuid = @"OTO458-1082"; //LR-866
    reqModel.time = [[_dateChooseView.newbDate  dateDayTimeStamp] integerValue];

     [BoyeBicyleManager  requestBicyleData:reqModel :^(NSDictionary *successdDic) {
        
        if (successdDic) {
            //数据请求成功
            self.bicylelb = [[Bicyle alloc] initWithBicyleRespDic:successdDic];
            
            //任务完成度
            _drawProgreView.goalNum = self.bicylelb.total_distance;
            _drawProgreView.finishNum = self.bicylelb.distance;

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
    reqModel.uuid = @"OTO458-1082";
    
//    reqModel.bicyleModel.calorie = 10;
//    reqModel.bicyleModel.cost_time = 10;
//    reqModel.bicyleModel.distance = 10;
//    reqModel.bicyleModel.heart_rate = 10;
//    reqModel.bicyleModel.speed = 10;
//    reqModel.bicyleModel.total_distance = 10;
//    reqModel.bicyleModel.upload_time = 1438617600;
//    reqModel.bicyleModel.target_calorie = 10;
    
    reqModel.bicyleModel = _currentBluetothData.bicyleModel;
    
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
            //            [self didConnectDevice];
            isconnect = YES;
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
    _currentBluetothData = bluetoothData;

    //刷新首页
    if (self.dateChooseView.isToday) {
        NSLog(@"  8888888888888888888888888 ");
        
        if ([_nextUpLoadDateTime isOutSetDateTime:[NSDate date]]) {
            
            [self upLoadBicyleData];
        }
        
        [_tableView reloadData];
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
-(NSDate *) nextUploadDataTime{
    
    return [_nextUpLoadDateTime dateByAddingTimeInterval:_upTimeInterval];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
