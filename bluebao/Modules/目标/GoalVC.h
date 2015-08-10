//
//  GoalVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"
#import "GoalPickerView.h"
#import "WeekSegmentlView.h"
@interface GoalVC : BoyeSlideBaseVC<UITableViewDelegate,UITableViewDataSource,GoalPickerViewDelegate,WeekSegmentlViewDelegate>

@property (nonatomic,strong) NSMutableArray     *dataArray;
@property (nonatomic,strong) GoalPickerView     * goalPickerView;
@property (nonatomic,assign) CGFloat             outHeight;
@property (nonatomic,strong) UITableView         *goalTableView;
@property (nonatomic,strong) UserInfo           * useInfo;
@property (nonatomic,strong) WeekSegmentlView   *weekSegment;
@property (nonatomic,strong) UIView             *footerView;
@property (nonatomic,strong) UIView             *headerView;
@property (nonatomic,strong) NSString           *goalDateLabeltext;
@property (nonatomic,assign) BOOL               isHasData;

//BOOL                  _isHasData;
//UIView                  *_headerView;
//UIView                  *_footerView;
//NSString                *_goalDateLabeltext;

-(void)_initViews;
@end
