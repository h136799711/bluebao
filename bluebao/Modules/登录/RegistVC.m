//
//  RegistVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC (){
    
}

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.backItem.tintColor = [UIColor blackColor];
    [self _initNavs];

    [self _initViews];
    
}

/*
 *初始化
 */

-(void)_initViews{
    
    self.agreeBtn.selected = YES;
    [ButtonFactory decorateButton:self.registBtn forType:BOYE_BTN_SUCCESS];
    [MyTool cutViewConner:self.agreeBtn radius:0];
    
    //同意按钮
    [MyTool setViewBoard:self.agreeBtn];
//    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.agreeBtn setTitle:@"√" forState:UIControlStateSelected];
    [self.agreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.textfield_LeterBox.clearButtonMode = UITextFieldViewModeAlways;
    
//    self.textfield_LeterBox.text = @"2540927273@qq.com";
//    self.textfield_newpsw.text   = @"123456";
    self.textfield_confirmpsw.text =  self.textfield_newpsw.text;
    self.textfield_confirmpsw.delegate = self;
    self.textfield_LeterBox.delegate = self;
    self.textfield_newpsw.delegate = self;
    
}

#pragma mark - UITextView Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"textFieldShouldReturn%@",textField);
    [textField resignFirstResponder];
    if ([textField isEqual:self.textfield_LeterBox ]) {
        [self.textfield_newpsw becomeFirstResponder];
    }
    if ([textField isEqual:self.textfield_newpsw ]) {
        [self.textfield_confirmpsw becomeFirstResponder];
    }
    if([textField isEqual:self.textfield_confirmpsw]){
        [self.registBtn becomeFirstResponder];
    }
    return NO;
    //    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//快速注册
- (IBAction)registQuestBtn:(UIButton *)sender {

    
    
    User * user = [[User alloc] init];
    user.username = self.textfield_LeterBox.text;
    user.password = self.textfield_newpsw.text;
    user.userConpsw = self.textfield_confirmpsw.text;
 
    //检查输入是否正确
    if (![self isRightInput:user]) {

        return;
    }
    
    
    //注册请求
    [BoyeDefaultManager requestRegisterUser:user complete:^(BOOL succed) {
        
        if (succed) {
            
            [USER_DEFAULT setObject:user.username forKey:BOYE_USER_NAME];
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }];
    

    
}


#pragma mark -- 同意签订 --
- (IBAction)agree:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.agreeLabel.textColor = [UIColor blueColor];
    }else{
        self.agreeLabel.textColor = [UIColor lightGrayColor];
    }
}

//#pragma mark  --返回 --
-(void)_initNavs{
    
    //返回按钮
     UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.bounds = CGRectMake(0, 0, 12, 22.5);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1;
    UIBarButtonItem* letfItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navItem.leftBarButtonItem = letfItem;


}

-(BOOL)isRightInput:(User *)user{

    CGFloat duration = 0.5;
    

    //邮箱非空
    if ([MyTool inputIsNull:user.username]) {
        [SVProgressHUD showOnlyStatus:@"邮箱不能为空" withDuration:duration];

        return NO;
    }
    
    if (![MyTool validateEmail:user.username]) {
        [SVProgressHUD showOnlyStatus:@"请输入正确的邮箱" withDuration:duration];
        return NO;
    }
    
    if (user.username.length >=18) {
        [SVProgressHUD showOnlyStatus:@"用户名长度太长" withDuration:duration];

        return NO;
    }
    
    
    if ([MyTool inputIsNull:user.password]) {
        [SVProgressHUD showOnlyStatus:@"密码不能为空" withDuration:duration];
        return NO;
    }
    
    if (user.password.length <6) {
        [SVProgressHUD showOnlyStatus:@"密码长度不能小于6位" withDuration:duration];
        return NO;
    }
    
    
    if ([MyTool inputIsNull:user.userConpsw]) {
        [SVProgressHUD showOnlyStatus:@"确认密码不能为空" withDuration:duration];
        return NO;
    }
    
    
    
    //两个密码是否相等
    if (![MyTool isEqualToString:user.password string:user.userConpsw]) {
        [SVProgressHUD showOnlyStatus:@"两次密码不一致" withDuration:duration];
        return NO;
    }
    
    //没有阅读
    if (self.agreeBtn.selected ==NO ) {
        [SVProgressHUD showOnlyStatus:@"请阅读用户须知" withDuration:duration];

        return NO;
    }

    return YES;
}

//返回
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
