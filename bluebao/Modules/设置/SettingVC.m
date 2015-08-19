//
//  SettingVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC (){
    
    NSArray                 *_setArray;
    
    NSInteger               _currSelectedRow; //选中的行 默认 0 ；
    NSInteger               _lastSelectedRow;// 上一次选中
}

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.navigationController.navigationBarHidden = NO;
    
    _currSelectedRow = 0;
    _lastSelectedRow = _currSelectedRow;
    _setArray = @[@"震动",@"声音"];

    [self _initViews];
}



//初始化
-(void)_initViews{
    
    [self _initTableView];
}

-(void)_initTableView{
    
    self.tableView_set = [[UITableView alloc] initWithFrame:CGRectMake(0,20, SCREEN_WIDTH,SCREEN_HEIGHT - NAV_HEIGHT - STATE_CHANGE - 20) style:UITableViewStyleGrouped];
    self.tableView_set.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView_set.delegate = self;
    self.tableView_set.dataSource = self;
    self.tableView_set.backgroundColor = [UIColor clearColor];
    self.tableView_set.bounces = NO;
    [self.view addSubview:self.tableView_set];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"闹铃提醒类型";
    }
    return @"闹铃提醒类型";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.selectionStyle = NO;
        
        //线
        UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.contentView.height -1,tableView.width, 1)];
        lineLabel.tag = 1008;
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lineLabel];
    }
    
//    //隐藏横线
//    UILabel * line = (UILabel *) [cell.contentView viewWithTag:1008];
//    line.alpha = indexPath.row == _setArray.count-1?0:0.5;
//    

    cell.textLabel.text = _setArray[indexPath.row];
    
    
    //选中后样式
//    if (indexPath.row == _setArray.count -1) {
//        
//        cell.detailTextLabel.text =  @"v1.1";
//        cell.accessoryType = UITableViewCellAccessoryNone;
//
//    }else{
    
        NSInteger   row = 0;
//        if (_currSelectedRow != _setArray.count -1) {
            row = _currSelectedRow;
//        }else{
//            row = _lastSelectedRow;
//        }
        //震动or声音
        cell.accessoryType =  row == indexPath.row
        ? UITableViewCellAccessoryCheckmark
        :UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = @"";
        
//    }
    return cell;
}

//切换设置
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (_currSelectedRow != _setArray.count -1) {
//        _lastSelectedRow = _currSelectedRow;
//    }
    //不是最后一个
    _currSelectedRow = indexPath.row;
    if (_currSelectedRow == 0) {
        DLog(@"震动按了!");
    }else{
        DLog(@"声音按了!");
    }
    [tableView reloadData];

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
