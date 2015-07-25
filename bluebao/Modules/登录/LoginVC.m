//
//  LoginVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/6.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "LoginVC.h"
#import "RegistVC.h"
#import "MainViewController.h"
#import "UserInfo.h"
@interface LoginVC ()

@end

@implementation LoginVC
+ (LoginVC*)sharedSliderController
{
    static LoginVC *loginVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginVC = [[self alloc] init];
        
    });
    
    return loginVC;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
    [self _inits];
}

//初始化
-(void)_inits{
    
    NSString * userName = [USER_DEFAULT objectForKey:BOYE_USER_NAME];
    if (userName != nil) {
        self.accontNumTextfield.text = userName;
    }
    self.pswTextfield.text = @"";
    self.remberCodeBtn.selected = YES;
    [self rememberCodeClick:self.remberCodeBtn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self _initViews];
}



#pragma mark -- 初始化 ---

-(void)_initViews{

    //设置账号边框
    [MyTool setViewBoard:self.accontNumView];
    [MyTool cutViewConner:self.accontNumView radius:5];
    //设置密码
    [MyTool setViewBoard:self.pswView];
    [MyTool cutViewConner:self.pswView radius:5];
   
    //记住密码
    [MyTool setViewBoard:self.remberCodeBtn];
    [MyTool cutViewConner:self.remberCodeBtn radius:0];
//    [self.remberCodeBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateSelected];
    [self.remberCodeBtn setTitle:@"√" forState:UIControlStateSelected];
    [self.remberCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    //登录注册
    [ButtonFactory decorateButton:self.loginBtn forType:BOYE_BTN_SECONDARY];
    //注册
    [ButtonFactory decorateButton:self.registerBtn forType:BOYE_BTN_WARNING];

    
    [MyTool cutViewConner:self.loginBtn radius:5];
    [MyTool cutViewConner:self.registerBtn radius:5];
 
    self.accontNumTextfield.clearButtonMode =  UITextFieldViewModeAlways;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 注册  --
- (IBAction)registerButton:(UIButton *)sender {
    
    RegistVC * regist = [[RegistVC alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
    
    
    }

#pragma mark   ---登陆 -----
- (IBAction)login:(UIButton *)sender {
    
    
    User * user = [[User alloc] init];
    user.username = self.accontNumTextfield.text;
    user.password = self.pswTextfield.text;
    
    user.username = @"2540927273@qq.com";
    user.password = @"123456";
    
    
    if (![self isRightInput:user]) {
        
        return;
    }

    
    //token是否有效
    BOOL  isEffective = [BoyeDefaultManager isTokenEffective];
    if (!isEffective) {
       
        [BoyeDefaultManager requtstAccessTokenComplete:^(BOOL succed) {
            if (!succed) {
                
                return ;
            }else{
                
                [self requestLogin:user];
            }
            NSLog(@"token请求成功");
        }];
    }else{
        
        NSLog(@" token 有效");
        [self requestLogin:user];
    }
    
}

//登陆请求
-(void)requestLogin:(User *)user{
    
    
    [BoyeDefaultManager requestLoginUser:user complete:^(UserInfo * userInfo) {
        
        if (userInfo != nil ) {
            
//            NSLog(@" \r-- %@",userInfo);
            [self jumpMainPage];
            
            [MainViewController sharedSliderController].userInfo = userInfo;
        }
    }];
    

}


#pragma mark -- 调到主界面 -

-(void)jumpMainPage{
    
    //跳到主界面
    MainViewController * main = [MainViewController sharedSliderController];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:main];
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = nav;
}

#pragma mark --记住密码 --
- (IBAction)rememberCodeClick:(UIButton *)sender {

    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.label_remberCode.textColor = [MyTool getColor:@"#2bd8f6"];
    }else{
        self.label_remberCode.textColor = [UIColor lightGrayColor];
    }
}

#pragma mark -- 忘记密码
- (IBAction)forgetCodeBtnClick:(UIButton *)sender {
    
}


#pragma mark --检查输入是否正确 --
-(BOOL)isRightInput:(User *)user{
    
    
    if ([MyTool inputIsNull: user.username]) {
        ALERTVIEW(@"账号不能为空")
        return NO;
    }
    
    if (![MyTool validateEmail:user.username]) {
        
        ALERTVIEW(@"请输入正确的邮箱")
        return NO;
    }
    
    if (user.username.length >=18) {
        ALERTVIEW(@"用户名长度太长");
        return NO;
    }
    
    
    if ([MyTool inputIsNull:user.password]) {
        ALERTVIEW(@"密码不能为空")
        return NO;
    }
    
    if (user.password.length <6) {
        
        ALERTVIEW(@"密码长度不合法");
        return NO;
    }
    
    
    
    return YES;
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
