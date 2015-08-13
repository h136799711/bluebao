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
    UIBezierPath    * pBezier ;//圆柱
    CGFloat          _line_width;  //线宽
    CGFloat          _innerRadius; //内环半径
    CGFloat         _outRadius;   //外环半径
    CGFloat          _per;
}
@end
@implementation DrawProgreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        
        _line_width = 20;
        _outRadius = (self.width - 0.5)/2.0;
        _innerRadius = _outRadius - _line_width;
        _per = 0;
        [self _initVews];
    }
    return self;
}



-(void)_initVews{
   
    
    //已完成
    
    NSString * finishstr = @"距离目标还有";
    CGSize  finisize = [MyTool getSizeString:finishstr font:13];
    _finishlabel = [[UILabel alloc] init];
    _finishlabel.bounds  = CGRectMake(0, 0, finisize.width , finisize.height+4);
    CGFloat A = [self getChordX:_finishlabel.width/2.0+4];
    
    _finishlabel.center = CGPointMake(_outRadius, _outRadius - A +  _finishlabel.height/2.0);
    _finishlabel.text = finishstr;
    _finishlabel.tag = 1;
    _finishlabel.textAlignment = NSTextAlignmentCenter;
    _finishlabel.font = FONT(13);
    [self addSubview:_finishlabel];
    
    
    //进度
    _efficiLabel = [[UILabel alloc] init];
    
    CGFloat  haltHeight = 20;
    _efficiLabel.bounds =  CGRectMake(0, 0, _innerRadius*2, haltHeight*2);
    _efficiLabel.center = CGPointMake(_finishlabel.center.x, _outRadius);
    _efficiLabel.text = @"0%";
    _efficiLabel.textColor = [UIColor colorWithHexString:@"#28cafb"];
    _efficiLabel.tag = 2;
    //    efficiLabel.backgroundColor = [UIColor redColor];
    _efficiLabel.font = FONT(30);
    _efficiLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_efficiLabel];
    
    //目标
    UILabel  * goal = [[UILabel alloc]  init];
    goal.bounds = CGRectMake(0, 0, 30, 20);
    //    goal.backgroundColor = [UIColor redColor];
    goal.center = CGPointMake(_outRadius  -  goal.width/2.0-5 , _efficiLabel.bottom +  goal.height/2.0 + 8);
    goal.font = FONT(13);
    goal.text = @"目标";
    [self addSubview:goal];
    
    //目标值
    _goalValue = [[UILabel alloc] init];
    _goalValue.bounds = CGRectMake(0, 0, 60, 20);
    _goalValue.tag = 3;
    _goalValue.center = CGPointMake(goal.right + _goalValue.width/2.0 , goal.center.y);
    _goalValue.text = @"0";
    _goalValue.textColor = [UIColor colorWithHexString:@"#f78314"];
    _goalValue.font = FONT(22);
    _goalValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview: _goalValue];

    
}
-(void)drawRect:(CGRect)rect{

    [self drawBezier];
}

-(void)drawBezier{
    
    //圆环
    pBezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:_innerRadius + _line_width/2.0 startAngle:0 endAngle:2*M_PI   clockwise:NO];
    pBezier.lineWidth = _line_width;
    [[UIColor colorWithHexString:@"#f1f1f1"]set];
    [pBezier stroke];

}


-(void)setGoalNum:(CGFloat)goalNum{
    
    if (goalNum <= 0) {
        goalNum = 0;
    }
    _goalNum = goalNum;
    
    _goalValue.text  = [NSString stringWithFormat:@"%d",(int)goalNum];
    
    [self doing];
}

-(void)setFinishNum:(CGFloat)finishNum{

    if (finishNum <= 0) {
        finishNum = 0;
    }
    
    _finishNum = finishNum;

    [self doing];
   
}

//
-(void) doing{
   
    //完成度提示
    if (_goalNum <= _finishNum && _goalNum != 0) {
        _finishlabel.text = @"已完成";
    }else{
        _finishlabel.text = @"距离目标还有";
    }
    

    //判断
    CGFloat  percentage = 0;
    
    if (_goalNum > 0) {
        percentage =  _finishNum*10  /_goalNum;
    }else{
        
        NSLog(@"目标值不能小于0");
        return;

    }
    
    if (_goalNum <= _finishNum) {
        percentage = 100;
    }
    
    _efficiLabel.text = [NSString stringWithFormat:@"%ld％",(NSInteger)percentage];
    

    _per = percentage/100.0 ;

}

-(void) showCircleView{
    
    //先清除
    [self removeCircleView];
    //再创建
    [self creatCiecleView];
    
}
//创建 cirele
-(void)creatCiecleView{
 
    if (_circleBezierView == nil) {
        _circleBezierView = [[CircleBezierView alloc] initWithFrame:self.frame];
        _circleBezierView.center = CGPointMake(self.width/2.0, self.height/2.0);
        _circleBezierView.line_width = _line_width;
        _circleBezierView.innerRadius = _innerRadius;
        
        
        _circleBezierView.angle = _per;
        [self addSubview:_circleBezierView];
    }
}

//清除 cirele
-(void)removeCircleView{
    
    if (_circleBezierView != nil) {
        [_circleBezierView removeFromSuperview];
        _circleBezierView = nil;
    }
}
//勾股定理
-(CGFloat) getChordX:(CGFloat)B{
    
    CGFloat A = sqrtf(_innerRadius * _innerRadius - B*B);
    return A;
}

//默认状态下远

-(void) showDefaultCircleView{
    
    [self removeCircleView];
    [self creatCiecleView];
    _circleBezierView.angle = 0.5;
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
