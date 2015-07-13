//
//  UIColor+color.h
//  蜜吧
//
//  Created by ywang on 15/4/16.
//  Copyright (c) 2015年 嘉诚曼联. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Color)
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;
@end
