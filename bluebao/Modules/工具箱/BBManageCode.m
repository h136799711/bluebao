//
//  BBManageCode.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BBManageCode.h"

@implementation BBManageCode


//创建目标区头
+(UIView *)creatGoalHeaderView{
    
    NSArray * array = @[@"时间",@"目标",@"完成度",@"操作"];
    UIView * title_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 40)];
    
    //上横线
    [MyTool createLineInView:title_view fram:CGRectMake(0, 0, title_view.width, 2)];
    //下横线
    [MyTool createLineInView:title_view fram: CGRectMake(0, 42, title_view.width, 2)];
    
    
    CGFloat   l_width = title_view.width/4.0;
    
    // 时间，目标， 完成度 操作
    for (int i = 0;  i < 4 ; i ++) {
        
        UILabel * labelsort = [[UILabel alloc] init];
        labelsort.frame = CGRectMake(l_width *i, 0, l_width, title_view.height);
        labelsort.textAlignment = NSTextAlignmentCenter;
        labelsort.font = FONT(15);
        [title_view addSubview:labelsort];
        labelsort.text = array[i];
        //        labelsort.backgroundColor = [UIColor clearColor];
    }
    //竖线
    for (int i = 0; i < 3 ; i ++) {
        UILabel * label_v = [[UILabel alloc] init];
        label_v.frame = CGRectMake(l_width* (i+1), -1, 2, title_view.height+3);
        label_v.backgroundColor = [UIColor lightGrayColor];
        
        [title_view addSubview:label_v];
    }
    
    return title_view;
}

//创建身高体重等
+(UILabel *)creatMessageCenterInViews:(UIView *)view  num:(int) num{
    
    CGFloat  left = 35; //左间距
    CGFloat  hwb_width = 45;
    CGFloat infoLabel_width = ( view.width - left *2 -hwb_width *3)/3.0;
    NSArray  * a = @[@"身高",@"体重",@"BMI"];

    //身高体重、、
    UILabel * label_ = [[UILabel alloc] init];
    label_.frame = CGRectMake(left+(hwb_width +infoLabel_width)*num, 0, hwb_width,  view.height);
    label_.text = a[num];
    label_.font = FONT(15);
    [ view addSubview:label_];

    //值
    UILabel * value_label = [[UILabel alloc]initWithFrame:CGRectMake(label_.right, 0, infoLabel_width, view.height)];
    value_label.textColor =  [UIColor colorWithHexString:@"#74e7f7"];
    value_label.font = FONT(30);
    [view addSubview:value_label];
    value_label.text = @"xxxx";
    return value_label;
}



@end
