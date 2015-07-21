//
//  WebViewController.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/16.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initNavs];
    
    UIWebView  * web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_HEIGHT - NAV_HEIGHT)];
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mianyifan.jd.com/"]];
//    NSURLConnection * control = [NSURLConnection connectionWithRequest:request delegate:self];
// 
    
    
    
    [self.view addSubview:web];
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://mianyifan.jd.com/"];
    
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mianyifan.jd.com/"]];
}



#pragma mark -- 导航条 返回 --

-(void)_initNavs{
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.bounds = CGRectMake(0, 0, 12, 22.5);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1;
    UIBarButtonItem* letfItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = letfItem;
}



#pragma mark --返回 --
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
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
