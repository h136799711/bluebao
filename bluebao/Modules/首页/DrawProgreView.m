//
//  DrawProgreView.m
//  DrawCircle
//
//  Created by Mac on 15-7-19.
//  Copyright (c) 2015年 WZG. All rights reserved.
//

#import "DrawProgreView.h"

@implementation DrawProgreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
    
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [self drawCircle];
}

-(void)drawCircle
{
    
    CGFloat radius = self.bounds.size.height/2.0;
    //圆环
    UIBezierPath * p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:radius startAngle:0 endAngle:2*M_PI clockwise:NO];
    p.lineWidth = 1;
    [[UIColor lightGrayColor]set];
    [p stroke];
    
    //画线
//    CGPoint point =  CGPointMake(radius,radius);
    CGFloat  bet = 20 ;

    CGPoint pointOne = CGPointMake(10, radius + bet );
    CGPoint pointTow = CGPointMake(2*radius - 10, radius + bet);
    [[UIColor grayColor] set];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 1;

    [path1 moveToPoint:pointOne];
    [path1 addLineToPoint:pointTow];
    [path1 stroke];
    
    
    //已完成
    UILabel * finishlabel = [[UILabel alloc] init];
    finishlabel.bounds  = CGRectMake(0, 0, self.width, 20);
    finishlabel.center = CGPointMake(self.bounds.size.width/2.0, 5 + finishlabel.height/2.0 +6);
    finishlabel.text = @"已完成";
//    finishlabel.backgroundColor = [UIColor blueColor];
    finishlabel.textAlignment = NSTextAlignmentCenter;
    finishlabel.font = FONT(13);
    [self addSubview:finishlabel];
    
    //进度
    UILabel  * efficiLabel = [[UILabel alloc] init];
    efficiLabel.bounds =  CGRectMake(0, 0, finishlabel.width, pointTow.y - finishlabel.bottom - 10);
    efficiLabel.center = CGPointMake(finishlabel.center.x, finishlabel.bottom+ efficiLabel.height/2.0 +5);
    efficiLabel.text = @"0%";
//    efficiLabel.backgroundColor = [UIColor redColor];
    efficiLabel.font = FONT(20);
    efficiLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:efficiLabel];
    
    //目标
    UILabel  * goal = [[UILabel alloc]  init];
    goal.bounds = CGRectMake(0, 0, 30, 20);
//    goal.backgroundColor = [UIColor redColor];
    goal.center = CGPointMake(radius -  goal.width/2.0 -2, self.height - 15- goal.height/2.0);
    goal.font = FONT(15);
    goal.text = @"目标";
    [self addSubview:goal];
    
    //目标值
    UILabel * goalValue = [[UILabel alloc] init];
    goalValue.bounds = CGRectMake(0, 0, 40, 20);
    goalValue.center = CGPointMake(goal.right + goalValue.width/2.0 + 3, goal.center.y);
    goalValue.text = @"100";
    goalValue.font = FONT(16);
    goalValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview: goalValue];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
