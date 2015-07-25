//
//  HeadPageVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"
#import "DateChooseView.h"
@interface HeadPageVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,DateChooseViewDelegate>

@property (nonatomic,strong)UIView     *headView;
@property (nonatomic,strong)NSData      *newbbData; //新的日期
@property (nonatomic,strong) UserInfo * userInfo;
@end
