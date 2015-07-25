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


@interface HeadPageVC (){
    
    UITableView             * _tableView;
    NSArray                 * _labelarray;
    UICollectionView        *headCollectionView;
    NSInteger               itemWidth;
    NSArray                 *_imageName;
    NSArray                 *_sortArray;
}

@end

@implementation HeadPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"蓝堡踏步机";

    _labelarray = @[@"心率",@"速度",@"时间",@"运动消耗",@"路程"];
    _imageName = @[@"xinlv.png",@"sd.png",@"time.png",@"sport.png",@"road.png"];
    _sortArray = @[@"体脂肪率",@"体水分率",@"体年龄",@"基础代谢",@"肌肉含量",@"内脏含量",@"骨骼含量",@"皮下脂肪"];
    [self _initViews];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [_tableView reloadData];
    [headCollectionView reloadData];
    self.userInfo = [MainViewController sharedSliderController].userInfo;
//    NSLog(@" userInfo\r weight  %ld  \r height :%ld \r age: %ld ",self.userInfo.weight,self.userInfo.height,self.userInfo.age);
}
#pragma mark -- 初始化 --

-(void)_initViews{

    itemWidth = (SCREEN_WIDTH - 50-15*3)/4.0;
//    [USER_DEFAULT setInteger:60 forKey:BOYE_USER_WEIGHT];
//    [USER_DEFAULT setInteger:165 forKey:BOYE_USER_HEIGHT];
//    [USER_DEFAULT setInteger:16 forKey:BOYE_USER_AGE];

//
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
        headCell.signLabelValue.text = @"100";
        
        return headCell;

    }else{
        
        static  NSString * identifier = @"bmiCell";
        
        BMICell * cell = (BMICell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[BMICell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
        
            NSLog(@" userInfo\r weight  %ld  \r height :%ld \r age: %ld ",self.userInfo.weight,self.userInfo.height,self.userInfo.age);

        cell.weight = self.userInfo.weight;
        cell.bmiValue = [MyTool getBMINumWeight:self.userInfo.weight height:self.userInfo.height];

//        cell.weight =  [[USER_DEFAULT objectForKey:BOYE_USER_WEIGHT] floatValue];
//        cell.bmiValue = 8.9;
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
#pragma mark -- 目标 ---
-(UIView *)headerView{
    
    //日期
    CGRect rect = CGRectMake(0, 0, _tableView.width, 200);
    self.headView = [[UIView alloc] initWithFrame:rect];
 
    //日期改变
    DateChooseView * dataView = [[DateChooseView alloc] init];
    dataView.center = CGPointMake(self.headView.center.x, 20);
    dataView.delegate = self;
    [self.headView addSubview:dataView];
    
    
    //连接设备
    UILabel * equipLabel = [[UILabel alloc] init];
    equipLabel.bounds = CGRectMake(0, dataView.bottom, dataView.width, 20);
    equipLabel.center = CGPointMake(self.headView.center.x, dataView.bottom + equipLabel.height/2.0);
    equipLabel.textAlignment = NSTextAlignmentCenter;
    equipLabel.text = @"没有连接设备";
    equipLabel.font = FONT(13);
    [self.headView addSubview:equipLabel];
    
    
    DrawProgreView * draw = [[DrawProgreView alloc] init];
    CGFloat   width =  rect.size.height - equipLabel.bottom-20;
    draw.bounds = CGRectMake(0, 0, width,width);
    draw.center = CGPointMake(self.headView.width/2.0, equipLabel.bottom + draw.height/2.0 +10);
    [self.headView addSubview:draw];
    
    
    
    return self.headView ;
}


#pragma mark -- 日期 改变  --

-(void)dateChooseView:(DateChooseView *)dateChooseView datestr:(NSString *)datestr{
    
    NSLog(@"date  %@",datestr);
    
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

#pragma mark ---collectionViewCell --
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeadCollectionViewCell" forIndexPath:indexPath];

    
    cell.labelUnit.text = indexPath.row == 2?@"岁":@"%";
    if (indexPath.row == 2) {

            cell.infoValue = [MainViewController sharedSliderController].userInfo.age;
        
    }else{
            cell.infoValue = 10;
    }

    cell.labelSort.text = _sortArray[indexPath.row];
    return cell;
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
