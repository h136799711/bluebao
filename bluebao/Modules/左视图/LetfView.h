//
//  LetfView.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LetfView;


@protocol LetfViewDelegate <NSObject>

-(void)letfView:(LetfView *)letfView;

@end

@interface LetfView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) UserInfo * leftInfo;
@property (nonatomic,strong) UIButton * headBtn;
@property (nonatomic,strong) UITextField * signTextfield;

@property (nonatomic,assign)id<LetfViewDelegate>delegate;
@end
