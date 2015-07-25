//
//  MainViewController.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfo.h"

@interface MainViewController : BaseViewController

@property (nonatomic,strong) UserInfo * userInfo;


+ (MainViewController*)sharedSliderController;

//close
-(void)moveLeft;
//open
-(void)moveRight;

@end
