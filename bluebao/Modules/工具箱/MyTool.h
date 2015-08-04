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

/// 日期相关  ********

#pragma mark -- 获得当前日期  -
+(NSString *) getCurrentDataFormat:(NSString *)formatterStr;

#pragma mark -- 获得当前日期-
+(NSDateFormatter *)getDateFormatter:(NSString *)format;

#pragma mark -- 时间字符串 转化为date ---
+(NSDate *) changeStringToDate:(NSString *)datestr formatter:(NSString *)format;

#pragma mark --是否存在相同的日期--
+(void) isSameGoalData:(GoalData *) dateOne array:(NSArray *)dateArray complete:(void(^)(BOOL sameGoal))complete;

//#pragma mark --获得插入位置--
//+(NSInteger) getInsertPlaceInArray:(NSDate *) dateOne array:(NSArray *)dateArray;
//
////
//#pragma mark --获得插入位置相同的日期--
//+(NSInteger) getInsertPlaceInArray:(NSDate *) dateOne array:(NSArray *)dateArray{
//    
//    GoalData  * first_goal = [dateArray firstObject];
//    GoalData * last_goal = [dateArray lastObject];
//    
//    if ([dateOne  compare:first_goal.dateTime] ==NSOrderedAscending) {
//        return 0;
//    }else if ([dateOne  compare:last_goal.dateTime] ==NSOrderedDescending) {
//        
//        return dateArray.count-1;
//    }else{
//        
//        NSInteger  num = 0;
//        
//        for (NSInteger i = 1; i < dateArray.count-1; i ++) {
//            
//            GoalData  * onegoal = [dateArray objectAtIndex:i];
//            GoalData * towgoal = [dateArray objectAtIndex:i+1];
//            BOOL isone = [dateOne compare:onegoal.dateTime]==NSOrderedDescending;
//            BOOL istow = [dateOne compare:towgoal.dateTime]==NSOrderedAscending;
//            
//            if (isone &&istow) {
//                
//                num = i;
//                break;
//            }
//        }
//        return num;
//    }
//}

//////计算BMI********

#pragma mark -- 获得BMI --
+(NSString *) getBMIStringWeight:(CGFloat)weight height:(CGFloat)height;

#pragma markk -- 获得BMI值 --
+(CGFloat) getBMINumWeight:(CGFloat)weight height:(CGFloat)height;

#pragma markk -- 获得BMI值指标 --
+(NSString *) getBMITarget:(CGFloat)bmi ;

#pragma mark -- 邮箱验证  ---
+ (BOOL) validateEmail:(NSString *)email;

#pragma mark --讲数值转化为字符串
+(NSString * ) getFloadToString:(CGFloat) fload ;
@end
