//
//  ShareVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "ShareVC.h"
#import "LBSportShareModel.h"
#import "ShareCell.h"

@interface ShareVC (){
    
    UITableView     *share_tableView;
//    UIView          *_headerView;
    NSArray         *_shareName;
    NSArray         * _headImageName;
    NSArray         *_labelTextArray;
    
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
                cell.textLabel.text = [NSString stringWithFormat:@"今天是运动的第%ld天！",(long)newValue];
            }else{
                cell.textLabel.text = @"今天是运动的第1天，请加油，坚持下去！";
            }
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.continuousMovementDays = 1;
    
    // Do any additional setup after loading the view.
    self.title = @"分享";
    _shareName = @[@"weixin.png",@"web.png",@"qq.png"];
    _headImageName = @[@"sd",@"sd",@"sd"];
    _labelTextArray = @[@[@"耗时",@"消耗",@"骑行了"],@[@"",@"卡",@"公里"],@[@"timeshare.png",@"sportshare.png",@"roadshare.png"]];
    
    [self _initViews];
    
    [self createdNav];
}

/**
 *  分享时隐藏一些视图
 */
-(void)hideViewsWhenSharing{
    UIButton * btn = ( UIButton *)[self.view viewWithTag:1200];
    btn.hidden = YES;
    
    btn = (UIButton *)[self.view viewWithTag:1201];
    btn.hidden = YES;
    
    
}
/**
  *  分享时隐藏一些视图
  */
-(void)showViewsWhenSharing{
    UIButton * btn = ( UIButton *)[self.view viewWithTag:1200];
    btn.hidden = NO;
    
    btn = (UIButton *)[self.view viewWithTag:1201];
    btn.hidden = NO;
    
}

/**
 *  友盟分享初始化
 */
-(void)umengShareAlert{
    UITableViewCell *cell = (UITableViewCell *)[share_tableView viewWithTag:1100];
    
    NSString *text = @"蓝堡动感单车";
    if(cell != nil){
        text  = [NSString stringWithFormat:@"今天是运动的第%ld天",(long)self.continuousMovementDays];
    }
    
    [self hideViewsWhenSharing];
    
    UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@UMENG_APP_KEY
                                      shareText:text
                                     shareImage:image
                                     shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,nil]
                                       delegate:self];
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
    [UMSocialData defaultData].extConfig.qzoneData.title = @"蓝堡动感单车";
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://lanbao.app.itboye.com/index.html";
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];

}

//
-(void)_initViews{
    //分享
    share_tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT+STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_HEIGHT-NAV_HEIGHT ) style:UITableViewStylePlain];
    share_tableView.delegate = self;
    share_tableView.dataSource = self;
    share_tableView.tableHeaderView = [self sharHeaderView];
    share_tableView.tableFooterView = [self shareFooterView];
    share_tableView.rowHeight = 30;
    share_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:share_tableView];
    
    
}

#pragma mark -- TableViewDelegate --
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row >=4) {
        return 30;
    }
    return 44;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row <= 2) {
     
        static  NSString * indentifier = @"shareCell";
        ShareCell * cell = (ShareCell *)[tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell== nil) {
            cell = [[ShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];

        }
        //分享数据
        [self shareSportData:cell row:indexPath.row];
        
        return cell;
    }else {
        
        static  NSString * identifier = @"contCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor colorWithHexString:@"#676767"];
            cell.textLabel.font = FONT(18);
        }
        
        if (indexPath.row == 4) {
          
            
            cell.textLabel.attributedText =  [self  sportContinDays];
            cell.tag = 1100;

        } else if (indexPath.row == 5){
            cell.textLabel.text = @"全力以赴，不负自己！加油！坚持！";
            
        }else{
            cell.textLabel.text = @"";
        }
        
        return cell;
    }
}
//连续运动的天数
-(NSMutableAttributedString * )sportContinDays{
    
    UserInfo * userinfo = [MainViewController sharedSliderController].userInfo;
    NSInteger day = userinfo.continuous_day;
    if (day== 0) {
        day = 1;
    }
    NSString *sportstr = [NSString stringWithFormat: @"您已经运动了%ld天",(long)day ];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:sportstr];
    
    //设置颜色
//    if (day >= 10) {
//        
//    }
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#4ab4e4"] range:NSMakeRange(6,sportstr.length-7)]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度
    
   return  attributedString;
    
}
/**
 

 
 **/
//分享数据
-(void) shareSportData:(ShareCell *)cell row:(NSInteger) row{
    
    cell.headImageView.image = [UIImage imageNamed:_labelTextArray[2][row]];
    cell.labelSort.text = _labelTextArray[0][row];
    cell.labelUnit.text = _labelTextArray[1][row];
    LBSportShareModel * lbsport = [LBSportShareModel sharedLBSportShareModel];
    
    switch (row) {
        case 0:
        {
            
            NSDateFormatter* formatter = [NSDate defaultDateFormatter];
            formatter.dateFormat = @"HH:mm:ss";
            NSDate * date = [NSDate dateWithTimeIntervalSince1970: (lbsport.time_min-8*3600)];
//            NSLog(@"date=%@",date);
            cell.valueNum =  [formatter stringFromDate:date];
            
        }  break;
        case 1:
            cell.valueNum = [NSString stringWithFormat:@"%.1f", lbsport.calorie/10];
            break;
        case 2:
            cell.valueNum  = [NSString stringWithFormat:@"%.1f",lbsport.distance/100];
            break;
            
        default:
            break;
    }

}

#pragma mark -- 友盟分享委托


/**
 自定义关闭授权页面事件
 
 @param navigationCtroller 关闭当前页面的navigationCtroller对象
 
 */
-(BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService{
    
    DLog(@"关闭授权页面%@",socialControllerService);
    return NO;
}

/**
 关闭当前页面之后
 
 @param fromViewControllerType 关闭的页面类型
 
 */
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType{
    DLog(@"关闭Uiview");
    
    [self showViewsWhenSharing];
}

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    DLog(@"完成页面执行授权");
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

#pragma mark -- 分享 sharHeaderView---

-(UIView *)sharHeaderView{
    

        UIView * headerView = [[UIView alloc] init];
        headerView.bounds = CGRectMake(0, 0,share_tableView.width, 160);
//        _headerView.tag = 100;
//    //头像
    UIImageView * headImag = [[UIImageView alloc] init];
    headImag.bounds = CGRectMake(0, 0, 100, 100);
    headImag.center = CGPointMake(headerView.width/2 , 50+ headImag.height/2.0);
    headImag.image = [UIImage imageNamed:@"qicheshare.png"];
    headImag.backgroundColor = [UIColor clearColor];
    [headerView addSubview:headImag];
//    UserInfo *user  = [MainViewController sharedSliderController].userInfo;
//    
//    NSURL * avatar_url = [[NSURL alloc]initWithString:[BoyePictureUploadManager getAvatarURL:user.uid  :120]];
//    [headImag setImageWithURL:avatar_url placeholderImage:[UIImage imageNamed:@"testhead.png"]];
//    [headerView addSubview:headImag];
//    [MyTool cutViewConner:headImag radius:headImag.width/2.0];
    return headerView;
}
#pragma mark -- 分享 shareFooterView---

-(UIView *)shareFooterView{
    
    CGFloat  height = share_tableView.width/2.1;
    UIView * shareView = [[UIImageView alloc] init];
    shareView.backgroundColor = [UIColor clearColor];
    shareView.frame = CGRectMake(0, 0, share_tableView.width, height);
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:shareView.frame];
    imageView.image =[UIImage imageNamed:@"dibu.png"];
    [shareView addSubview:imageView];
    
    return shareView;
}

//创建头像,顶部导航
-(void )createdNav{
    //取消
    CGFloat rightspace = 10 ;
    UIButton * cancleBtn = [[UIButton alloc] init];
    cancleBtn.tag = 1201;
    cancleBtn.bounds =  CGRectMake(0, 0, 50, 44);
    cancleBtn.center =  CGPointMake(rightspace + cancleBtn.width/2.0, NAV_HEIGHT/2.0);
    [cancleBtn setTitleColor:[UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:1] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //提交
    UIButton * submitBtn = [[UIButton alloc] init];
    submitBtn.tag = 1200;
    submitBtn.bounds = CGRectMake(0, 0, 50  ,44);
    submitBtn.center = CGPointMake(SCREEN_WIDTH - rightspace-submitBtn.width/2.0, NAV_HEIGHT/2.0);
    [submitBtn setTitleColor:[UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:1] forState:UIControlStateNormal];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:cancleBtn];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"蓝堡动感单车"];
    [item setLeftBarButtonItem:leftButton];
    [item setRightBarButtonItem:rightButton];
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT, SCREEN_WIDTH, NAV_HEIGHT)];
    
    [bar pushNavigationItem:item animated:YES];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [self.view addSubview:bar];
    
}

#pragma mark -- 分享  --
-(void)shareBtn:(UIButton *)shareBtn{
    
    DLog(@"分享到%@",@[@"微信",@"微博",@"qq空间"][shareBtn.tag]);
    [share_tableView reloadData];
}

#pragma mark -- 提交 --
-(void)submitBtnClick{
    
    DLog(@"分享");
    
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
