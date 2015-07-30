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
    
    self.userInfo = [MainViewController sharedSliderController].userInfo;
    
    [self _initPersonMessage];
    
//
//    NSLog(@" ----  %ld   %ld  %f  ",weight,height,bmi );
}
//个人资料
-(void)_initPersonMessage{
  
    self.userInfo =  [MainViewController sharedSliderController].userInfo;
//    
//    NSInteger weight = [[USER_DEFAULT objectForKey:BOYE_USER_WEIGHT] integerValue];
//    NSInteger height = [[USER_DEFAULT objectForKey:BOYE_USER_HEIGHT] integerValue];
    
    
    CGFloat bmi = [MyTool getBMINumWeight:self.userInfo.weight height:self.userInfo.height];
    
    
    self.heightLabel.text = [NSString stringWithFormat:@"%ld",self.userInfo.height];
    self.weightLabel.text = [NSString stringWithFormat:@"%ld",self.userInfo.weight];
    self.BMiLabel.text = [NSString stringWithFormat:@"%.1f",bmi];
    

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"数据中心";
    
    [self _initViews];
    
}
//初始化
-(void)_initViews{
    
    _sortArray = @[@[@"总里程",@"总时间",@"总消耗热量"],@[@"最长距离",@"最长时间",@"最多消耗热量"]];
    _unitArray = @[@"公里",@"小时",@"卡"];
    [self _initTableView];
    
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
                    self.heightLabel =  [BBManageCode creatMessageCenterInViews:_views num:i];;
                    break;
                    
                case 1:
                    self.weightLabel =  [BBManageCode creatMessageCenterInViews:_views num:i];;
                    break;
                    
                case 2:
                    self.BMiLabel =  [BBManageCode creatMessageCenterInViews:_views num:i];;
                    break;
                    
                default:
                    break;
            }
        }
        
        //线
        [MyTool createLineInView:_views fram:CGRectMake(26, 0, SCREEN_WIDTH-26*2, 1)];
        [MyTool createLineInView:_views fram:CGRectMake(26, _views.height -1, SCREEN_WIDTH-26*2, 1)];

    }
    
//    int weight = [[USER_DEFAULT objectForKey:BOYE_USER_WEIGHT] intValue];
//    int height = [[USER_DEFAULT objectForKey:BOYE_USER_HEIGHT] intValue];
//    CGFloat bmi = [MyTool getBMINumWeight:weight height:height];
//    
//    
//   self.heightLabel.text = [NSString stringWithFormat:@"%d",height];
//    self.weightLabel.text = [NSString stringWithFormat:@"%d",weight];
//    self.BMiLabel.text = [NSString stringWithFormat:@"%.1f",bmi];
    
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
        imageView.image =[UIImage imageNamed:@"testhead.png"];
        [MyTool cutViewConner:imageView radius:imageView.width/2.0];
        imageView.backgroundColor = [UIColor redColor];
        [_headView addSubview:imageView];
        self.head_ImageView = imageView;
        
        UIButton * headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.frame= imageView.frame;
        [_headView addSubview:headBtn];
        [headBtn addTarget:self action:@selector(headbutton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //姓名
        UILabel  * label_name = [[UILabel alloc] init];
        label_name.bounds = CGRectMake(0, 0, 80, 30);
        label_name.center = CGPointMake(imageView.right + 30+ label_name.width /2.0, imageView.center.y-label_name.height/2.0);
        label_name.text = @"用户名字";
        label_name.font = FONT(15);
        [_headView addSubview:label_name];
        
        //ID
        
        UILabel  * label_ID = [[UILabel alloc] init];
        label_ID.bounds = label_name.bounds;
        label_ID.center = CGPointMake(label_name.center.x, imageView.center.y+label_ID.height/2.0);
        label_ID.text = @"ID:123456";
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

-(void)headbutton:(UIButton *)button{
    
    
    PictureReqModel * picModel = [[PictureReqModel alloc] init];
    picModel.uid  = self.userInfo.uid;
    picModel.type = @"avatar";
   
//   
//    [BoyePictureUploadManager requestPictureUpload:picModel complete:^(BOOL successed) {
//        
//        if (successed ) {
//            
//            ALERTVIEW(@"成功");
//        }
//    }];
//
    //上传
//    [self requestPictrueUpload:picModel];
    //下载
    [self requestUserHeadImagDown:picModel];
   
      NSLog(@"图片下载");
    NSLog(@" 图片上传");
}

-(void) requestPictrueUpload:(PictureReqModel *)picModel{

    
    [BoyePictureUploadManager requestPictureUpload:picModel complete:^(BOOL successed) {
        
        if (successed ) {
            
            ALERTVIEW(@"成功");
        }
    }];
    

}


-(void) requestUserHeadImagDown:(PictureReqModel *)picModel{
 
    //头像请求成功，为空，
    [BoyePictureUploadManager requestUserHeadDown:picModel complete:^(UIImage *headImage) {
        if (headImage ) {
            self.head_ImageView.image = headImage;
        }
        NSLog(@"");
        
    }];
    //   ****/
    

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
