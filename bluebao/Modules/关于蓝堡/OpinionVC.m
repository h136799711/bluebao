//
//  OpinionVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/16.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "OpinionVC.h"
#import "PlaceholderTextView.h"

@interface OpinionVC (){
    
    PlaceholderTextView   * _placeTextView;
}

@end

@implementation OpinionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initViews];
}


//初始化
-(void)_initViews{
    
    [self _initNavs];
    [self _initPlaceTextView];
}

-(void)_initPlaceTextView{
    
    _placeTextView = [[PlaceholderTextView alloc] init];
    _placeTextView.frame = CGRectMake(20, 10, SCREEN_WIDTH-20*2, 100);
    _placeTextView.backgroundColor = [UIColor whiteColor];
    _placeTextView.placeholder = @"您的意见是我们进步的筹码";
    [self.view addSubview:_placeTextView];
    
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
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.bounds = CGRectMake(0, 0, 50, 40);
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = FONT(15);
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(submitBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark --- 提交 -- 

-(void)submitBtn{
    NSLog(@"提交");
    NSLog(@"  %@",_placeTextView.text);
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
