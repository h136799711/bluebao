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
    [self.remberCodeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    //登录注册
    self.loginBtn.backgroundColor = [MyTool getColor:@"#1fcdff"];
    self.registerBtn.backgroundColor = [MyTool getColor:@"#ff8957"];
    [MyTool cutViewConner:self.loginBtn radius:5];
    [MyTool cutViewConner:self.registerBtn radius:5];
    //记住密码
    self.remberCodeBtn.backgroundColor = [UIColor clearColor];
    self.remberCodeBtn.imageView.backgroundColor = [UIColor clearColor];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButton:(UIButton *)sender {
    
    RegistVC * regist = [[RegistVC alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
    
    
    }

//登陆
- (IBAction)login:(UIButton *)sender {
    
    
    User * user = [[User alloc] init];
    user.userName = self.accontNumTextfield.text;
    user.userPsw = self.pswTextfield.text;
    user.userName = @"1";
    user.userPsw = @"1";
    
    if ([MyTool inputIsNull: user.userName]) {
        ALERTVIEW(@"账号不能为空")
        return;
    }
    if ([MyTool inputIsNull:user.userPsw]) {
        ALERTVIEW(@"密码不能为空")
        return;
    }

//    //保存用户名何密码,保存Token
//    [USER_DEFAULT setObject:user.userName forKey:ACCOUNTNum];
//    [USER_DEFAULT setObject:user.userPsw forKey:ACCOUNTPSW];
    
    
        #pragma mark - 跳转 --
    
    [BoyeDefaultManager requestLoginUser:user complete:^(BOOL succed) {
        
        if (succed) {
            [self jumpMainPage];
            
        }else{
            ALERTVIEW(@"登陆失败");
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

//初始化
-(void)_inits{
    self.accontNumTextfield.text = @"";
    self.pswTextfield.text = @"";
    self.remberCodeBtn.selected = NO;
    [self rememberCodeClick:self.remberCodeBtn];
    
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
