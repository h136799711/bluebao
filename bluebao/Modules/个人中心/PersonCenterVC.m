//
//  PersonCenterVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "PersonCenterVC.h"
#import "MessageCell.h"
#import "PictureReqModel.h"




@interface PersonCenterVC (){
    
    UITableView             *_tableView;
    
    UIView * _views ;
    
    NSArray   * _sortArray; //分类
    NSArray   * _unitArray;// 单位
    UIView    * _headView;
    
}

@end

@implementation PersonCenterVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSLog(@"**********个人中心出现**********");
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"**********个人中心消失**********");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [MainViewController sharedSliderController].userInfo;
    
    
    self.title = @"个人中心";
    
    [self _initViews];
    [self queryRemoteData];
}
//初始化
-(void)_initViews{
    
    _sortArray = @[@[@"总里程",@"总时间",@"总消耗热量"],@[@"最长距离",@"最长时间",@"最多消耗热量"]];
    _unitArray = @[@"公里",@"小时",@"卡"];
    [self _initTableView];
    
    
    NSLog(@"test= %@",[[CacheFacade sharedCache] get:@"test"]);
}

-(void)_initTableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT -TABBAR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self getHeaderView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [MyTool testViews:_tableView];
        [self.view addSubview:_tableView];
    }
    
}

#pragma mark 自定义方法

-(void)setBestResult:(NSDictionary *)data{
    
    NSString * best_distance = [data objectForKey:@"best_distance"];
    NSNumber * best_cost_time = [data objectForKey:@"best_cost_time"];
    NSString * best_calorie = [data objectForKey:@"best_calorie"];
    NSInteger  bd_tag =  (1100 + 0);
    NSInteger  bct_tag =  (1100 + 1);
    NSInteger  bc_tag =  (1100 + 2);
    if ((NSNull *)best_distance == [NSNull null]) {
        best_distance = @"0";
    }
    
    if ((NSNull *)best_cost_time ==  [NSNull null]) {
        best_cost_time = [NSNumber numberWithInt:0];// 0;
    }
    
    if ((NSNull *)best_calorie == [NSNull null]) {
        best_calorie = @"0";
    }
    
    MessageCell * lblTmp =  (MessageCell * )[_tableView viewWithTag:bd_tag];
    lblTmp.label_value.text = [NSString stringWithFormat:@"%@公里",best_distance];
    lblTmp =  (MessageCell * )[_tableView viewWithTag:bct_tag];
    
    lblTmp.label_value.text  =  [NSString stringWithFormat:@"%.2f时",([best_cost_time doubleValue] / 3600)];

    lblTmp =  (MessageCell * )[_tableView viewWithTag:bc_tag];
    lblTmp.label_value.text  =  [NSString stringWithFormat:@"%@卡",best_calorie];

    
}


-(void)setTotalResult:(NSDictionary *)data{
    
    NSString * sum_max_calorie = [data objectForKey:@"sum_max_calorie"];
    NSNumber * sum_max_distance = [data objectForKey:@"sum_max_distance"];
    NSString * sum_max_time = [data objectForKey:@"sum_max_time"];
    NSInteger  bd_tag =  (1000 + 0);
    NSInteger  bct_tag =  (1000 + 1);
    NSInteger  bc_tag =  (1000 + 2);
    
    
    MessageCell * lblTmp =  (MessageCell * )[_tableView viewWithTag:bd_tag];
    lblTmp.label_value.text = [NSString stringWithFormat:@"%@公里",sum_max_distance];
    lblTmp =  (MessageCell * )[_tableView viewWithTag:bct_tag];
    
    lblTmp.label_value.text  =  [NSString stringWithFormat:@"%.2f时",([sum_max_time doubleValue] / 3600)];
    
    lblTmp =  (MessageCell * )[_tableView viewWithTag:bc_tag];
    lblTmp.label_value.text  =  [NSString stringWithFormat:@"%@卡",sum_max_calorie];
    
    
}

#pragma mark 注释-从服务器查询相关数据
-(void)queryRemoteData{
    
    NSNumber * uid = [NSNumber numberWithInteger: self.userInfo.uid ];
    
    [BicyleStatistics queryBestResult:uid :^(id  data) {
        
        if(data == nil){
            
            NSLog(@"数据获取为空!");
        }
        
        if([data isKindOfClass:[NSArray class]]){
            
            [self setBestResult:data[0] ];
        }
        
    } :nil];
    
    [BicyleStatistics queryTotalResult:uid :^(id data) {
        
        if(data == nil){
            NSLog(@"数据获取为空!");
        }
        
        NSLog(@"data=%@",data);
        
        if([data isKindOfClass:[NSDictionary class]]){
            
            [self setTotalResult:data ];
        }
        
    } :nil];
    
}

#pragma mark -- UITableViewdelegate --

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static    NSString * identifier = @"cell";
   
    MessageCell * cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //分类
    cell.label_sort.text = _sortArray[indexPath.section][indexPath.row];
    cell.label_value.text = [MyTool stringWithNumFormat:_unitArray[indexPath.row] number:0];
    cell.tag = 1000+indexPath.section*100+indexPath.row;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
       return  [self createhwbInfo];
    }else{
        return [self creatpersonBestLabel:tableView];
    }
    
}

#pragma mark -- 身高，体重 MBI  区头
-(UIView *)createhwbInfo{
    
    if (_views == nil) {
        _views = [[UIView alloc] init];
        _views.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
        
        for (int i = 0; i < 3; i++) {
            switch (i) {
                case 0:
                    self.heightLabel =  [BBManageCode creatMessageCenterInViews:_views num:i];
                    break;
                    
                case 1:
                    self.weightLabel =  [BBManageCode creatMessageCenterInViews:_views num:i];
                    break;
                    
                case 2:
                    self.BMiLabel =  [BBManageCode creatMessageCenterInViews:_views num:i];
                    break;
                    
                default:
                    break;
            }
        }
        
        //线
        [MyTool createLineInView:_views fram:CGRectMake(26, 0, SCREEN_WIDTH-26*2, 1)];
        [MyTool createLineInView:_views fram:CGRectMake(26, _views.height -1, SCREEN_WIDTH-26*2, 1)];

    }
    
    CGFloat bmi = [MyTool getBMINumWeight:self.userInfo.weight height:self.userInfo.height];
    
    
    self.heightLabel.text = [NSString stringWithFormat:@"%ld",(long)self.userInfo.height];
    self.weightLabel.text = [NSString stringWithFormat:@"%ld",(long)self.userInfo.weight];
    self.BMiLabel.text = [NSString stringWithFormat:@"%.1f",bmi];
    
    return  _views;
}

#pragma mark-- pesonBest --
-(UIView * )creatpersonBestLabel:(UITableView *)tableView {
    
    UIView  * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, tableView.width, 40);
    
    UILabel * personBest = [[UILabel alloc] init];
    personBest.frame = view.frame;
    personBest.textAlignment = NSTextAlignmentCenter;
    personBest.text = @"个人最好成绩";
    personBest.font = FONT(17);
    [view addSubview:personBest];
    //线
    [MyTool createLineInView:view fram:CGRectMake(26, 0, view.width-26*2, 0.5)];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark -- 表头 --
-(UIView *)getHeaderView{
    
    if (_headView == nil) {
    
        _headView = [[UIView alloc] init];
        _headView.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 120);
        
        //头像
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, 80, 80);
        imageView.center = CGPointMake(40+imageView.width/2.0, _headView.height/2.0);
        imageView.image =[UIImage imageNamed:@"Default_header"];
        [MyTool cutViewConner:imageView radius:imageView.width/2.0];
        imageView.backgroundColor = [UIColor redColor];
        [_headView addSubview:imageView];
        self.head_ImageView = imageView;
        
        UIButton * headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.frame= imageView.frame;
        [_headView addSubview:headBtn];
//        [headBtn addTarget:self action:@selector(headbutton:) forControlEvents:UIControlEventTouchUpInside];
        [self avatarRequest];
        
        //姓名
        UILabel  * label_name = [[UILabel alloc] init];
        label_name.bounds = CGRectMake(0, 0, 120, 30);
        label_name.center = CGPointMake(imageView.right + 30+ label_name.width /2.0, imageView.center.y-label_name.height/2.0);
        label_name.text = self.userInfo.nickname;
        label_name.font = FONT(15);
        [_headView addSubview:label_name];
        
        //ID
        
        UILabel  * label_ID = [[UILabel alloc] init];
        label_ID.bounds = label_name.bounds;
        label_ID.center = CGPointMake(label_name.center.x, imageView.center.y+label_ID.height/2.0);
//        label_ID.text = [NSString stringWithFormat:@"ID:%ld", (long)self.userInfo.uid];
        label_ID.text = [NSString stringWithFormat:@"%@", self.userInfo.signature];
        label_ID.font = FONT(15);
        label_ID.textColor = [UIColor lightGrayColor];
        [_headView addSubview:label_ID];
        
        

    }
    
    return _headView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)avatarRequest{
    
    NSURL * avatar_url = [[NSURL alloc]initWithString:[BoyePictureUploadManager getAvatarURL:self.userInfo.uid :120]];
    [self.head_ImageView setImageWithURL:avatar_url];
//    [self.head_ImageView  setImageURL:avatar_url placeholder:[UIImage imageNamed:@"Default_header"]];

}

@end
