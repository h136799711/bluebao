//
//  GoalVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"
#import "GoalPickerView.h"

@interface GoalVC : BoyeSlideBaseVC<UITableViewDelegate,UITableViewDataSource,GoalPickerViewDelegate>

@property (nonatomic,strong) NSMutableArray     *dataArray;
@property (nonatomic,strong) GoalPickerView     * goalPickerView;
@property (nonatomic,assign) CGFloat             outHeight;
@property (nonatomic,strong) UITableView         *goalTableView;
@end
