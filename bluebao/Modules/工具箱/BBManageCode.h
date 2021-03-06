//
//  BBManageCode.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeopleBodyParams.h"

@interface BBManageCode : NSObject

//创建目标区头
+(UIView *)creatGoalHeaderView;

//创建身高体重等
+(UILabel *)creatMessageCenterInViews:(UIView *)view  num:(int) num;

//TabbarView
+(UIView *)creatTabbarShow:(UIView * ) showView button:(UIButton *)btn ImagName:(NSString *)name titleLabel:(NSString *)title;

//个人资料
+(UIView *) createdPersonInfoShowInView:(UIView *)_headView headBtn:(UIButton *)headImageBtn signTestField:(UITextField *)personSignTextfield label:(UITextField *)label;

//创建圆角 背景
+(void)createdBackGroundView:(UIView *)bottomView indexRow:(NSInteger)row maxCount:(NSInteger) maxCount;

#pragma mark --获得插入位置--
+(NSInteger) getInsertPlaceInArray:(NSDate *) dateOne array:(NSArray *)dateArray;

// 数值排序 goal
+(NSArray *)sequenceGoalDataArray:(NSArray *)dataArray;

#pragma mark -- 蓝堡首页 --
+(NSString *) getHeaderStrRow:(NSInteger)row bicyle:(Bicyle *)_bicylelb;

#pragma mark -- 获得个人健康指标
+(NSInteger) getPersonHealthCondition:(NSInteger)row userInfo:(UserInfo *)userInfo;

#pragma mark -- 目标pickerView
+(UIView *)getGoalPickerView:(UIPickerView *)pickerView Row:(NSInteger)row Component:(NSInteger)component reusingView:(UIView *)view;


@end
