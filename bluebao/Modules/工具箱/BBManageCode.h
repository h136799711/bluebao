//
//  BBManageCode.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBManageCode : NSObject

//创建目标区头
+(UIView *)creatGoalHeaderView;

//创建身高体重等
+(UILabel *)creatMessageCenterInViews:(UIView *)view  num:(int) num;
@end
