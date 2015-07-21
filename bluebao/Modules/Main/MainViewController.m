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

@interface MainViewController (){
    
    CGFloat    _slidepy;
    
    UIView   *_contentView;
    UIView  * _bottomView;  // 底部视图
    UIButton  * select_button;//记录选中按钮；
    
    NSMutableArray *  array; //保存导航
    NSArray     * sortName;
    NSArray     *_btnNormalImagName;
    NSArray     *_btnSelectImagName;
}


@property (nonatomic,strong) NSArray   * viewcontrollers;
@end

@implementation MainViewController



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _slidepy = SCREEN_WIDTH/2.0;
    
    
    //创建视图
    [self _initViews];
   
}

//初始化视图
-(void)_initViews{
    
    self.title = @"main";
    
    sortName = @[@"首页",@"目标",@"个人中心",@"分享"];
    _btnNormalImagName = @[@"home.png",@"target.png",@"person.png",@"share.png"];
    
    
    
    //创建自定义tabba
    
    [self creatTabbar];
    //左视图
    [self creatLeftView];
    //添加侧滑手势
    [self _initGesture];
    
}

#pragma mark -- 创建左视图 --

-(void)creatLeftView{
    
    LetfView * left = [[LetfView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, SCREEN_HEIGHT)];
    [self.view addSubview:left];
    [self.view sendSubviewToBack:left];
    
}



#pragma mark --- 创建自定义tabbar--

-(void)creatTabbar{
    
    
    //包含视图
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    //底部视图
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(_contentView.left, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    _bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_bottomView];
    

    
    //个人中心
    PersonCenterVC *  person = [[PersonCenterVC alloc] init];
    person.title = @"person";
    UINavigationController * navp = [[UINavigationController alloc] initWithRootViewController:person];
    
    //分享
    ShareVC * share = [[ShareVC alloc] init];
    share.title = @"share";
    UINavigationController * navs = [[UINavigationController alloc] initWithRootViewController:share];
    
    //目标
    GoalVC * goal  = [[GoalVC alloc] init];
    goal.title = @"goal";
    UINavigationController * navg = [[UINavigationController alloc] initWithRootViewController:goal];
    
    //首页
    
    HeadPageVC *head = [[HeadPageVC alloc] init];
    head.title = @"head";
    UINavigationController * navh = [[UINavigationController alloc] initWithRootViewController:head];
    
    self.viewcontrollers = @[navh,navg,navp,navs];

    //底部按钮
    for (int i = 0;  i < 4;  i ++) {

        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=i;
        [button setBackgroundImage:[UIImage imageNamed:_btnNormalImagName[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:_btnNormalImagName[i]] forState:UIControlStateSelected];
//        //底部按钮
        [BBManageCode creatTabbarShow:_bottomView
                               button:button
                             ImagName:@"sd.png"
                           titleLabel:sortName[i]];
        
        [button addTarget:self
                   action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            [self buttonPress:button];
        }
    }

}

#pragma mark -- 点击事件 --
-(void)buttonPress:(UIButton *)button{
    
    UIViewController * vc = self.viewcontrollers[button.tag];
    
    if ([_contentView.subviews containsObject:vc.view]) {
        [_contentView bringSubviewToFront:vc.view];
    }else{
        
        [_contentView addSubview:vc.view];
    }
    select_button = button;
    
    for (int i = 0; i < self.viewcontrollers.count; i ++) {
        
        UILabel * label = (UILabel *)[_bottomView viewWithTag:i+1];
        if (button.tag == i) {
            label.textColor = [UIColor redColor];
        }else{
            label.textColor = [UIColor whiteColor];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
