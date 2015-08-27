//
//  MainViewController.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//



#import "MainViewController.h"
#import "PersonCenterVC.h"
#import "ShareVC.h"
#import "GoalVC.h"
#import "LetfView.h"
#import "HeadPageVC.h"
#import "BoyeGoalLocaNotify.h"
@interface MainViewController ()<BOYEBluetoothStateChangeDelegate>{
    
    CGFloat         _slidepy;

    UIButton        * select_button;//记录选中按钮；
    
    NSMutableArray  *  array; //保存导航
    NSArray         * sortName;
    NSArray         * _btnNormalImagName;
    NSArray         * _btnSelectImagName;
    NSInteger        _upTimeInterval; //上传时间间隔
}


@property (nonatomic,strong) NSArray                        * viewcontrollers;
@property (nonatomic,strong) NSMutableArray                 * buttonArray;
@property (nonatomic,strong) BoyeBluetooth                  * boyeBluetooth;
@property (nonatomic,strong) NSDate                         * lastUpLoadDateTime; //下一个上传时间

@end

@implementation MainViewController


#pragma mark getter/setter

-(void)isOpen:(BOOL)toggle{
    
    self->_isOpen = toggle;
    if(toggle == YES && self.leftView != nil){
        [self.leftView willAppear];
    }
}




-(NSDate *)lastUpLoadDateTime:(NSDate *)lastUpLoadDateTime{
    if (_lastUpLoadDateTime == nil) {
        _lastUpLoadDateTime = [NSDate date];
    }
    _lastUpLoadDateTime = lastUpLoadDateTime;
    return _lastUpLoadDateTime;
}

-(void)viewWillAppear:(BOOL)animated{

    [self mainViewAppearBefore];
    [self dealNotifyInit];
}
-(void)dealNotifyInit{
    
    if (self.isVCCancel== NO) {
        
    }
    
}
-(void) mainViewAppearBefore{
    
    self.boyeBluetooth  = [BoyeBluetooth sharedBoyeBluetooth];
    self.boyeBluetooth.delegate = self;
    
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
    if (self.buttonArray) {
        
        [self buttonPress:self.buttonArray[0]];//
    }
    
    [self creatLeftView];
    [CommonCache setGoal:[NSNumber numberWithInteger:500]];
    //移除所有非当前用户目标闹铃提醒
    [BoyeGoalLocaNotify removeAllLocalNotifyOutUser:self.userInfo.uid ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _slidepy = SCREEN_WIDTH/2.0;
    
    _upTimeInterval = 10  ;
    
    
    self.title = @"main";
    self.buttonArray = [[NSMutableArray alloc] initWithCapacity:0];
    sortName = @[@"首页",@"目标",@"个人中心",@"分享"];
    _btnNormalImagName = @[@"home.png",@"target.png",@"person.png",@"share.png"];
    _btnSelectImagName = @[@"homeon.png",@"targeton.png",@"personon.png",@"shareon.png"];
    
    
    
    //创建视图
    [self _initViews];

}

//初始化视图
-(void)_initViews{

    //创建自定义tabba
    
    [self creatTabbar];
    //左视图
    [self creatLeftView];
    //添加侧滑手势
    [self _initGesture];
    
}
#pragma mark --- 创建自定义tabbar--

-(void)creatTabbar{
    
    if (_contentView  != nil) {
        return;
    }
    
    //包含视图
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    //底部视图
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(_contentView.left, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [MyTool createLineInView:_bottomView fram:CGRectMake(0, 0, _bottomView.width, 1)];
    
//    _bottomView.backgroundColor = [UIColor colorWithRed:(14/255.0) green:(144/255.0) blue:(210/255.0) alpha:1];
    [self.view addSubview:_bottomView];
    

    
    //个人中心
    PersonCenterVC *  person = [[PersonCenterVC alloc] init];
    UINavigationController * navp = [[UINavigationController alloc] initWithRootViewController:person];
   
    //目标
    GoalVC * goal  = [[GoalVC alloc] init];
    UINavigationController * navg = [[UINavigationController alloc] initWithRootViewController:goal];
    
    //首页
    
    HeadPageVC *head = [[HeadPageVC alloc] init];
    UINavigationController * navh = [[UINavigationController alloc] initWithRootViewController:head];
    
    self.viewcontrollers = @[navh,navg,navp];

    //底部按钮
    for (int i = 0;  i < 4;  i ++) {

        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=i;
        [button setBackgroundImage:[UIImage imageNamed:_btnNormalImagName[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:_btnNormalImagName[i]] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:_btnSelectImagName[i]] forState:UIControlStateSelected];
//        //底部按钮
        [BBManageCode creatTabbarShow:_bottomView
                               button:button
                             ImagName:nil
                           titleLabel:sortName[i]];
        
       
        [self.buttonArray addObject:button];
        
        if (i==0) {
            [self buttonPress:button];
        }
        
        //底部按钮的覆盖层按钮
        UIButton * upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        upButton.tag = i;
        upButton.bounds = CGRectMake(0, 0, _bottomView.width/4.0, _bottomView.height);
        upButton.center = CGPointMake(upButton.width * i + upButton.width/2.0  , _bottomView.height/2.0);
        [_bottomView addSubview:upButton];
        [upButton addTarget:self
                   action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];

    }

}

#pragma mark -- 点击事件 --
-(void)buttonPress:(UIButton *)button{
    
        
    if (button.tag == 3) {
        ShareVC * share = [[ShareVC alloc] init];
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:share];

        [self  presentViewController:share animated:YES completion:nil];
        
    }else{
        
        
        UIViewController * vc = self.viewcontrollers[button.tag];
        
        if ([_contentView.subviews containsObject:vc.view]) {
            [_contentView bringSubviewToFront:vc.view];
        }else{
            
            [_contentView addSubview:vc.view];
        }
        
        select_button.selected = NO;
        select_button = self.buttonArray[button.tag];
        select_button.selected = YES;
        
    }

    
    //字体颜色改变
    for (int i = 0; i < sortName.count; i ++) {
        UILabel * label = (UILabel *)[_bottomView viewWithTag:i+1];
        if (button.tag == i) {
            label.textColor = [UIColor colorWithHexString:@"#28cafb"];
        }else{
            label.textColor = [UIColor lightGrayColor];
        }
    }
    
    self.navigationController.navigationBarHidden = YES;

}

#pragma mark --- 添加手势 侧滑---

-(void) _initGesture {
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [_contentView addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer * swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
    [_contentView addGestureRecognizer:swipRight];
    
    UISwipeGestureRecognizer * swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipLeftGesture:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_contentView addGestureRecognizer:swipLeft];

}


//点击
-(void)tapGesture:(UITapGestureRecognizer *)gesture{

    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (_contentView.left > 10) {
            [self moveLeft];
        }
    }
}
//轻扫右
-(void)swipGesture:(UISwipeGestureRecognizer *)gesture{
    [self moveRight];
}
//轻扫左
-(void)swipLeftGesture:(UISwipeGestureRecognizer *)gesture{
    [self moveLeft];
}
//close
-(void)moveLeft{

    CGFloat timer = 0.2;
    CGRect rect = CGRectMake(0, 0, _contentView.width, _contentView.height);
    [MyTool setAnimationView:_contentView duration:timer rect:rect];
    [MyTool setAnimationCentView:_bottomView
                        duration:timer
                       pointCent:CGPointMake(_contentView.center.x, _bottomView.center.y)];
    [_bottomView setUserInteractionEnabled:YES];
    [MyTool touchAbleSonView:_contentView able:YES];
    self.isOpen = NO;
}
//open
-(void)moveRight{
    
    CGFloat timer = 0.2;
    CGRect rect = CGRectMake(_slidepy, 0, _contentView.width, _contentView.height);
    [MyTool setAnimationView:_contentView duration:timer rect:rect];
    [MyTool setAnimationCentView:_bottomView
                        duration:timer
                       pointCent:CGPointMake(_contentView.center.x, _bottomView.center.y)];
    [_bottomView setUserInteractionEnabled:NO];
        [MyTool touchAbleSonView:_contentView able:NO];
   self.isOpen = YES;
}

#pragma mark -- 创建单例 --

+ (MainViewController*)sharedSliderController
{
    static MainViewController *VC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        VC = [[self alloc] init];
    });
    
    return VC;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark -- 创建左视图 --

-(void)creatLeftView{
    
    if (_leftView == nil) {
        _leftView = [[LetfView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, SCREEN_HEIGHT)];
        [self.view addSubview:_leftView];
        [self.view sendSubviewToBack:_leftView];
        _leftView.delegate = self;
    }
    [_leftView willAppear];
    _leftView.leftInfo = [MainViewController sharedSliderController].userInfo;
}

///  *************         从相册区图片-      ************************  //

//letfViewDelegate
-(void)letfView:(LetfView *)letfView{
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:(id)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍一张照",@"从相册中选", nil];
    [actionSheet showInView:self.view];
    

}


#pragma mark --- 从相册区图片--
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        //如果相册功能不可用使用相册
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.tabBarItem.tag = 0;
        
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        
        //进入照相界面
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if(buttonIndex == 1) {
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            DLog(@"照相不可用");
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.tabBarItem.tag = 1;
        
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        ;//进入照相界面
        
        [self presentViewController:picker animated:YES completion:nil];
        
        
    }
    
}


#pragma mark  ---   图片选择器    ---

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    //    if (picker.tabBarItem.tag == 0)
    //    {
    //        //        //如果是 来自照相机的image，那么先保存
    //                UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //                UIImageWriteToSavedPhotosAlbum(original_image, self,
    //                                               @selector(image:didFinishSavingWithError:contextInfo:),
    //                                              nil);
    //    }
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        
        //先把图片转成NSData
        UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
        [_leftView.headBtn setBackgroundImage:image forState:UIControlStateNormal];
        NSData * data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 1.0);
            
        }else{
            data = UIImagePNGRepresentation(image);
        }
        image = nil;
        image = [[ UIImage alloc ]initWithData:data];
        
       [ _leftView.headBtn setImage:image forState:UIControlStateNormal];
        
        NSString * fileImage =  [BoyeFileMagager getDocumentsImageFile:data userID:self.userInfo.uid];
        
        //图片上传请求
        PictureReqModel * picModel = [[PictureReqModel alloc] init];
        picModel.uid = self.userInfo.uid;
        picModel.type = @"avatar";
        picModel.filePath = fileImage;
        
        [BoyePictureUploadManager requestPictureUpload:picModel :^(NSDictionary *data){
            DLog(@"图片上传=%@",data);
            //刷新头像缓存
//            NSURL * avatar_url = [[NSURL alloc]initWithString:[BoyePictureUploadManager getAvatarURL:self.userInfo.uid :120 :YES]];
            [self.leftView willAppear];
        }:nil];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark --- 蓝牙数据处理 Delegate ----

//
-(void)bluetoothStateChange:(id)sender :(enum BOYE_BLUETOOTH_STATE_EVENT)stateEvent :(id)parms{
    NSDictionary * info = (NSDictionary *)parms;
    
    DLog(@"委托蓝牙状态变更！%u",stateEvent);
    
    switch (stateEvent) {
        case STATE_CHANGE:
            
//            [];
//            [self bluetoothUpdateState];
            break;
        case STATE_CONNECTED_DEVICE:
            DLog(@"连接上一台设备!");
//            [self didConnectDevice];
            break;
        case STATE_DISCONNECT_DEVICE:
            DLog(@"断开上一台设备!");
//            [self disConnectDevice];
            break;
        case STATE_DISCOVERED_SERVICE:
//            [self didDiscoverServices:[info objectForKey:@"error"]];
            break;
        case STATE_DISCOVERED_CHARACTERISTICS:
//            [self didDiscoverCharacteristicsForService:[info objectForKey:@"data"] error:[info objectForKey:@"error"]];
            break;
        case STATE_UPDATE_VALUE:
        {
            CBCharacteristic * characteristic = (CBCharacteristic *)[info objectForKey:@"data"];
            
            NSString * dataValue = [self dataToString:characteristic.value];
            [self updateValue:dataValue];
            
        }
        default:
            break;
    }
    
}

-(void)updateValue:(NSString *)dataString{
    DLog(@" datastring: %@",dataString);
    
        
}

- (NSString * )dataToString:(NSData *)value{
    
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [value bytes];
    
    for (int i=0; i < [value length]; i++) {
        [hexString appendFormat:@"%02x", *p++];
    }
    
    return [hexString lowercaseString];
    
}

//下次上传的时间
-(void) dataUpload:(NSString *)dataString{
    
    if ([[NSDate date] isOutSetDateTime:_lastUpLoadDateTime]) {
        
        //TODO ...数据上传
        
         //下次上传时间
        _lastUpLoadDateTime = [[NSDate date] dateByAddingTimeInterval:_upTimeInterval];

    }
    
}

-(void) saveB{
    
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
