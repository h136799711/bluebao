//
//  MainViewController.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController


+ (MainViewController*)sharedSliderController;

//向左移动
-(void)moveLeft;
-(void)moveRight;

@end
