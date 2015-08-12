//
//  MainViewController.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfo.h"
#import "LetfView.h"

@interface MainViewController : BaseViewController<LetfViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UserInfo           * userInfo;
@property (nonatomic,assign) BOOL               isOpen;
@property (nonatomic,strong)   LetfView          *leftView;

/*
 * VC注销
 *第一次进入首页，需要请求数据，其他情况，不请求；如果注销了，再次进入仍需要请求；
 **/
@property (nonatomic,assign) BOOL               isVCCancel;

/**
 * 包含视图
 */

@property (nonatomic,strong) UIView          * contentView;
/**
 *底部视图
 */
@property (nonatomic,strong) UIView          * bottomView;
+ (MainViewController*)sharedSliderController;


//close
-(void)moveLeft;
//open
-(void)moveRight;

@end
