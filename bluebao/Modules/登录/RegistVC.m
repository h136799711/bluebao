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
    self.backItem.tintColor = [UIColor blackColor];
//    [self _initNavs];

    [self _initViews];
    
}

/*
 *初始化
 */

-(void)_initViews{
    
    
    [ButtonFactory decorateButton:self.registBtn forType:BOYE_BTN_SUCCESS];
    
    //同意按钮
    [MyTool setViewBoard:self.agreeBtn];
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 返回上一层 --
- (IBAction)backItem:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


//快速注册
- (IBAction)registQuestBtn:(UIButton *)sender {

    //邮箱非空
    if ([MyTool inputIsNull:self.textfield_LeterBox.text]) {
        ALERTVIEW(@"邮箱不能为空")
        return;
    }
    if ([MyTool inputIsNull:self.textfield_newpsw.text]) {
        ALERTVIEW(@"密码不能为空")
        return;
    }
    if ([MyTool inputIsNull:self.textfield_confirmpsw.text]) {
        ALERTVIEW(@"确认密码不能为空")
        return;
    }
    //两个密码是否相等
    if (![MyTool isEqualToString:self.textfield_newpsw.text string:self.textfield_confirmpsw.text]) {
        ALERTVIEW(@"两次密码输入不正确")
        return;
    }
    
    //没有阅读
    if (self.agreeBtn.selected ==NO ) {
        return;
    }
    
    
    /*
     *注册成功会返回一个token
     **/
    
//    [USER_DEFAULT setObject:nil forKey:TOKENKEY];
    
    [self.navigationController popViewControllerAnimated:YES];
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
//-(void)_initNavs{
//    
//     UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.bounds = CGRectMake(0, 0, 12, 22.5);
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.tag = 1;
//    UIBarButtonItem* letfItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = letfItem;
//    
//}
////返回
//-(void)backClick{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}
@end
