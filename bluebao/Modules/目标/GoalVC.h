//
//  GoalVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"

@interface GoalVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray     *dataArray;
@end
