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
    
    
    [ButtonFactory decorateButton:self.registBtn forType:BOYE_BTN_SUCCESS];
    [MyTool cutViewConner:self.agreeBtn radius:0];
    
    //同意按钮
    [MyTool setViewBoard:self.agreeBtn];
//    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.agreeBtn setTitle:@"√" forState:UIControlStateSelected];
    [self.agreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//快速注册
- (IBAction)registQuestBtn:(UIButton *)sender {

    User * user = [[User alloc] init];
    user.userName = self.textfield_LeterBox.text;
    user.userPsw = self.textfield_newpsw.text;
    user.userConpsw = self.textfield_confirmpsw.text;
    
    user.userName = @"2540927373@qq.com";
    user.userPsw = @"123456";
    user.userConpsw =user.userPsw;
    
    //邮箱非空
    if ([MyTool inputIsNull:user.userName]) {
        ALERTVIEW(@"邮箱不能为空")
        return;
    }
    
    if (![MyTool validateEmail:user.userName]) {
        
        ALERTVIEW(@"请输入正确的邮箱")
        return;
    }

    if ([MyTool inputIsNull:user.userPsw]) {
        ALERTVIEW(@"密码不能为空")
        return;
    }
    if ([MyTool inputIsNull:user.userConpsw]) {
        ALERTVIEW(@"确认密码不能为空")
        return;
    }
    //两个密码是否相等
    if (![MyTool isEqualToString:user.userPsw string:user.userConpsw]) {
        ALERTVIEW(@"两次密码输入不正确")
        return;
    }
    
    //没有阅读
    if (self.agreeBtn.selected ==NO ) {
        ALERTVIEW(@"请阅读用户须知")
        return;
    }
    
    
    /*
     *注册成功会返回一个token
     **/
    
    //获得口令
    NSString * access_token = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
    if (!access_token) {
        
        NSLog(@" token不可用，需要再次请求! ");
        [BoyeDefaultManager requtstAccessTokenComplete:^(BOOL succed) {
            
            //获得口令
            if (!succed) {
                
                ALERTVIEW(@"口令获取失败");
                return ;
            }
        }];
        
    }
    
    //注册请求
    [BoyeDefaultManager requestRegisterUser:user complete:^(BOOL succed) {
        
        if (succed) {
            
            [USER_DEFAULT setObject:user.userName forKey:BOYE_USER_NAME];
            
            
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
//返回
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
