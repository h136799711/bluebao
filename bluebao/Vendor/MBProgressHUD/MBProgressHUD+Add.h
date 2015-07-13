//
//  MBProgressHUD+Add.h
//  
//
//  Created by ywang on 15/4/16.
//  Copyright (c) 2015年 嘉诚曼联. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view autoHide:(BOOL)autoHide;
@end
