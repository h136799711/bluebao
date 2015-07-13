//
//  PersonCenterVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "PersonCenterVC.h"
#import "MessageCell.h"
@interface PersonCenterVC (){
    
    UITableView             *_tableView;
    
    UIView * _views ;
    
    NSArray   * _sortArray; //分类
    NSArray   * _unitArray;// 单位
    UIView * _headView;
    
}

@end

@implementation PersonCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"数据中心";
    
    [self _initViews];
    
}
//初始化
-(void)_initViews{
    
    _sortArray = @[@[@"总里程",@"总时间",@"总消耗热量"],@[@"最长距离",@"最长时间",@"最多消耗热量"]];
    _unitArray = @[@"公里",@"小时",@"千卡"];
    [self _initTableView];
    
}

-(void)_initTableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT -TABBAR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self getHeaderView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [MyTool testViews:_tableView];
        [self.view addSubview:_tableView];
    }
    
}

#pragma mark -- UITableViewdelegate --

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static    NSString * identifier = @"cell";
   
    MessageCell * cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //分类
    cell.label_sort.text = _sortArray[indexPath.section][indexPath.row];
    cell.label_value.text = [MyTool stringWithNumFormat:_unitArray[indexPath.row] number:0];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
       return  [self createhwbInfo];
    }else{
        return [self creatpersonBestLabel:tableView];
    }
    
}

#pragma mark -- 身高，体重 MBI  区头
-(UIView *)createhwbInfo{
    
    if (_views == nil) {
        _views = [[UIView alloc] init];
        _views.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
        
        for (int i = 0; i < 3; i++) {
            switch (i) {
                case 0:
                    self.heightLabel =  [BBManageCode creatMessageCenterInViews:_views num:i];;
                    break;
                    
                case 1:
                    self.weightLabel =  [BBManageCode creatMessageCenterInViews:_views num:i];;
                    break;
                    
                case 2:
                    self.BMiLabel =  [BBManageCode creatMessageCenterInViews:_views num:i];;
                    break;
                    
                default:
                    break;
            }
        }
        
        //线
        [MyTool createLineInView:_views fram:CGRectMake(26, 0, SCREEN_WIDTH-26*2, 1)];
        [MyTool createLineInView:_views fram:CGRectMake(26, _views.height -1, SCREEN_WIDTH-26*2, 1)];

    }
   self.heightLabel.text = @"165";
    self.weightLabel.text = @"60";
    self.BMiLabel.text = @"30";
   
    return  _views;
}

#pragma mark-- pesonBest --
-(UIView * )creatpersonBestLabel:(UITableView *)tableView {
    
    UIView  * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, tableView.width, 40);
    
    UILabel * personBest = [[UILabel alloc] init];
    personBest.frame = view.frame;
    personBest.textAlignment = NSTextAlignmentCenter;
    personBest.text = @"个人最好成绩";
    personBest.font = FONT(17);
    [view addSubview:personBest];
    //线
    [MyTool createLineInView:view fram:CGRectMake(26, 0, view.width-26*2, 1)];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark -- 表头 --
-(UIView *)getHeaderView{
    
    if (_headImageView == nil) {
        _headView = [[UIView alloc] init];
        _headImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
        //头像
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, 80, 80);
        imageView.center = CGPointMake(40+imageView.width/2.0, _headImageView.height/2.0);
        [MyTool cutViewConner:imageView radius:imageView.width/2.0];
        imageView.backgroundColor = [UIColor redColor];
        
        [_headImageView addSubview:imageView];
        
        //姓名
        UILabel  * label_name = [[UILabel alloc] init];
        label_name.bounds = CGRectMake(0, 0, 80, 30);
        label_name.center = CGPointMake(imageView.right + 30+ label_name.width /2.0, imageView.center.y-label_name.height/2.0);
        label_name.text = @"用户名字";
        label_name.font = FONT(15);
        [_headImageView addSubview:label_name];
        
        //ID
        
        UILabel  * label_ID = [[UILabel alloc] init];
        label_ID.bounds = label_name.bounds;
        label_ID.center = CGPointMake(label_name.center.x, imageView.center.y+label_ID.height/2.0);
        label_ID.text = @"ID:123456";
        label_ID.font = FONT(15);
        label_ID.textColor = [UIColor lightGrayColor];
        [_headImageView addSubview:label_ID];
        
     

    }
    
    return _headImageView;
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
