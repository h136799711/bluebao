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

+(void) testViewsBackGroundView:(UIView*)view colorNum:(int)num{

    if (num == 0) {
        view.backgroundColor = [UIColor redColor];
    }else if (num == 1){
        view.backgroundColor = [UIColor blackColor];
    }else{
        view.backgroundColor = [UIColor blueColor];
    }
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
    view.layer.borderWidth = 1;
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
    
    if ([stringOne isEqualToString:stringTow]) {
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
    label.backgroundColor = [UIColor colorWithHexString:@"#c8c8c8"];
    [view addSubview:label];
    return label;
}

#pragma mark --数量与字符串拼接--
+(NSString *) stringWithNumFormat:(NSString *)string number:(CGFloat)number{
    
    NSString * str = [NSString stringWithFormat:@"%0.1f%@",number,string];
    return str;
}


#pragma mark -- 获得当前日期  -
+(NSString *) getCurrentDataFormat:(NSString *)formatterStr{
   
    if(formatterStr == nil){
        formatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    

    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:formatterStr];
    
    //用[NSDate date]可以获取系统当前时间
//    [dateFormatter setDateStyle: NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//    NSLog(@"\r currentdatestr :%@",currentDateStr);
    return currentDateStr;
}

//日期
+(NSDateFormatter *)getDateFormatter:(NSString *)format{
    
    
    if(format == nil){
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:format];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    return formatter;
}



#pragma mark -- 转化为data ---
+(NSDate *) changeStringToDate:(NSString *)datestr formatter:(NSString *)format{
    
    NSLog(@"datestr:%@",datestr);
    if (format == nil) {
        format = @"yyyy-MM-dd-HH:mm:ss";
    }
    NSDateFormatter * dateformat = [[NSDateFormatter alloc] init];
  
    [dateformat setDateFormat:format];
    NSDate * date = [dateformat dateFromString:datestr];
    return date;
}

#pragma mark -- 获得BMI --
+(NSString *) getBMIStringWeight:(CGFloat)weight height:(CGFloat)height{
    
    CGFloat bmi = [self getBMINumWeight:weight height:height];
//    NSLog(@" bmi  %lf ",bmi);
    return [MyTool getBMITarget:bmi];
}

#pragma markk -- 获得BMI值 --
+(CGFloat) getBMINumWeight:(CGFloat)weight height:(CGFloat)height{
    
    return ( weight/((height/100.0) * (height/100.0)));
}

#pragma markk -- 获得BMI值指标 --
+(NSString *) getBMITarget:(CGFloat)bmi {
    
    NSString  * string = @"";

    if (bmi < 18.5) {
        string = @"偏瘦";
    }else if (bmi >= 28){
        string = @"偏胖";
    }else{
        string = @"正常";
    }
    return string;

}



#pragma mark -- 邮箱验证  ---
+ (BOOL) validateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}




#pragma mark --是否存在相同的日期--
+(void) isSameGoalData:(GoalData *) dateOne array:(NSArray *)dateArray complete:(void(^)(BOOL sameGoal))complete{
    
    for (GoalData * dateTow in dateArray) {
       
        if (dateOne.maxIndex == dateTow.maxIndex) {
           
            complete (YES);
            return ;
        }
    }
}


#pragma mark --讲数值转化为字符串
+(NSString * ) getIntegerToString:(NSInteger) number{

    NSString * string = [NSString stringWithFormat:@"%ld",number];
    return string;
}
    
    
    
    
    
    

@end
