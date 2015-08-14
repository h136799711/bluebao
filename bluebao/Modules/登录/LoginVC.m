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
#import "BoyeForgetCodeVC.h"
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

//初始化用户名密码
/*
 * 登录成功，缓存用户名，
 * 选中记住密码，下次登陆显示密码，
 */

-(void)_inits{
    
    self.pswTextfield.text = @"";
    NSString * userName = [[CacheFacade sharedCache] get:BOYE_USER_NAME];
    if (userName != nil) {
        self.accontNumTextfield.text = userName;
        
        NSString * pwd =  [[CacheFacade sharedCache] get:userName];
        if (pwd != nil){
            self.remberCodeBtn.selected = NO;
            [self rememberCodeClick:self.remberCodeBtn];
            self.pswTextfield.text = pwd;
        }
        
    }
    
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

 
    self.accontNumTextfield.clearButtonMode =  UITextFieldViewModeAlways;
    
    self.accontNumTextfield.delegate = self;
    self.pswTextfield.delegate = self;
    
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    self.label_remberCode.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    
    [self.label_remberCode addGestureRecognizer:labelTapGestureRecognizer];
    
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    
    NSLog(@"%@被点击了",label.text);
    [self rememberCodeClick:self.remberCodeBtn];
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextView Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"textFieldShouldReturn%@",textField);
    [textField resignFirstResponder];
    if ([textField isEqual:self.accontNumTextfield ]) {
        [self.pswTextfield becomeFirstResponder];
    }
    if([textField isEqual:self.pswTextfield]){
        [self.loginBtn becomeFirstResponder];
    }
    return NO;
//    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"string= %@",string);
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"text%@",text);
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - 注册  --
- (IBAction)registerButton:(UIButton *)sender {
    
    RegistVC * regist = [[RegistVC alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
    
}

#pragma mark   ---登录 -----
- (IBAction)login:(UIButton *)sender {
    
//    self.accontNumTextfield.text = @"2540927273@qq.com";
//    self.pswTextfield.text = @"123456";

    User * user = [[User alloc] init];
    user.username = self.accontNumTextfield.text;
    user.password = self.pswTextfield.text;
    
    if (![self isRightInput:user]) {
        
        return;
    }
    
//    [self jumpMainPage];
    
    if (self.remberCodeBtn.selected) {
        [[CacheFacade sharedCache] setObject:user.password forKey:user.username afterSeconds:24*3600*365];
    }
    
    [self loginRequest:user];
    
}
//用户登录
-(void)loginRequest:(User*)user{
    
    //登录请求
    [BoyeDefaultManager requestLoginUser:user complete:^(UserInfo * userInfo) {
        
        if (userInfo != nil ) {
            //  NSLog(@" \r-- %@",userInfo);
            [MainViewController sharedSliderController].userInfo = userInfo;
            //缓存用户 id
            
            [CommonCache saveUserAccountInfo:user.username key:BOYE_USER_NAME];
            if (self.remberCodeBtn.selected ) {
                NSLog(@"记住密码");
                [CommonCache saveUserAccountInfo:user.password key:BOYE_USER_PSW];
            }else{
                [CommonCache saveUserAccountInfo:nil key:BOYE_USER_PSW];
            }
            
            [self jumpMainPage];
            
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
  
//    BoyeForgetCodeVC * forgetCode = [[BoyeForgetCodeVC alloc] init];
//    [self.navigationController pushViewController:forgetCode animated:YES];
//
    
//    [SVProgressHUD showOnlyStatus:@"忘记密码" withDuration:0.5];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [SVProgressHUD dismiss];
}

#pragma mark --检查输入是否正确 --
-(BOOL)isRightInput:(User *)user{
    
    CGFloat  duration = 0.5;
    
    if ([MyTool inputIsNull: user.username]) {

        [SVProgressHUD showOnlyStatus:@"账号不能为空" withDuration:duration];

        return NO;
    }
//不检测邮箱格式    
//    if (![MyTool validateEmail:user.username]) {
//       
//        [SVProgressHUD showOnlyStatus:@"邮箱格式不正确" withDuration:duration];
//
//        return NO;
//    }
    
    if (user.username.length >=18) {
        [SVProgressHUD showOnlyStatus:@"用户名长度太长" withDuration:duration];

        return NO;
    }
    
    
    if ([MyTool inputIsNull:user.password]) {
        [SVProgressHUD showOnlyStatus:@"密码不能为空" withDuration:duration];

        return NO;
    }
    
    if (user.password.length <6) {
        
        [SVProgressHUD showOnlyStatus:@"密码长度不合法" withDuration:duration];

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
