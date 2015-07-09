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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    MainViewController * main = [MainViewController sharedSliderController];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:main];
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = nav;
        NSLog(@" login %p",self);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
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
