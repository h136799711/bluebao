//
//  LetfView.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "LetfView.h"
#import "LeftMenuCell.h"

#import "AppDelegate.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "BoyeGoalLocaNotify.h"
#import "BoyeDataBaseManager.h"

#import "PersonMessageVC.h"//个人资料
#import "BlueBaoAboutVC.h" // 关于蓝堡
#import "MoreExereqBuyVC.h" 
#import "SettingVC.h"
#import "PeopleGoalManagerVC.h"
#import "HistoryViewController.h"

@interface LetfView(){
    
    NSArray   * sortArray;
    MainViewController  * mainVC;
    
}
@property (nonatomic,strong) UserInfo * userinfo;
@end

@implementation LetfView


-(instancetype)initWithFrame:(CGRect)frame{
    
   self =  [super initWithFrame:frame];
    if (self) {
        
        mainVC = [MainViewController sharedSliderController];
        [self _initViews];
    }
    return self;
}



-(void)_initViews
{
    
    self.userinfo =  [MainViewController sharedSliderController].userInfo;
    self.left_tableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.left_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.left_tableView.delegate = self;
    self.left_tableView.dataSource = self;
    //    self.tableView.rowHeight = LEFT_MENU_HEIGHT;
        self.left_tableView.tableHeaderView = [self creatTableViewHeadView];
    [self addSubview:self.left_tableView];
    

    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.left_tableView.bounds];
    bgImgView.image = [UIImage imageNamed:@"left_menu_bg"];
    self.left_tableView.backgroundView = bgImgView;
    self.left_tableView.backgroundColor = [UIColor clearColor];
    sortArray = @[@"我的个人资料",@"设备管理",@"我的运动数据",@"我的目标管理",@"关于蓝堡",@"购买更多健身器材",@"闹铃开关",@"设置",@"注销"];
}

-(void)willAppear{
    
    DLog("************LEFTVIEW**************");
    self.userinfo =  [MainViewController sharedSliderController].userInfo;
    [self setAvatar];
    
    UILabel * lblSign =  (UILabel *)[self.left_tableView.tableHeaderView viewWithTag:1005];
    
    lblSign.text = self.userinfo.signature;
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sortArray.count;
}

#pragma mark -- 左边视图 --
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"leftMenuCell";
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = sortArray[indexPath.row];
    cell.textLabel.font = FONT(12);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.row == sortArray.count -3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        UISwitch * stch = [[UISwitch alloc] init];
        stch.bounds = CGRectMake(0, 0, 50, 30);
        stch.center = CGPointMake(tableView.width - stch.width/2.0 - 10,cell.contentView.center.y );
        stch.on = [LocalNotify sharedNotify].isNotify;
        [stch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:stch];
    }
    
    
    return cell;
}

#pragma mark -- 选中之后--
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
   //注销
    if (indexPath.row == sortArray.count-1) {
      
        LoginVC * login = [LoginVC sharedSliderController];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        window.rootViewController = nav;
        
        //是
        [MainViewController sharedSliderController].isVCCancel  = NO;

        //设备管理
    } else if (indexPath.row == 0){
            //个人资料
        PersonMessageVC * person = [[PersonMessageVC alloc] init];
        [[MainViewController sharedSliderController].navigationController pushViewController:person animated:YES];

        //设备管理
    } else if (indexPath.row == 1){
      
        [self jumpToequipmentManager];
        
        //我的运动数据
    } else if (indexPath.row == 2){
        
        HistoryViewController * peoSport = [[HistoryViewController alloc] init];
        [[MainViewController sharedSliderController].navigationController pushViewController:peoSport animated:YES];
        
        //我的目标管理
    }else if (indexPath.row == 3){
        
        PeopleGoalManagerVC * goal = [[PeopleGoalManagerVC alloc] init];
       [[MainViewController sharedSliderController].navigationController pushViewController:goal animated:YES];
        
        //关于蓝堡
    } else if (indexPath.row == 4){
      
        BlueBaoAboutVC * aboutVC = [[BlueBaoAboutVC alloc] init];
        [[MainViewController sharedSliderController].navigationController pushViewController:aboutVC animated:YES];

        //购买更多器材
    } else if (indexPath.row == 5){

        MoreExereqBuyVC * moreVC = [[MoreExereqBuyVC alloc] init];
        [[MainViewController sharedSliderController].navigationController pushViewController:moreVC animated:YES];
      
          //设置
    }  else if (indexPath.row == 7){
      
        SettingVC  * setVC = [[SettingVC alloc] init];
        [[MainViewController sharedSliderController].navigationController pushViewController:setVC animated:YES];

    }
    
    else{
        
        return;
    }
    
    [[MainViewController sharedSliderController] moveLeft];
    
 }

#pragma mark -- 创建去区头 --

-(void)setAvatar{
    
    NSURL * avatar_url = [[NSURL alloc]initWithString:[BoyePictureUploadManager getAvatarURL:self.userinfo.uid :120 :YES]];
    avatar_url = [[NSURL alloc]initWithString:[BoyePictureUploadManager getAvatarURL:self.userinfo.uid :120 :YES]];
    DLog(@"头像地址:%@",avatar_url);
    [self.headBtn setImageWithURL:avatar_url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Default_header"]];

}

-(UIView *)creatTableViewHeadView{
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 100)];
//    headView.backgroundColor = [UIColor lightGrayColor];
    headView.tag = 1105;
    //头像
    self.headBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
     self.headBtn.bounds = CGRectMake(0, 0, 40, 40);
     self.headBtn.center = CGPointMake(10+ self.headBtn.width/2.0,  self.headBtn.height/2.0 + 40);
    [headView addSubview: self.headBtn];
    
    [self.headBtn addTarget:self action:@selector(changeHeadImagClick:) forControlEvents:UIControlEventTouchUpInside];

    
    
     self.headBtn.backgroundColor = [UIColor redColor];
    [MyTool cutViewConner: self.headBtn radius: self.headBtn.width/2.0];
    
    //签名
    UILabel * label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, 100, 12);
    label.center = CGPointMake( self.headBtn.right+ 10+ label.width/2.0,  self.headBtn.center.y + label.height/2.0);
//    label.text = @"请编辑签名";
    label.text = self.userinfo.signature;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    [headView addSubview:label];
    label.font = [UIFont boldSystemFontOfSize:10];
    label.tag = 1005;
    
    
    //编辑签名
   self.signTextfield = [[UITextField alloc] init];
//  signTextfield.frame = CGRectMake(label.left, headBtn.center.y - headBtn.height/2.0 - 16, headView.width - headBtn.right - 15 , 30);
    self.signTextfield.bounds = CGRectMake(0, 0,headView.width -  self.headBtn.right - 15 , 30);
    self.signTextfield.center = CGPointMake(label.center.x,  self.headBtn.center.y - self.signTextfield.height/2.0);
    self.signTextfield.textAlignment = NSTextAlignmentCenter;
    self.signTextfield.text = self.userinfo.nickname;
    [headView addSubview:self.signTextfield];
    self.signTextfield.font = [UIFont boldSystemFontOfSize:13];
    self.signTextfield.enabled = NO;
    
    //线
    UIView * line =     [MyTool createLineInView:headView fram:CGRectMake(0, headView.height, headView.width, 0.5)];
    line.backgroundColor = [UIColor blackColor];
    
    return headView;
}


-(void)setLeftInfo:(UserInfo *)leftInfo{
    
    
    _signTextfield.text = leftInfo.nickname;
}




/**
 *  闹铃提醒开关
 *
 *  @param stch UISwitch
 */
-(void)switchClick:(UISwitch *)stch{
    
    if (stch.isOn) {
        
        [[LocalNotify sharedNotify] turnOn];
        
        //TODO: 再次读取，提醒设置，发送通知。
        [self reloadAllAlarm];
//        NSDate * date = [[NSDate date] dateByAddingTimeInterval:6];
//        [[LocalNotify sharedNotify]fireNotification:@"123456" At:date WithContent:@"测试" HasInterval:NSCalendarUnitMinute];
        
    }else{
        [[LocalNotify sharedNotify] turnOff];
        [[LocalNotify sharedNotify] cancelAll];
    }
    
    DLog(@"闹铃");
   // [self localNotification];
}
#pragma mark -- 闹铃开关 --

/**
 *  读取提醒设置，并注册本地通知。
 */
-(void)reloadAllAlarm{
    
    
    NSArray * goalModelArr = [BoyeDataBaseManager getAllDataUserID:[MainViewController sharedSliderController].userInfo.uid];
    
    [BoyeDataBaseManager test:goalModelArr];
    
    
    for (BoyeGoaldbModel * model in goalModelArr) {
        [BoyeGoalLocaNotify removeLocalNotifyKey:model.db_id];
        [self registerLocalNotify:model];
    }
}


-(void)registerLocalNotify:(BoyeGoaldbModel *)model{
    
    NSDate * nowDate =  [NSDate date];
    NSString * dataFormatt = @"yyyy-MM-dd";
    NSString *  timestr = [MyTool getCurrentDateFormat:dataFormatt];
    NSString * datestring = [NSString stringWithFormat:@"%@ %@",timestr,model.date_time];
    
    
    NSDate  * date = [[MyTool  getDateFormatter:@"yyyy-MM-dd HH:mm"] dateFromString:datestring];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:nowDate];
    
    NSInteger selectWeekday = model.weekday + 2;
    
    //转换成周日＝1 周一=2 周二＝3
    if (selectWeekday == 8) {
        selectWeekday = 1;
    }
    
    NSInteger intervalDay =  selectWeekday - comps.weekday;
    
    DLog(@"相差天数%ld" , (long)intervalDay);
    NSDate * fireDate = [date dateByAddingTimeInterval:intervalDay*24*3600];
    
    NSComparisonResult result = [date compare:nowDate];
    if ( result == NSOrderedAscending) {
        fireDate =  [date dateByAddingTimeInterval:7*24*3600];
    }
    
    model.fireDate = fireDate;
    
    [BoyeGoalLocaNotify setLocalNotifyGoal:model];
}

-(void)localNotification{
    
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate date];
        notification.fireDate=[now dateByAddingTimeInterval:10];//10秒后通知
        notification.repeatInterval=kCFCalendarUnitMinute;//循环次数
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=@"通知内容";//提示信息 弹出提示框
        notification.alertAction = @"打开";  //提示框按钮
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
        //NSDictionary*infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        //notification.userInfo = infoDict; //添加额外的信息
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

#pragma mark --- 头像 ---
-(void)changeHeadImagClick:(UIButton *)headBtn{
  
    //头像代理
    if ([_delegate respondsToSelector:@selector(letfView:)]) {
        [_delegate letfView:self];
    }
}

-(void)setDelegate:(id<LetfViewDelegate>)delegate{
    _delegate = delegate;
}

-(void)jumpToequipmentManager{
    
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"new" bundle:nil];
    if (secondStroyBoard == nil) {
        return;
    }
    UIViewController *test2obj=[secondStroyBoard instantiateViewControllerWithIdentifier:@"device"];
    [[MainViewController sharedSliderController].navigationController pushViewController:test2obj animated:YES];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
