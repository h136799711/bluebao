//
//  BlueBaoAboutVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BlueBaoAboutVC.h"

@interface BlueBaoAboutVC ()

@end

@implementation BlueBaoAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于绿堡";
    self.navigationController.navigationBarHidden = NO;
    [self _initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化
-(void)_initViews{
    
    [self _initNavs];
    [self _initTableView];
}

-(void)_initTableView{
    
    self.tableView_lb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT -STATUS_HEIGHT)];
    self.tableView_lb.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView_lb.delegate = self;
    self.tableView_lb.dataSource = self;
    //    self.tableView.rowHeight = LEFT_MENU_HEIGHT;
    [self.view addSubview:self.tableView_lb];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    cell.textLabel.text = @"11";
    return cell;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
