//
//  LeftMenu.h
//  蜜吧
//
//  Created by ywang on 15/4/16.
//  Copyright (c) 2015年 嘉诚曼联. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeftMenu : NSObject

@property(nonatomic, strong) NSString *title;//菜单标题
@property(assign)            UInt32 normalColor;//颜色
@property(assign)            UInt32 focusColor;//选中颜色
@property(nonatomic, strong) NSString *normalImage;//图标
@property(nonatomic, strong) NSString *focusImage;//选中的图标

@property(assign)            BOOL     isFocus;//当前选中

@end
