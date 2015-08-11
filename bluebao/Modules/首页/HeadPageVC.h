//
//  HeadPageVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"
#import "DateChooseView.h"
#import "DrawProgreView.h"
#import "LBSportShareModel.h"

@interface HeadPageVC : BoyeSlideBaseVC<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,DateChooseViewDelegate>

@property (nonatomic,strong)UIView                      *headView;
@property (nonatomic,strong)NSData                      *newbbData; //新的日期
@property (nonatomic,strong) UserInfo                   * userInfo;
@property (nonatomic,strong) DateChooseView             *dateChooseView;
@property (nonatomic,strong) DrawProgreView             * drawProgreView;

@end
