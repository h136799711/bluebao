//
//  PersonCenterVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonCenterVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UILabel  *heightLabel;
@property (nonatomic,strong) UILabel  *weightLabel;
@property (nonatomic,strong) UILabel  *BMiLabel;
@property (nonatomic,strong) UIImageView  * headImageView;
@property (nonatomic,strong) UILabel      * userIDLabel;
@property (nonatomic,strong) UILabel       *userNameLabel;
@end
