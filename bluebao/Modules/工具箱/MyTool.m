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
        view.backgroundColor = [UIColor yellowColor];
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
#pragma mark -清理所有子视图
+(void)clearAllSonView:(UIView *)view{
  
    for (UIView * sonView in [view subviews]) {
        [sonView removeFromSuperview];
    }
}

#pragma mark -所有子视图是否可用
+(void)touchAbleSonView:(UIView *)view able:(BOOL)able{
    
    for (UIView * sonView in [view subviews]) {
        sonView.userInteractionEnabled = able;
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

+(NSString *) getStringFormstr:(NSString *)string withNumber:(NSInteger)number{
    
    NSString * str = [NSString stringWithFormat:@"%@%ld",string,(long)number];
    return str;
}


#pragma mark -- 获得当前日期  -
+(NSString *) getCurrentDateFormat:(NSString *)formatterStr{
   
    if(formatterStr == nil){
        formatterStr = [self defaultdateString];
    }
    NSDateFormatter *dateFormatter = [NSDate defaultDateFormatter];
    dateFormatter.dateFormat = formatterStr;
    

    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:formatterStr];
    
    //用[NSDate date]可以获取系统当前时间
//    [dateFormatter setDateStyle: NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//    DLog(@"\r currentdatestr :%@",currentDateStr);
    return currentDateStr;
}
//当前时间
+(NSDate *) getCurrentDate:(NSString *) dateFormat{
    
    if (dateFormat == nil) {
        dateFormat = [self defaultdateString];
    }
   NSDateFormatter * formatter = [self getDateFormatter:dateFormat ];
    formatter.dateFormat = dateFormat;
    NSString * datestr = [self getCurrentDateFormat:dateFormat];
    
    NSDate * currDate = [formatter dateFromString:datestr];
    currDate = [currDate dateByAddingTimeInterval:8 *3600];
    DLog(@"\r Datae-- - %@ ",currDate);
    return currDate;
}

//日期
+(NSDateFormatter *)getDateFormatter:(NSString *)format{
    
    
    if(format == nil){
        format =[self defaultdateString];
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];

    formatter.dateFormat= format;
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    return formatter;
}



#pragma mark -- 转化为data ---
+(NSDate *) changeStringToDate:(NSString *)datestr formatter:(NSString *)format{
    
    DLog(@"datestr:%@",datestr);
    if (format == nil) {
        format = [self defaultdateString];
    }
    NSDateFormatter * dateformat = [[NSDateFormatter alloc] init];
  
    [dateformat setDateFormat:format];
    NSDate * date = [dateformat dateFromString:datestr];
    return date;
}

+(NSString *)defaultdateString{
    
    return  @"yyyy-MM-dd HH:mm:ss";
}
#pragma mark -- 获得BMI --
+(NSString *) getBMIStringWeight:(CGFloat)weight height:(CGFloat)height{
    
    CGFloat bmi = [self getBMINumWeight:weight height:height];
//    DLog(@" bmi  %lf ",bmi);
    return [MyTool getBMITarget:bmi];
}

#pragma markk -- 获得BMI值 --
+(CGFloat) getBMINumWeight:(CGFloat)weight height:(CGFloat)height{
    if (height == 0) {
        return 0;
    }
    return ( weight * 10000/((height * height)));
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
+(void) isSameGoalData:(GoalData *) dateOne array:(NSArray *)dateArray complete:(void(^)(NSInteger goalIndex))complete{
    
    NSInteger  index = -1;
    
    for (int i = 0 ; i < dateArray.count; i ++) {
        GoalData * dateTow  = dateArray[i];
        if ([dateOne.timestr isEqualToString:dateTow.timestr]) {
//            DLog(@"  maxindex %ld - %ld",(long)dateOne.maxIndex,(long)dateTow.maxIndex);
            index = i;
            break;
        }
    }
    complete(index);
}


#pragma mark --将数值转化为字符串
+(NSString * ) getStringToInteger:(NSInteger) number{

    NSString * string = [NSString stringWithFormat:@"%ld",(long)number];
    return string;
}
    
#pragma mark --将浮点型数值转化为字符串
+(NSString * ) getStringToFloat:(CGFloat) number{
    
    NSString * string = [NSString stringWithFormat:@"%.2f",number];
    return string;
}
    
#pragma mark -- 默认目标值，
+(BOOL) isGoalValueZero:(NSInteger)goalValue {
    
    if (goalValue<=0) {
        return YES;
    }
    return NO;
}
    
#pragma mark -- 默认目标值，500

+(NSInteger) getDefaultGoalValue:(NSInteger)goalValue {
    if ([self isGoalValueZero:goalValue]) {
        return  500;
    }else{
        return goalValue;
    }
}

+(void) tesGoal:(NSArray *) arr{
    return ;
//    DLog(@"------------goal----------------------------------");
//    for (GoalData * data in arr) {
//        
//        DLog(@" \r-time %@- goalnum%ld maindex  %ld-",data.timestr,(long)data.goalNumber,(long)data.maxIndex);
//    }
}


+(void) testBicyle:(Bicyle *)bicyle{
    DLog(@"------------bicyle----------------------------------");

    DLog(@" \r speed %ld \r heart_rate  %ld \r distance %ld \r total_distance %ld \r cost_time %ld \r calorie %ld",
          (long)bicyle.speed,
          (long)bicyle.heart_rate,
          (long)bicyle.distance,
          (long)bicyle.total_distance,
          (long)bicyle.cost_time,
          (long)bicyle.calorie);
}
+(NSArray *) weekString{
    
    NSArray * array = [[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    return array;
}

//userinfo 登陆时数据返回不正确时
+(UserInfo *) defaultUserInfo:(UserInfo *)userInfo{
    
    if (userInfo.age<= 8) {
        userInfo.age = 20;
    }
    if (userInfo.height <= 0) {
        userInfo.height = 170;
    }
    if (userInfo.weight <=0) {
        userInfo.weight = 55;
    }
    if (userInfo.target_weight <= 0) {
        userInfo.target_weight = 55;
    }

    return userInfo;
}


//获得目标模型标识
+(NSInteger)getGoalModelIndex:(NSString *)date_time{
    if (date_time == nil) {
        return 0;
    }
    NSMutableString * string = [[NSMutableString alloc] initWithString:date_time];
    NSArray * timearray = [string componentsSeparatedByString:@":"];
    NSInteger hour = [[timearray firstObject] integerValue];
    NSInteger mine = [[timearray lastObject] integerValue];
    NSInteger index  = hour * 60 + mine;
//    DLog(@"\r timestr :%@ \r hour: %ld  \r mine %ld  %ld",date_time,hour,mine,index);
    return index;
}

@end
