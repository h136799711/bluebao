//
//  LetfView.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "LetfView.h"
#import "LeftMenuCell.h"
#import "PersonMessageVC.h"
#import "AppDelegate.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "EquimentMessageVC.h"

@interface LetfView(){
    
    NSArray   * sortArray;
    
    
}

@end

@implementation LetfView

-(instancetype)initWithFrame:(CGRect)frame{
    
   self =  [super initWithFrame:frame];
    if (self) {
        
        [self _initViews];
        
    }
    return self;
}



-(void)_initViews
{
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.rowHeight = LEFT_MENU_HEIGHT;
        self.tableView.tableHeaderView = [self creatTableViewHeadView];
    [self addSubview:self.tableView];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
    bgImgView.image = [UIImage imageNamed:@"left_menu_bg"];
    self.tableView.backgroundView = bgImgView;
    self.tableView.backgroundColor = [UIColor clearColor];
    sortArray = @[@"我的个人资料",@"设备管理",@"我的个人资料",@"我的个人资料",@"我的个人资料",@"我的个人资料",@"注销"];
}



#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sortArray.count;
}

#pragma mark -- 左边视图 --
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"leftMenuCell";
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = sortArray[indexPath.row];
    cell.textLabel.font = FONT(12);
    return cell;
}

#pragma mark -- 选中之后--
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //注销
    
  
    if (indexPath.row == sortArray.count-1) {
      
        LoginVC * login = [LoginVC sharedSliderController];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        window.rootViewController = nav;
      
        
    } else if (indexPath.row == 1){
        EquimentMessageVC * equiment = [[EquimentMessageVC alloc] init];
        [[MainViewController sharedSliderController].navigationController pushViewController:equiment animated:YES];
    }
    
    else{
        
        PersonMessageVC * person = [[PersonMessageVC alloc] init];
        [[MainViewController sharedSliderController].navigationController pushViewController:person animated:YES];
        
    }
    
    
    
    [[MainViewController sharedSliderController] moveLeft];
    
 }

#pragma mark -- 创建去区头 --
-(UIView *)creatTableViewHeadView{
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    headView.backgroundColor = [UIColor lightGrayColor];
    
    //头像
    UIButton * headBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.bounds = CGRectMake(0, 0, 40, 40);
    headBtn.center = CGPointMake(20+headBtn.width/2.0, headView.height/2.0);
    [headView addSubview:headBtn];
    [headBtn setTitle:@"头像" forState:UIControlStateNormal];
    headBtn.backgroundColor = [UIColor redColor];
    
    
    //签名
    UILabel * label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, 100, 12);
    label.center = CGPointMake(headBtn.right+ 10+ label.width/2.0, headBtn.center.y);
    label.text = @"请编辑签名";
    [headView addSubview:label];
    label.font = [UIFont boldSystemFontOfSize:10];
    
    
    //编辑签名
    
    UITextField  * signTextfield = [[UITextField alloc] init];
    signTextfield.frame = CGRectMake(label.left, headBtn.center.y - headBtn.height/2.0 - 16, headView.width - headBtn.right - 15 , 30);
    signTextfield.text = @"张三";
    [headView addSubview:signTextfield];
    signTextfield.font = [UIFont boldSystemFontOfSize:14];;
    return headView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
