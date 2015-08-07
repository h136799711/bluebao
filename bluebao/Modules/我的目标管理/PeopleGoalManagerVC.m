//
//  PeopleGoalManagerVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/31.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "PeopleGoalManagerVC.h"

@interface PeopleGoalManagerVC ()

@end

@implementation PeopleGoalManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的目标管理";
    self.navigationController.navigationBarHidden = NO;
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT);
    self.goalTableView.frame = rect;
    //默认卡路里
    
    
    // Do any additional setup after loading the view.
}

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
