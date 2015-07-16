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
    [MyTool createLineInView:title_view fram:CGRectMake(0, 0, title_view.width, 1)];
    //下横线
    [MyTool createLineInView:title_view fram: CGRectMake(0, 43, title_view.width, 1)];
    
    
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
        [MyTool createLineInView:title_view fram:CGRectMake(l_width* (i+1), 0, 1, title_view.height+3)];
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

//TabbarView
+(UIView *)creatTabbarShow:(UIView * ) showView button:(UIButton *)btn ImagName:(NSString *)name titleLabel:(NSString *)title{
    
    CGFloat  width_ = showView.width/4.0;
    UIView * view_ = [[UIView alloc] init];
    view_.frame = CGRectMake(width_*btn.tag, 0, width_, showView.height);
    
     //按钮
    btn.bounds = CGRectMake(0, 0, 30, 30);
    [view_ addSubview:btn];
    
     //文字
    UILabel * label = [[UILabel alloc] init];
    [view_ addSubview:label];
  
    CGSize size = [MyTool getSizeString:title font:15];
    label.bounds = CGRectMake(0, 0, size.width, size.height);
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.tag = btn.tag +1;
    label.font = FONT(15);
    
    
     //图与按钮间的距离
    CGFloat space = 5;
    CGFloat  between = (width_- label.width - btn.width)/2.0;
    
    btn.center = CGPointMake(between + btn.width/2.0 , view_.height/2.0);
    label.center = CGPointMake(btn.right + space+ label.width/2.0, btn.center.y);
    [showView addSubview:view_];
    
    return view_;
}

//个人资料

+(UIView *) createdPersonInfoShowInView:(UIView *)_headView headBtn:(UIButton *)headImageBtn signTestField:(UITextField *)personSignTextfield label:(UILabel *)label{
    
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    
    CGFloat  headWidth = 80;
    //头像
    headImageBtn.bounds = CGRectMake(0, 0, headWidth, headWidth);
    headImageBtn.center = CGPointMake(_headView.width/2.0-10, 40 + headWidth/2.0);
    [_headView addSubview:headImageBtn];
    [headImageBtn setTitle:@"头像" forState:UIControlStateNormal];
    headImageBtn.backgroundColor = [UIColor redColor];
//    [headBtn addTarget:self action:@selector(uploadHeadImage) forControlEvents:UIControlEventTouchUpInside];
    [MyTool cutViewConner:headImageBtn radius:headImageBtn.width/2.0];
    
    
    //编辑签名
    
    personSignTextfield= [[UITextField alloc] init];
    personSignTextfield.bounds = CGRectMake(0, 0, 80, 30);
    personSignTextfield.center = CGPointMake(headImageBtn.center.x, headImageBtn.bottom + personSignTextfield.height/2.0+3);
    personSignTextfield.textAlignment = NSTextAlignmentCenter;
    personSignTextfield. borderStyle  = UITextBorderStyleNone;
    personSignTextfield.font = FONT(16);
    personSignTextfield.text = @"张三";
    [_headView addSubview:personSignTextfield];
    
    //    签名
    label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, 160, 12);
    label.center = CGPointMake(personSignTextfield.center.x, personSignTextfield.bottom + label.height/2.0);
    label.text = @"请输入您的个性签名";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:13];
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


@end
