//
//  ShareVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "ShareVC.h"
#import "LBSportShareModel.h"
@interface ShareVC (){
    
    UITableView     *share_tableView;
    UIView          *_headerView;
    NSArray         *_shareName;
}

@property (nonatomic) NSInteger continuousMovementDays;

@end

@implementation ShareVC

-(void)continuousMovementDays:(NSInteger)newValue{
    
    if (share_tableView != nil) {
        _continuousMovementDays = newValue;
        UITableViewCell *cell = (UITableViewCell *)[share_tableView viewWithTag:1100];
        if(cell != nil){
            if(newValue > 1){
                cell.textLabel.text = [NSString stringWithFormat:@"今天已经是第%ld天运动了，加油，坚持！",(long)newValue];
            }else{
                cell.textLabel.text = @"今天是第1天运动，请加油，坚持下去！";
            }
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.continuousMovementDays = 1;
    // Do any additional setup after loading the view.
    self.title = @"分享";
    _shareName = @[@"weixin.png",@"web.png",@"qq.png"];
    
    
    [self _initViews];;
//    [self _initShareView];
    
    [self createdNav];
    
//    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
    //    [self umengShareInit];
//    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];

}

/**
 *  分享时隐藏一些视图
 */
-(void)hideViewsWhenSharing{
    UIButton * btn = ( UIButton *)[self.view viewWithTag:1200];
    btn.hidden = YES;
    
    btn = (UIButton *)[self.view viewWithTag:12001];
    btn.hidden = YES;
    
    
}
/**
  *  分享时隐藏一些视图
  */
-(void)showViewsWhenSharing{
    UIButton * btn = ( UIButton *)[self.view viewWithTag:1200];
    btn.hidden = NO;
    
    btn = (UIButton *)[self.view viewWithTag:12001];
    btn.hidden = NO;
    
    
}

/**
 *  友盟分享初始化
 */
-(void)umengShareAlert{
    UITableViewCell *cell = (UITableViewCell *)[share_tableView viewWithTag:1100];
    
    NSString *text = @"蓝堡健身,我的最爱!";
    if(cell != nil){
        text  = [NSString stringWithFormat:@"今天已经是第%ld天运动了，加油！坚持",(long)self.continuousMovementDays];
    }
    text = nil;
    [self hideViewsWhenSharing];
    
    UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@UMENG_APP_KEY
                                      shareText:text
                                     shareImage:image
                                     shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,nil]
                                       delegate:self];
    
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://lanbao.app.itboye.com/index.html";
    
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
        UserInfo * userinfo = [MainViewController sharedSliderController].userInfo;
        cell.textLabel.text =[NSString stringWithFormat: @"今天已经是第%ld天运动了，加油！坚持",userinfo.continuous_day ];
        cell.tag = 1100;
        
    }else if (indexPath.row == 1) {
        
        cell.textLabel.text = @"蓝堡";
    }else{
        cell.textLabel.text = @"轻运动，让健康更简单";
    }
    
    
    return cell;
    
}

#pragma mark -- 友盟分享委托


/**
 自定义关闭授权页面事件
 
 @param navigationCtroller 关闭当前页面的navigationCtroller对象
 
 */
-(BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService{
    
    NSLog(@"关闭授权页面%@",socialControllerService);
    return NO;
}

/**
 关闭当前页面之后
 
 @param fromViewControllerType 关闭的页面类型
 
 */
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType{
    NSLog(@"关闭Uiview");
    
    [self showViewsWhenSharing];
}

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"完成页面执行授权");
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        [SVProgressHUD showSuccessWithStatus:@"分享成功!"  withDuration:2 ];
    }else{
        [SVProgressHUD showErrorWithStatus:@"分享失败!" withDuration:3];
    }
    
}




/**
 配置点击分享列表后是否弹出分享内容编辑页面，再弹出分享，默认需要弹出分享编辑页面
 
 @result 设置是否需要弹出分享内容编辑页面，默认需要
 
 */
//-(BOOL)isDirectShareInIconActionSheet{
//    return NO;
//}

#pragma mark -- 分享 ---

-(UIView *)headerView{
    
    if (_headerView == nil) {
         _headerView = [[UIView alloc] init];
        _headerView.bounds = CGRectMake(0, 0,share_tableView.width, 300);
        _headerView.tag = 100;
        //图片
        CGFloat width =  100;
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame =CGRectMake(40  , 60, width, 160);
        imageView.backgroundColor = [UIColor orangeColor];
        imageView.image = [UIImage imageNamed:@"testhead.png"];
        [_headerView addSubview:imageView];
        
        //
        [self createdLabelShowInView:_headerView];
    }
    LBSportShareModel * lbsport = [LBSportShareModel sharedLBSportShareModel];

    NSInteger step = (NSInteger) (lbsport.distance * 1000 /(1.2* 100));
    
    [self showInfoString:step type:0];
    [self showInfoString:lbsport.calorie/10 type:1];
    
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
        CGFloat  top = 80 + 60*i;
        
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
//-(void)_initShareView{
//    
//    //分享视图View
//    UIView  * shareView = [[UIView alloc] init];
//    CGFloat  height = 60;
//    shareView.frame = CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height);
//    shareView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:shareView];
//    
//    //分享到
//    NSString * promstr = @"分享到";
//    CGSize  size = [MyTool getSizeString:promstr font:12];
//    UILabel * promLabel = [[UILabel alloc] init];
//    promLabel.frame = CGRectMake(10, 3, size.width, size.height);
//    promLabel.font = FONT(12);
////    promLabel.backgroundColor = [UIColor redColor];
//    promLabel.text = promstr;
//    [shareView addSubview:promLabel];
//    
//    //位置
//    CGFloat  left = promLabel.center.x;
//    CGFloat  width = shareView.height - promLabel.bottom - 8;
//    CGFloat between = (shareView.width - left *2 - width *3 )/2.0;
//    
//    //分享到微信、qq、朋友圈等
//    for (int i = 0;  i < 3; i++) {
//        
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.bounds = CGRectMake(0, 0, width, width);
//        button.center = CGPointMake(left +button.width/2.0 +(button.width + between)*i, promLabel.bottom+3+ button.width/2.0);
////        button.backgroundColor = [UIColor yellowColor];
//        [button setBackgroundImage:[UIImage imageNamed:_shareName[i]] forState:UIControlStateNormal];
//        button.tag = i;
//        [shareView addSubview:button];
//        
//        [button addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//}

//创建头像,顶部导航
-(UIView *)createdNav{
   
    UIView  * navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 20, SCREEN_WIDTH, NAV_HEIGHT);
//    navView.backgroundColor = [UIColor redColor];
    //日期
    UILabel * datalabel = [[UILabel alloc] init];
    datalabel.frame = CGRectMake(0, 0, navView.width , 44);
    datalabel.textAlignment = NSTextAlignmentCenter;
    datalabel.font = FONT(18);
    datalabel.textColor = [UIColor blackColor];
    //当前日期
    NSString * dataStr = @"yyyy年MM月dd日";
    datalabel.text = [MyTool getCurrentDataFormat:dataStr];
    [navView addSubview:datalabel];
    
    //头像
    UIImageView * headImag = [[UIImageView alloc] init];
    headImag.bounds = CGRectMake(0, 0, 40, 40);
    headImag.center = CGPointMake(SCREEN_WIDTH/2  - 20,navView.bottom+10);
    UserInfo *user  = [MainViewController sharedSliderController].userInfo;
    
    NSURL * avatar_url = [[NSURL alloc]initWithString:[BoyePictureUploadManager getAvatarURL:user.uid  :120]];
    [headImag setImageWithURL:avatar_url placeholderImage:[UIImage imageNamed:@"testhead.png"]];
    
    [navView addSubview:headImag];
    [MyTool cutViewConner:headImag radius:headImag.width/2.0];
    
    //昵称
    UILabel *  namelabel= [[UILabel alloc] init];
    namelabel.bounds = CGRectMake(0, 0, 60, 30);
    namelabel.text = user.nickname;
    [navView addSubview:namelabel];
    namelabel.font = FONT(15);
    namelabel.center = CGPointMake(headImag.right + 5+ namelabel.width/2.0 , headImag.center.y - 5);
    
    //取消
    CGFloat rightspace = 10 ;
    UIButton * cancleBtn = [[UIButton alloc] init];
    cancleBtn.tag = 1201;
    cancleBtn.bounds =  CGRectMake(0, 0, 50, 44);
    cancleBtn.center =  CGPointMake(rightspace + cancleBtn.width/2.0, navView.height/2.0);
    [cancleBtn setTitleColor:[UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:1] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [navView addSubview:cancleBtn];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //提交
    UIButton * submitBtn = [[UIButton alloc] init];
    submitBtn.tag = 1201;
    submitBtn.bounds = CGRectMake(0, 0, cancleBtn.width, cancleBtn.height);
    submitBtn.center = CGPointMake(navView.width - rightspace-submitBtn.width/2.0, navView.height/2.0);
    [submitBtn setTitleColor:[UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:1] forState:UIControlStateNormal];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [navView addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    return navView;

}

#pragma mark -- 分享  --
-(void)shareBtn:(UIButton *)shareBtn{
    
    NSLog(@"分享到%@",@[@"微信",@"微博",@"qq空间"][shareBtn.tag]);
    [share_tableView reloadData];
}

#pragma mark -- 提交 --
-(void)submitBtnClick{
    
    NSLog(@"分享");
    
    [self umengShareAlert];
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
