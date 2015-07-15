//
//  ButtonFactory.h
//  AFNTest
//
//  Created by hebidu on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

#ifndef  ENUM_BOYE_BUTTON_TYPE

enum BOYE_BUTTON_TYPE{
    BOYE_BTN_PRIMARY = 1,                //常用按钮主色调用到
    BOYE_BTN_SECONDARY = 1<<1, //操作成功、安全操作时用到
    BOYE_BTN_SUCCESS =  1<<2 , //操作成功、安全操作时用到
    BOYE_BTN_WARNING =  1<<3, //警告性、未达到危险级别操作时用到
    BOYE_BTN_DANGER =  1<<4, //危险操作时用到
    BOYE_BTN_DEFAULT = 1<<5, //默认
    
};

typedef enum BOYE_BUTTON_TYPE   ENUM_BOYE_BUTTON_TYPE;

#endif

@interface ButtonFactory : NSObject


+(UIButton *)decorateButton:(UIButton *)btn forType:(ENUM_BOYE_BUTTON_TYPE  )type;

+(UIButton *)create:(ENUM_BOYE_BUTTON_TYPE  )type;

@end
