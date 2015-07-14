//
//  MyTool.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "MyTool.h"

@implementation MyTool


#pragma mark --test--

+(void) testViews:(UIView * )view{

    view.layer.borderWidth = 2;
    view.layer.borderColor = [UIColor redColor].CGColor;
}



#pragma mark  获得字符串的大小（size）

+(CGSize)getSizeString:(NSString *)info font:(float) font{
    
    UIFont* infofont = [UIFont boldSystemFontOfSize:font];
    //CGSize size = [info sizeWithFont:font];//这个字体大小一定要和label的字体大小保持一致
    CGSize size = [info sizeWithAttributes:@{NSFontAttributeName: infofont}];
    
    return size;
}


#pragma mark  动画
+(void) setViewFlipFromRightAnimation:(UIView * )view{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:view cache:NO];
    [UIView commitAnimations];
}

#pragma mark  Rect
+(void) setAnimationView:(UIView * )view duration:(CGFloat)duration rect:(CGRect) rect;
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    view.frame = rect;
    [UIView commitAnimations];
}

#pragma mark  PointCent
+(void) setAnimationCentView:(UIView * )view duration:(CGFloat)duration pointCent:(CGPoint) pointCent{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    view.center = pointCent;
    [UIView commitAnimations];

}

#pragma mark  返回图片对象
+(UIImage *) getImageOfString:(NSString *)imagString{
    
    UIImage * image = [UIImage imageNamed:imagString];
    return image;
}


#pragma mark   清理特殊标签的子视图 ---

+(void)clearCellSonView:(UIView*)contentView viewTag:(NSInteger) tag {
    
    for (UIView * view in [contentView subviews]) {
        
        if (view.tag == tag) {
            
            [view removeFromSuperview];
        }
    }
}


#pragma mark 切割圆角
+(void)cutViewConner:(UIView *)view radius:(CGFloat)radius{

    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    
}

#pragma mark -- 设置边框--
+(void)setViewBoard:(UIView *) view{
    
    view.layer.borderColor = [UIColor colorWithHexString:@"#c7c7c7"].CGColor;
    view.layer.borderWidth = 2;
}


#pragma mark -- 返回color 对象 --
+(UIColor *) getColor:(NSString *) colorString{
    return [UIColor colorWithHexString:colorString];
}

#pragma mark -- 输入是否为空 --
+(BOOL) inputIsNull:(NSString *) text{
    if (text.length<=0) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -- 字符串相等 ---
+(BOOL)isEqualToString:(NSString *)stringOne string:(NSString *)stringTow{
    
    if ([stringOne isEqualToString:stringOne]) {
        return YES;
    }else{
        return NO;
    }
}


#pragma mark -- 创建一条线
+(UIView *)createLineInView:(UIView *)view fram:(CGRect )rect{
    
    UILabel * label =  [[UILabel alloc] init];
    label.tag = 1008;
    label.frame = rect;
    label.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:label];
    return label;
}

#pragma mark --数量与字符串拼接--
+(NSString *) stringWithNumFormat:(NSString *)string number:(CGFloat)number{
    
    NSString * str = [NSString stringWithFormat:@"%0.1f%@",number,string];
    return str;
}

@end
