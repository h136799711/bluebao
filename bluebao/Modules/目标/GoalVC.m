//
//  GoalVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "GoalVC.h"
#import "GoalCell.h"
@interface GoalVC (){
    
    UITableView         * _tableView;
    int                  _goalCount;
}

@end

@implementation GoalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"目标设定";
    
    [self _initViews];
}

/*
 *初始化
 **/
-(void)_initViews{
   
    _goalCount = 1;

    
    [self _initGoalTableView];
    
}

#pragma mark -- 目标设定 --

-(void)_initGoalTableView{
    
    if (_tableView == nil) {
        
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self creatHeaderView];
        _tableView.tableFooterView = [self creatFooterView];
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
}


#pragma mark -- TableView ----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _goalCount;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString * identifier = @"goalCell";
    GoalCell * cell = (GoalCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[GoalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell.alterBtn addTarget:self action:@selector(alterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.alterBtn.tag = indexPath.row;
    cell.deleteBtn.tag = indexPath.row ;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

#pragma mark -- 点金修改 --

-(void) alterBtnClick:(UIButton *)alterBtn{
    
    NSLog(@"修改");
    [_tableView reloadData];
}
-(void) deleteBtnClick:(UIButton *)deleteBtn{
    
    NSLog(@"删除");
    _goalCount --;
    //然后刷新tableView(动态删除某些行)
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:deleteBtn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView reloadData];
}

#pragma mark -- 创建日期标签 ---
-(UIView *)creatHeaderView{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);;
    UILabel * headerLabel = [[UILabel alloc] init];
    headerLabel.frame = view.frame;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = FONT(17);
    headerLabel.text = @"15-7-8";
    [view addSubview:headerLabel];
    return view;
}

#pragma mark --- 创建底部按钮 --
-(UIView * )creatFooterView{
    
    UIView * footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    //加号
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.bounds = CGRectMake(0, 0, 30, 30);
    addBtn.center = CGPointMake(footerView.width/2.0, footerView.height/2.0);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector (addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addBtn];
    
    
    return footerView;
}

#pragma mark -- add增加 --
-(void)addBtnClick:(UIButton *)button{
    
    _goalCount ++;
    [_tableView reloadData];
}

//区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

 return   [BBManageCode creatGoalHeaderView];
   
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
