//
//  SettingVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView_set;
@end
