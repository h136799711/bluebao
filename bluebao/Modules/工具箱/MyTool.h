//
//  MyTool.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTool : NSObject

#pragma mark --test--

+(void) testViews:(UIView * )view;
+(void) testViewsBackGroundView:(UIView*)view colorNum:(int)num;


#pragma mark  获得字符串的大小（size）
+(CGSize)getSizeString:(NSString *)info font:(float) font;

#pragma mark  动画
+(void) setViewFlipFromRightAnimation:(UIView * )view;


#pragma mark  移动 rect
+(void) setAnimationView:(UIView * )view duration:(CGFloat)duration rect:(CGRect) rect;

#pragma mark  移动 pointCenten
+(void) setAnimationCentView:(UIView * )view duration:(CGFloat)duration pointCent:(CGPoint) pointCent;
    
#pragma mark 返回图片对象
+(UIImage *) getImageOfString:(NSString *)imagString;

#pragma mark   清理特殊标签的子视图 ---
+(void)clearCellSonView:(UIView*)contentView viewTag:(NSInteger) tag;

#pragma mark 切割圆角
+(void)cutViewConner:(UIView *)view radius:(CGFloat)radius;

#pragma mark -- 设置边框--
+(void)setViewBoard:(UIView *) view;

#pragma mark -- 返回color 对象 --
+(UIColor *) getColor:(NSString *) colorString;

#pragma mark -- 输入是否为空 --
+(BOOL) inputIsNull:(NSString *) text;

#pragma mark -- 字符串相等 ---
+(BOOL)isEqualToString:(NSString *)stringOne string:(NSString *)stringTow;

#pragma mark -- 创建一条线
+(UIView *)createLineInView:(UIView *)view fram:(CGRect )rect;

#pragma mark --数量与字符串拼接--
+(NSString *) stringWithNumFormat:(NSString *)string number:(CGFloat)number;

#pragma mark -- 获得当前日期  -
+(NSString *) getCurrentDataFormat:(NSString *)formatterStr;

#pragma mark -- 获得当前日期-
+(NSDateFormatter *)getDateFormatter:(NSString *)format;

#pragma mark -- 转化为data ---
+(NSDate *) changeStringToDate:(NSString *)datestr formatter:(NSString *)format;

#pragma mark -- 获得BMI --
+(NSString *) getBMIStringWeight:(CGFloat)weight height:(CGFloat)height;

#pragma markk -- 获得BMI值 --
+(CGFloat) getBMINumWeight:(CGFloat)weight height:(CGFloat)height;

#pragma markk -- 获得BMI值指标 --
+(NSString *) getBMITarget:(CGFloat)bmi ;

#pragma mark -- 邮箱验证  ---
+ (BOOL) validateEmail:(NSString *)email;

#pragma mark --- 将文件保存在沙河下 ---
+(NSString *) getDocumentsImageFile:(NSData *)dataImag userID:(NSInteger)uid;

#pragma mark --是否存在相同的日期--
+(BOOL) isSameDate:(NSDate *) dateOne array:(NSArray *)dateArray;

#pragma mark --是否存在相同的日期--
+(NSInteger) insertPlaceInArray:(NSDate *) dateOne array:(NSArray *)dateArray;
@end
