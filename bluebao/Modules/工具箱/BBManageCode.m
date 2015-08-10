//
//  BBManageCode.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BBManageCode.h"
#import "LNowBicyleData.h"
@implementation BBManageCode


//创建目标区头
+(UIView *)creatGoalHeaderView{
    
    NSArray * array = @[@"时间",@"目标",@"操作"];
    UIView * title_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 40)];
    
    //上横线
    [MyTool createLineInView:title_view fram:CGRectMake(0, 0, title_view.width, 1)];
    //下横线
    [MyTool createLineInView:title_view fram: CGRectMake(0, 43, title_view.width, 1)];
    
    
    CGFloat   l_width = title_view.width/array.count;
    
    // 时间，目标， 完成度 操作
    for (int i = 0;  i < array.count ; i ++) {
        
        UILabel * labelsort = [[UILabel alloc] init];
        labelsort.frame = CGRectMake(l_width *i, 0, l_width, title_view.height);
        labelsort.textAlignment = NSTextAlignmentCenter;
        labelsort.font = FONT(15);
        [title_view addSubview:labelsort];
        labelsort.text = array[i];
        //        labelsort.backgroundColor = [UIColor clearColor];
    }
    //竖线
    for (int i = 0; i < array.count -1 ; i ++) {
        [MyTool createLineInView:title_view fram:CGRectMake(l_width* (i+1), 0, 1, title_view.height+3)];
    }
    
    return title_view;
}

//创建身高体重等
+(UILabel *)creatMessageCenterInViews:(UIView *)view  num:(int) num{
    
    CGFloat  left = 35; //左间距
    CGFloat  hwb_width = 35;
    CGFloat infoLabel_width = ( view.width - left *2 -hwb_width *3)/3.0;
    NSArray  * a = @[@"身高",@"体重",@"BMI"];

    //身高体重、、
    UILabel * label_ = [[UILabel alloc] init];
    label_.frame = CGRectMake(left+(hwb_width +infoLabel_width)*num, 0, hwb_width,  view.height);
    label_.text = a[num];
    label_.textAlignment = NSTextAlignmentLeft;
    label_.font = FONT(15);
//    label_.backgroundColor = [UIColor redColor];
    [ view addSubview:label_];

    //值
    UILabel * value_label = [[UILabel alloc]initWithFrame:CGRectMake(label_.right, 0, infoLabel_width+14, view.height)];
    value_label.textColor =  [UIColor colorWithHexString:@"#74e7f7"];
    value_label.font = FONT(20);
    label_.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:value_label];
//    value_label.backgroundColor = [UIColor redColor];
//    value_label.text = @"xxxx";
    
    
    return value_label;
}

//TabbarView
+(UIView *)creatTabbarShow:(UIView * ) showView button:(UIButton *)btn ImagName:(NSString *)name titleLabel:(NSString *)title{
    
    CGFloat  left = 40;
    CGFloat  width = 28;
    CGFloat  between = (showView.width -left*2 -width *4)/3.0;

    
    //按钮
    btn.bounds = CGRectMake(0, 0, width, width);
    btn.center = CGPointMake(left + btn.width/2.0 +(btn.width + between) *btn.tag, btn.height/2.0 + 5);
    
    [showView addSubview:btn];
    
    //文字
    UILabel * label = [[UILabel alloc] init];
    [showView addSubview:label];

    CGSize size = [MyTool getSizeString:title font:12];
    label.bounds = CGRectMake(0, 0, size.width, size.height);
    label.center = CGPointMake(btn.center.x, btn.bottom + label.height/2.0+1);
    label.text = title;
    label.textColor = [UIColor lightGrayColor];
    label.tag = btn.tag +1;
    label.font = FONT(12);
    [showView addSubview:label];
    
    
    
    return showView;
}

//个人资料

+(UIView *) createdPersonInfoShowInView:(UIView *)_headView headBtn:(UIButton *)headImageBtn signTestField:(UITextField *)personSignTextfield label:(UITextField *)label{
    
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    
    CGFloat  headWidth = 80;
    //头像
    headImageBtn.bounds = CGRectMake(0, 0, headWidth, headWidth);
    headImageBtn.center = CGPointMake(_headView.width/2.0-10, 40 + headWidth/2.0);
    [_headView addSubview:headImageBtn];
//    [headImageBtn setTitle:@"头像" forState:UIControlStateNormal];
    headImageBtn.backgroundColor = [UIColor redColor];
//    [headBtn addTarget:self action:@selector(uploadHeadImage) forControlEvents:UIControlEventTouchUpInside];
    [MyTool cutViewConner:headImageBtn radius:headImageBtn.width/2.0];
    
    
    //编辑签名
    UserInfo * userinfo = [MainViewController sharedSliderController].userInfo;
    personSignTextfield= [[UITextField alloc] init];
    personSignTextfield.bounds = CGRectMake(0, 0, 240,30);
    personSignTextfield.center = CGPointMake(headImageBtn.center.x, headImageBtn.bottom + personSignTextfield.height/2.0+3);
    personSignTextfield.textAlignment = NSTextAlignmentCenter;
    personSignTextfield. borderStyle  = UITextBorderStyleNone;
    personSignTextfield.font = FONT(16);
    personSignTextfield.text = userinfo.nickname;
    personSignTextfield.tag = 1001;
    personSignTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_headView addSubview:personSignTextfield];
    
    //    签名
    label = [[UITextField alloc] init];
    label.bounds = CGRectMake(0, 0, 240, 20);
    label.center = CGPointMake(personSignTextfield.center.x, personSignTextfield.bottom +10+ label.height/2.0);
    label.text = userinfo.signature;
    label.tag = 1002;
    label.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    if([label.text length]== 0){
        label.text = @"请输入您的个性签名";
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    [_headView addSubview:label];

    return _headView;
    
}





//创建圆角 背景
+(void)createdBackGroundView:(UIView *)bottomView indexRow:(NSInteger)row maxCount:(NSInteger) maxCount{
        
    CGFloat  radiu = 15;
    
    //切割圆内角
    UIView  * view_cut = [[UIView alloc] init];
    view_cut.tag = 1008;
    view_cut.frame = CGRectMake(0, 0, bottomView.width, bottomView.height);
    view_cut.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];
    [MyTool cutViewConner:view_cut radius:radiu];
    
    [bottomView addSubview:view_cut];
    
    //覆盖上层
    if (row != 0) {
        //覆盖圆角
        UIView * fg_One = [[UIView alloc] init];
        fg_One.tag = 1008;
        fg_One.frame = CGRectMake(view_cut.left, 0, view_cut.width, radiu);
        fg_One.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];
        [bottomView addSubview:fg_One];
        
        [bottomView sendSubviewToBack:fg_One];
        
    }
    
    //覆盖下层
    if (row != maxCount) {
        
        //覆盖圆角
        UIView * fg_Tow = [[UIView alloc] init];
        fg_Tow.tag = 1008;
        fg_Tow.frame = CGRectMake(view_cut.left, bottomView.bottom -radiu, view_cut.width, radiu);
        fg_Tow.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];
        [bottomView addSubview:fg_Tow];
        
        [bottomView sendSubviewToBack:fg_Tow];
    }
    
    [bottomView sendSubviewToBack:view_cut];


}

#pragma mark --获得插入位置相同的日期--
+(NSInteger) getInsertPlaceInArray:(NSDate *) dateOne array:(NSArray *)dateArray{
    
    GoalData  * first_goal = [dateArray firstObject];
    GoalData * last_goal = [dateArray lastObject];
    
    if ([dateOne  compare:first_goal.dateTime] ==NSOrderedAscending) {
        return 0;
    }else if ([dateOne  compare:last_goal.dateTime] ==NSOrderedDescending) {
        
        return dateArray.count-1;
    }else{
        
        NSInteger  num = 0;
        
        for (NSInteger i = 0; i < dateArray.count-1; i ++) {
            
            GoalData  * onegoal = [dateArray objectAtIndex:i];
            GoalData * towgoal = [dateArray objectAtIndex:i+1];
            BOOL isone = [dateOne compare:onegoal.dateTime]==NSOrderedDescending;
            BOOL istow = [dateOne compare:towgoal.dateTime]==NSOrderedAscending;
            
            if (isone &&istow) {
                
                num = i;
                break;
            }
        }
        return num;
    }
}

// 数值排序 goal
+(NSArray *)sequenceGoalDataArray:(NSArray *)dataArray {
    
    GoalData * tempGoal= [[GoalData alloc] init];
    GoalData * aGoal ;
    GoalData * bGoal ;
    
    if (dataArray.count>=2){
       
        for (NSInteger i = dataArray.count -1; i >= 1 ; i--) {
            aGoal = [dataArray objectAtIndex:i];
            bGoal = [dataArray objectAtIndex:i-1];
            if (aGoal.maxIndex <  bGoal.maxIndex) {
//                NSLog(@"'\r  ***********   goal.maxIndex : ");
 
                tempGoal = aGoal;
                aGoal = bGoal;
                bGoal = tempGoal;
            }
        }
    }
    
    return dataArray;
}

#pragma mark -- 蓝堡首页 --
+(NSString *) getHeaderStrRow:(NSInteger)row bicyle:(Bicyle *)_bicylelb{
    
    NSString * string = @"";
    switch (row) {
        case 0: //心率
            string = [MyTool getStringToInteger:_bicylelb.heart_rate];
            break;
            
        case 1://速度
            string = [MyTool getStringToInteger:_bicylelb.speed];
            string = [NSString stringWithFormat:@"%@km/h",string];
            
            break;
        case 2://时间
//            string = [MyTool getStringToInteger:_bicylelb.cost_time];
            string = [NSDate getDateHour:_bicylelb.cost_time];

            break;
        case 3://运动消耗
            string = [MyTool getStringToFloat:_bicylelb.calorie/10.0];
            string = [NSString stringWithFormat:@"%@卡",string];

            break;
        case 4://路程
            string = [MyTool getStringToFloat:_bicylelb.distance/100.0];
            string = [NSString stringWithFormat:@"%@km",string];

            break;
            
        default:
            break;
    }
    return string;
}

-(void) saveBicyle:(Bicyle *)bicyle{
    
    NSString * bicyleString = [NSString stringWithFormat:@"%ld/",(long)bicyle.heart_rate];
    bicyleString = [MyTool getStringFormstr:bicyleString withNumber:bicyle.speed];
    bicyleString = [MyTool getStringFormstr:bicyleString withNumber:bicyle.cost_time];
    bicyleString = [MyTool getStringFormstr:bicyleString withNumber:bicyle.calorie];
    bicyleString = [MyTool getStringFormstr:bicyleString withNumber:bicyle.total_distance];

    [USER_DEFAULT setObject:bicyleString forKey:@"bicyle_data"];
    
//    NSArray * array = [bicyleString componentsSeparatedByString:@"/"];
    
}


#pragma mark -- 获得个人健康指标
+(NSInteger) getPersonHealthCondition:(NSInteger)row userInfo:(UserInfo *)userInfo{
   
    NSInteger  valueNum = 0;
  
    
    switch (row) {
        case 0: //体脂肪率
            valueNum= 36;
            break;
        case 1://体水分率
            valueNum = 50;
            break;
        case 2://年龄
            valueNum = userInfo.age;
            break;
        case 3://基础代谢
            valueNum= 15;
            break;
        case 4://肌肉含量
            valueNum= 45;
            break;
        case 5://内脏脂肪率
            valueNum = 5;
            break;
        case 6://骨骼含量
            valueNum = 3;

            break;
        case 7://皮下脂肪
            valueNum = 10;
            break;
            
        default:
            break;
    }
    
    return valueNum;
}

//体脂肪率
-(NSInteger) getBodyFatPercent:(UserInfo *)userInfo{
    
    CGFloat bmi = [MyTool getBMINumWeight:userInfo.weight height:userInfo.height];
    
    CGFloat bodyfatValue =    1.2 * bmi +0.23 * userInfo.age - 5.4 - 10.8 * userInfo.sex;

    
    if (bodyfatValue <= 0) {
        return 36;
    }
    
    return (NSInteger) bodyfatValue;
}

//基础代谢
-(NSInteger) getBodyBaseReplace:(UserInfo *)userInfo{
    
    CGFloat  value = 0;
    if (userInfo.age == 1) { //女性
        value = 66 + (6.3 * userInfo.weight) + (12.9 * (userInfo.height * 100/254))-6.8 * userInfo.age;
    }else{
        
        value = 65.5 + (4.3 * userInfo.weight) +(4.7 * (userInfo.height * 100/254)) - 4.7 * userInfo.age;
    }
    
    if (value <= 0) {
        return 15;
    }
    return value;
}

@end
