//
//  MyTool.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTool : NSObject

#pragma mark  获得字符串的大小（size）
+(CGSize)getSizeString:(NSString *)info font:(float) font;

#pragma mark  动画
+(void) setViewFlipFromRightAnimation:(UIView * )view;


#pragma mark  移动 rect
+(void) setAnimationView:(UIView * )view duration:(CGFloat)duration rect:(CGRect) rect;

#pragma mark  移动 pointCenten
+(void) setAnimationCGpointView:(UIView * )view duration:(CGFloat)duration pointCent:(CGPoint) pointCent;
    
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


@end
