//
//  HeadPageVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"

@interface HeadPageVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UIView     *headView;
@end
