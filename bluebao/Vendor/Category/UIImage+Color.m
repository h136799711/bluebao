//
//  UIImage+Color.m
//  蜜吧
//
//  Created by ywang on 15/4/22.
//  Copyright (c) 2015年 嘉诚曼联. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)


+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
