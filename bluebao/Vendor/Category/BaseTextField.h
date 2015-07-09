//
//  BaseTextField.h
//  蜜吧
//
//  Created by ywang on 15/4/24.
//  Copyright (c) 2015年 嘉诚曼联. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    TextFieldPadding_LEFT,
    TextFieldPadding_RIGHT,
    TextFieldPadding_ALL,
} TextFieldPadding;


@interface BaseTextField : UITextField

- (void)setPadding:(TextFieldPadding)_padding bounds:(CGRect)_paddingBounds;

- (void)setLeftBounds:(CGRect)_leftBounds rightBounds:(CGRect)_rightBounds;


@end
