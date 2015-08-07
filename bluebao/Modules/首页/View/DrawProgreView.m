//
//  DrawProgreView.m
//  DrawCircle
//
//  Created by Mac on 15-7-19.
//  Copyright (c) 2015年 WZG. All rights reserved.
//

#import "DrawProgreView.h"

@interface DrawProgreView (){
    
    UILabel         * _goalValue;
    
    //已完成
    UILabel         * _finishlabel;
    //进度
    UILabel         * _efficiLabel;
    CGFloat           radius_;
    
    UIBezierPath    * pBezier ;//圆柱
    
    CGFloat          _line_width;  //线宽
    CGFloat          _innerRadius; //内环半径
    CGFloat         _outRadius;   //外环半径
}

@end
@implementation DrawProgreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        
        _line_width = 20;
        _outRadius = (self.width - 1)/2.0;
        _innerRadius = _outRadius - _line_width;
        
        [self _initVews];
        
    }
    return self;
}


-(void)_initVews{
   
    
    
    
    //已完成
    _finishlabel = [[UILabel alloc] init];
    _finishlabel.bounds  = CGRectMake(0, 0, 80 , 20);
    
    CGFloat A = [self getChordX:_finishlabel.width/2.0];
    
    _finishlabel.center = CGPointMake(self.width/2.0, _outRadius - A- _finishlabel.height/2.0);
    _finishlabel.text = @"距离目标还有";
    //    finishlabel.backgroundColor = [UIColor blueColor];
    _finishlabel.tag = 1;
    _finishlabel.textAlignment = NSTextAlignmentCenter;
    _finishlabel.font = FONT(13);
    [self addSubview:_finishlabel];
    
    //进度
    _efficiLabel = [[UILabel alloc] init];
    
    CGFloat  haltHeight = _outRadius - _finishlabel.bottom - 15;
    
    _efficiLabel.bounds =  CGRectMake(0, 0, _finishlabel.width, haltHeight *2);
    _efficiLabel.center = CGPointMake(_finishlabel.center.x, _outRadius);
    _efficiLabel.text = @"0%";
    _efficiLabel.textColor = [UIColor colorWithHexString:@"#28cafb"];
    _efficiLabel.tag = 2;
    //    efficiLabel.backgroundColor = [UIColor redColor];
    _efficiLabel.font = FONT(20);
    _efficiLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_efficiLabel];
    
    //目标
    UILabel  * goal = [[UILabel alloc]  init];
    goal.bounds = CGRectMake(0, 0, 30, 20);
    //    goal.backgroundColor = [UIColor redColor];
    goal.center = CGPointMake(radius_ -  goal.width/2.0 -5, self.height - 15- goal.height/2.0);
    goal.font = FONT(13);
    goal.text = @"目标";
    [self addSubview:goal];
    
    //目标值
    _goalValue = [[UILabel alloc] init];
    _goalValue.bounds = CGRectMake(0, 0, 40, 20);
    _goalValue.tag = 3;
    _goalValue.center = CGPointMake(goal.right + _goalValue.width/2.0 + 3, goal.center.y);
    _goalValue.text = @"0";
    _goalValue.textColor = [UIColor colorWithHexString:@"#f78314"];
    _goalValue.font = FONT(16);
    _goalValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview: _goalValue];

    
}
-(void)drawRect:(CGRect)rect{

   

    [self drawCircle];
   
    [self drawBezier];

}

-(void)drawBezier{
    
    radius_ = self.bounds.size.height/2.0-1;
    //圆环
    pBezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:radius_ startAngle:0 endAngle:2*M_PI *0  clockwise:NO];
    pBezier.lineWidth = 2;
    [[UIColor redColor]set];
    [pBezier stroke];
    NSLog(@"%p",pBezier);

}
-(void)drawCircle
{
    
    radius_ = self.bounds.size.height/2.0-3;
    //圆环
    UIBezierPath * p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:radius_ startAngle:0 endAngle:2*M_PI clockwise:NO];
    p.lineWidth = 1;
    [[UIColor lightGrayColor]set];
    [p  stroke];
    
    
    //画线
//    CGPoint point =  CGPointMake(radius,radius);
    CGFloat  bet = 20 ;

    CGPoint pointOne = CGPointMake(15, radius_ + bet );
    CGPoint pointTow = CGPointMake(2*radius_ - 15, radius_ + bet);
    [[UIColor lightGrayColor] set];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 0.5;

    [path1 moveToPoint:pointOne];
    [path1 addLineToPoint:pointTow];
    [path1 stroke];
    
    }


-(void)setGoalNum:(CGFloat)goalNum{
    _goalNum = goalNum;
    
    _goalValue.text  = [NSString stringWithFormat:@"%d",(int)goalNum];
}

-(void)setFinishNum:(CGFloat)finishNum{

    _finishNum = finishNum;
    
    if (self.goalNum <= finishNum) {
        
        _finishlabel.text = @"已完成";
    }else{
        _finishlabel.text = @"未完成";

    }
    
    if (self.goalNum > 0) {
        
        CGFloat  percentage = (finishNum/self.goalNum)*100;
        
        _efficiLabel.text = [NSString stringWithFormat:@"%ld％",(NSInteger)percentage];
//        _per = percentage/100.0 ;

    }
    
}

-(CGFloat) getChordX:(CGFloat)B{
    
    CGFloat A = sqrtf(_innerRadius * _innerRadius - B *B);
    
    NSLog(@" a b c  %f  %f %f ",A,B,_innerRadius);
    return A;
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
