//
//  ShareVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "ShareVC.h"

@interface ShareVC (){
    
    UITableView     *share_tableView;
    UIView          *_headerView;
    NSArray         *_shareName;
}

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分享";
    _shareName = @[@"weixin.png",@"web.png",@"qq.png"];
    
    
    [self _initViews];;
    [self _initShareView];
    
    [self createdNav];
}

//
-(void)_initViews{
    //分享
    share_tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT+STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT ) style:UITableViewStylePlain];
    share_tableView.delegate = self;
    share_tableView.dataSource = self;
    share_tableView.tableHeaderView = [self headerView];
    share_tableView.rowHeight = 30;
    share_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:share_tableView];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString * identifier = @"shareCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = FONT(13);
    if (indexPath.row == 0) {
        cell.textLabel.text = @"今天已经是第7天运动了，加油！坚持";
        
    }else if (indexPath.row == 1) {
        
        cell.textLabel.text = @"蓝堡";
    }else{
        cell.textLabel.text = @"轻运动，让健康更简单";
    }
    
    
    return cell;
    
}

#pragma mark -- 分享 --- 

-(UIView *)headerView{
    
    if (_headerView == nil) {
         _headerView = [[UIView alloc] init];
        _headerView.bounds = CGRectMake(0, 0,share_tableView.width, 340);
        _headerView.tag = 100;
        //图片
        CGFloat width =  100;
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame =CGRectMake(_headerView.width/2.0 - width - 10 , 40, width, 160);
        imageView.backgroundColor = [UIColor orangeColor];
        imageView.image = [UIImage imageNamed:@"testhead.png"];
        [_headerView addSubview:imageView];
        
        //
        [self createdLabelShowInView:_headerView];
    }
    
    [self showInfoString:100 type:0];
    [self showInfoString:100 type:1];
    
    return _headerView;
}

-(void)showInfoString:(CGFloat) number type:(NSInteger)type{
    
    
    UILabel * step_label = (UILabel *)[_headerView viewWithTag:_headerView.tag +1 + type *2 ];
    UILabel * step_km = (UILabel *)[_headerView viewWithTag:_headerView.tag +2 + type *2];
    
    step_label.text = [NSString stringWithFormat:@"%0.0f",number];

    NSString * string = @"";
    if (type == 0) {
        
        string = [NSString stringWithFormat:@"慢跑了 %f公里",number*1.2/1000];
    }else{
        
        string = [NSString stringWithFormat:@"消耗了 %f份炸鸡",number*1.66/50];
    }
    step_km.text = string;

    
}
#pragma mark -- 跑了多少步 --

-(void)createdLabelShowInView:(UIView *)showView{
    
    for (int i = 0;  i < 2; i ++) {
        
        //步
        CGFloat  right = 25;
        CGFloat  halfwidth = showView.width/2.0;
        CGFloat  top = 60 + 60*i;
        
        NSString * stepstring = @[@"步",@"卡"][i];
        CGSize  stepsize = [MyTool getSizeString:stepstring font:17];
        //步
        UILabel  * stepLabel = [[UILabel alloc] init];
        stepLabel.frame = CGRectMake(showView.width - right-stepsize.width  , top,stepsize.width, stepsize.height);
        stepLabel.text = stepstring;
        stepLabel.font = FONT(17);
        [showView addSubview:stepLabel];
        
        //跑了多少步/消耗多少卡
        UILabel  * mpLabel = [[UILabel alloc] init];
        mpLabel.bounds = CGRectMake(0, 0, stepLabel.left - halfwidth , stepLabel.height + 4);
        mpLabel.center = CGPointMake(halfwidth + mpLabel.width/2.0 + 5, stepLabel.center.y - 4);
        mpLabel.text = @"0";
        mpLabel.tag = showView.tag + 1 + i*2;
        mpLabel.textColor = [UIColor colorWithHexString:@"#14caff"];
        mpLabel.textAlignment = NSTextAlignmentCenter;
        mpLabel.font = FONT(20);
        [showView addSubview:mpLabel];
        
        //线
        [MyTool createLineInView:showView fram:CGRectMake(mpLabel.left, mpLabel.bottom +2, stepLabel.center.x - mpLabel.left, 1)];
        
        //等价于
        UILabel  * equalLabel = [[UILabel alloc] init];
        equalLabel.frame = CGRectMake(mpLabel.left, mpLabel.bottom + 3, halfwidth, 30);
        equalLabel.text = @[@"慢跑了000公里",@"==0份炸鸡"][i];
        equalLabel.tag = showView.tag + 2 +i*2;
        equalLabel.font = FONT(15);
        [showView addSubview:equalLabel];

    }
}



#pragma mark --- 微信分享  --
-(void)_initShareView{
    
    //分享视图View
    UIView  * shareView = [[UIView alloc] init];
    CGFloat  height = 60;
    shareView.frame = CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height);
    shareView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:shareView];
    
    //分享到
    NSString * promstr = @"分享到";
    CGSize  size = [MyTool getSizeString:promstr font:12];
    UILabel * promLabel = [[UILabel alloc] init];
    promLabel.frame = CGRectMake(10, 3, size.width, size.height);
    promLabel.font = FONT(12);
//    promLabel.backgroundColor = [UIColor redColor];
    promLabel.text = promstr;
    [shareView addSubview:promLabel];
    
    //位置
    CGFloat  left = promLabel.center.x;
    CGFloat  width = shareView.height - promLabel.bottom - 8;
    CGFloat between = (shareView.width - left *2 - width *3 )/2.0;
    
    //分享到微信、qq、朋友圈等
    for (int i = 0;  i < 3; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, width, width);
        button.center = CGPointMake(left +button.width/2.0 +(button.width + between)*i, promLabel.bottom+3+ button.width/2.0);
//        button.backgroundColor = [UIColor yellowColor];
        [button setBackgroundImage:[UIImage imageNamed:_shareName[i]] forState:UIControlStateNormal];
        button.tag = i;
        [shareView addSubview:button];
        
        [button addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

//创建头像扥
-(UIView *)createdNav{
   
    UIView  * navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 20, SCREEN_WIDTH, NAV_HEIGHT);
//    navView.backgroundColor = [UIColor redColor];
    //日期
    UILabel * datalabel = [[UILabel alloc] init];
    datalabel.frame = CGRectMake(0, 0, navView.width , 22);
    datalabel.textAlignment = NSTextAlignmentCenter;
    datalabel.font = FONT(16);
    datalabel.textColor = [UIColor blackColor];
    //当前日期
    NSString * dataStr = @"yy-M-dd";
    datalabel.text = [MyTool getCurrentDataFormat:dataStr];
    [navView addSubview:datalabel];
    
    //头像
    UIImageView * headImag = [[UIImageView alloc] init];
    headImag.bounds = CGRectMake(0, 0, 40, 40);
    headImag.center = CGPointMake(20 + headImag.width/2.0,navView.bottom);
    headImag.image = [UIImage imageNamed:@"testhead.png"];
    [navView addSubview:headImag];
    [MyTool cutViewConner:headImag radius:headImag.width/2.0];
    
    //美女
    UILabel *  namelabel= [[UILabel alloc] init];
    namelabel.bounds = CGRectMake(0, 0, 60, 30);
    namelabel.text = @"美女";
    [navView addSubview:namelabel];
    namelabel.font = FONT(15);
    namelabel.center = CGPointMake(headImag.right + 5+ namelabel.width/2.0 , headImag.center.y - 5);
    
    //取消
    UIButton * cancleBtn = [[UIButton alloc] init];
    cancleBtn.bounds = CGRectMake(0, 0, 50, 44);
    cancleBtn.center = CGPointMake(navView.width - 10-cancleBtn.width/2.0, navView.height/2.0);
    [cancleBtn setTitleColor:[UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:1] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [navView addSubview:cancleBtn];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    return navView;

}

#pragma mark -- 分享  --
-(void)shareBtn:(UIButton *)shareBtn{
    
    NSLog(@"分享到%@",@[@"微信",@"微博",@"qq空间"][shareBtn.tag]);
    [share_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --- 
-(void)cancleBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
