//
//  GoalVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "GoalVC.h"
#import "GoalCell.h"
#import "GoalData.h"

static  NSString * const goalArrNameString = @"boyeGoalArray";

@interface GoalVC (){
    
    UITableView         * _goalTableView;
//    int                  _goalCount;
    BOOL                  _isHasData;
    UIView                  *_headerView;
    UIView                  *_footerView;
    NSString                *_goalDateLabeltext;
}

@end

@implementation GoalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"目标设定";
    
//    _goalCount = 0;
    _isHasData = NO;
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    _goalDateLabeltext = [[NSString alloc] init];
    
    [self _initViews];
   }

/*
 *初始化
 **/
-(void)_initViews{

    [self isHasDataAdjust];  //判断是否包含数据
    [self _initGoalTableView]; //创建表
    [self _initPickerView];  //修改 数据
    [self _initNotificationCenter];
    [self _initGest];

}

#pragma mark -- 目标设定 --

-(void)_initGoalTableView{
    
    if (_goalTableView == nil) {
        
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT);
        _goalTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
        _goalTableView.rowHeight = 44;
        _goalTableView.delegate = self;
        _goalTableView.dataSource = self;
        _goalTableView.tableHeaderView = [self creatHeaderView];
        _goalTableView.tableFooterView = [self creatFooterView];
        _goalTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_goalTableView];
    }
}


#pragma mark -- TableView ----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_isHasData == NO) {
        return 1;
    }else{
     
        return self.dataArray.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isHasData == YES) {
        static  NSString * identifier = @"goalCell";
        GoalCell * cell = (GoalCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            
            cell = [[GoalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
          
            [cell.alterBtn addTarget:self action:@selector(alteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
          
            [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        GoalData * goaldate = [self.dataArray objectAtIndex:indexPath.row];
        
        cell.timeLabel.text = goaldate.timestr;
        cell.goalLael.text  = [NSString stringWithFormat:@"%ld卡",goaldate.goalNumber];
        cell.operateLael.text = @"50%";
     
        cell.alterBtn.tag = indexPath.row;
        cell.deleteBtn.tag = indexPath.row ;
        
        
        return cell;
        
    }else{
    
        static NSString *  nodataString = @"noDataCell";
        
        UITableViewCell *datacell = [tableView dequeueReusableCellWithIdentifier:nodataString];
        if (datacell == nil) {
            
            datacell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nodataString];
            datacell.selectionStyle = UITableViewCellSelectionStyleNone;
            datacell.textLabel.textAlignment = NSTextAlignmentCenter;
            datacell.textLabel.text = @"没有数据，请添加数据";
            datacell.backgroundColor = [UIColor clearColor];
            //线
            [MyTool createLineInView:datacell.contentView
                                fram:CGRectMake(0, datacell.contentView.height, tableView.width, 1)];
        }
        return datacell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

#pragma mark -- 点击修改 --

-(void) alteBtnClick:(UIButton *)alterBtn{
    
    NSLog(@"修改");

    self.goalPickerView.tag = alterBtn.tag;
    [self.goalPickerView open];
    
    
}
#pragma mark  --delete  --
-(void) deleteBtnClick:(UIButton *)deleteBtn{
    
    NSLog(@"删除");
    
    self.goalPickerView.tag = deleteBtn.tag;
    
    //删除数据源
    [self.dataArray removeObjectAtIndex:deleteBtn.tag];
    
    //然后刷新tableView(动态删除某些行)
    
    [_goalTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:deleteBtn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //是否含有数据
    [self isHasDataAdjust];
    //刷新表
    [_goalTableView reloadData];
    
    [self.goalPickerView close];
}

#pragma mark -- 创建日期标签 ---
-(UIView *)creatHeaderView{
    
    if (_headerView == nil) {
       _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor clearColor];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        
        UILabel * headerLabel = [[UILabel alloc] init];
        headerLabel.frame = _headerView.frame;
        headerLabel.tag = 10;
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.font = FONT(17);
        [_headerView addSubview:headerLabel];
    }
    
    UILabel * headl = (UILabel *)[_headerView viewWithTag:10];
    headl.text = [MyTool getCurrentDataFormat:@"yy-M-dd"];
    _goalDateLabeltext = headl.text;
    return _headerView;
}

#pragma mark --- 创建底部按钮 --
-(UIView * )creatFooterView{
    
    if (_footerView == nil) {
    
        _footerView= [[UIView alloc] init];
        _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        //加号
        UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.bounds = CGRectMake(0, 0, 30, 30);
        addBtn.center = CGPointMake(_footerView.width/2.0, _footerView.height/2.0);
        [addBtn setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector (addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:addBtn];
        
    }
    
    return _footerView;
}

#pragma mark -- add增加 --
-(void)addBtnClick:(UIButton *)button{
    
    self.goalPickerView.tag = -1;
    [self.goalPickerView open];

}

//区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

 return   [BBManageCode creatGoalHeaderView];
   
}

#pragma mark - 是否含有数据
-(void)isHasDataAdjust{
    
    if (self.dataArray.count == 0) {
        _isHasData = NO ;
    }else{
        _isHasData = YES;
    }
}


#pragma mark -- 创建PIcker --

-(void)_initPickerView{
    
    if (self.goalPickerView == nil) {
        self.goalPickerView = [[GoalPickerView alloc] initWithPicker];
        self.goalPickerView.delegate = self;
        self.goalPickerView.dataUnit = @"卡";
        [self.view addSubview:self.goalPickerView];
    }
}


#pragma mark---PickerDelegate  --

-(void)goalPickerView:(GoalPickerView *)picker dateString:(NSString *)time goalNumber:(NSInteger)goalNumber{
    
    GoalData * goal = [[GoalData alloc] init];
    goal.timestr = time;
    goal.goalNumber = goalNumber;
    NSString * datestr = [self getFullDateString:goal.timestr];
    goal.dateTime = [MyTool changeStringToDate:datestr formatter:@"yy-M-dd-HH:mm"];
    
    
    
    
//    NSLog(@"////////////****///dataTime: %@",goal.dateTime);
    
    #pragma mark -- 点击添加按钮，相同日期不可添加，不同日期要排序
    if (self.goalPickerView.tag == -1) {
        
        //判断是否存在相同日期
        if (self.dataArray.count != 0) {
            //是否存在相同日期
            [MyTool isSameGoalData:goal array:self.dataArray complete:^(BOOL sameGoal) {
                if (sameGoal) {
                    [SVProgressHUD showOnlyStatus:@"存在相同时间目标" withDuration:0.5];
                    return;
                }
            }];
        }
        //添加元素 然后排序
         [self.dataArray addObject:goal];
        
        
    #pragma mark -- 点击修改按钮，替换对应目标数据
    }else{
        [self.dataArray replaceObjectAtIndex:self.goalPickerView.tag withObject:goal];
    }
    
    [self isHasDataAdjust];
    [_goalTableView reloadData];
    
//    NSLog(@"  ----- %f ---",_goalTableView.rowHeight);
//    
//    if (self.dataArray) {
//        [BoyeFileMagager saveGoalData:self.dataArray plistName: goalArrNameString];
//       
//        [BoyeFileMagager readGoalDataName:goalArrNameString complete:^(NSArray *goalArr) {
//            
//        }];
//    }
    
    
    
}


-(void)goalTimeNot{
    

    
    
}

#pragma mark -- 监听picker -- 动画
-(void)_initNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveChangeColorNotification:) name:@"Goalpicker" object:nil];
    
}

#pragma mark -- 接受通知  ---

-(void)receiveChangeColorNotification:(NSNotification *)notification{
    
    CGFloat  height = _headerView.height +44 + 15 + _footerView.height + _goalTableView.rowHeight * self.dataArray.count;
    
    CGFloat pickerTop =  [[notification.userInfo objectForKey:@"goalViewHeightInfo"] floatValue];
    CGFloat  outheight = -pickerTop + height;
    
    //picker 未过界
    if (outheight <= 0) {
        [_goalTableView setContentOffset:CGPointMake(0,0 ) animated:YES];
   
    }else{
        
        //picker过界了 outheight 为负值（） ,,self.outHeight 初始值为0 （始终》=0）；
               //打开状态下
        if (self.goalPickerView.isOpen) {

            [_goalTableView setContentOffset:CGPointMake(0,outheight ) animated:YES];
        }else{
            //关闭状态
            
            if (height < _goalTableView.height) {

                    [_goalTableView setContentOffset:CGPointMake(0,0) animated:YES];
            }else{
                
                [_goalTableView setContentOffset:CGPointMake(0,height - _goalTableView.height) animated:YES];
            }
            
        }
  
    }
 
}



#pragma mark -- 目标界面点击手势 关闭picker--
-(void)_initGest{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.view addGestureRecognizer:tap];

}
-(void)tapGesture:(UITapGestureRecognizer *)tap{
    //
    [self.goalPickerView close];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获得完整日期字符串
-(NSString *)getFullDateString:(NSString *)dmstr{
    
    NSString * datestr = [NSString stringWithFormat:@"%@-%@",_goalDateLabeltext,dmstr];
//    NSLog(@"\r ****** datestr:  %@",datestr);
    return datestr;
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
