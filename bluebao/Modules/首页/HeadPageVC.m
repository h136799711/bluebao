//
//  HeadPageVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "HeadPageVC.h"

@interface HeadPageVC (){
    
    UITableView     * _tableView;
    NSArray         * _labelarray;
}

@end

@implementation HeadPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _labelarray = @[@"我的体重",@"速度",@"时间",@"运动消耗"];
    
    
    [self _initViews];
    
}

#pragma mark -- 初始化 --

-(void)_initViews{

    [self _initNav];
    [self _initHeadInfoTableView];
}

//
-(void)_initNav{
    
    self.title =@"跑步机";
}
#pragma mark -- 首页表 --

-(void)_initHeadInfoTableView{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];

    
}
#pragma mark --  主页表 --

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return  _labelarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString * identifier = @"headCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.text = _labelarray[indexPath.row];
    return cell;
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
