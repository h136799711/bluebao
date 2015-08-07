//
//  CircleBezierView.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "CircleBezierView.h"

@interface CircleBezierView ()



@end
@implementation CircleBezierView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    
    //圆环
    UIBezierPath *  pBezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:_innerRadius + _line_width/2.0 startAngle:-M_PI_2 endAngle:2*M_PI * _angle -M_PI_2  clockwise:YES];
    pBezier.lineWidth = _line_width;
    [[UIColor colorWithHexString:@"#28cafb"]set];
    [pBezier stroke];

    
}

//属性重载
-(void)setLine_width:(CGFloat)line_width{

    
    if (line_width <=0) {
        line_width = 0;
    }
    
    if ( line_width >= self.width) {
        line_width = self.width;
    }
    
    _line_width = line_width;
    
    
}

-(void)setInnerRadius:(CGFloat)innerRadius{
    
    _innerRadius = innerRadius;
    _outRadius = _line_width + _innerRadius;
}
-(void)setOutRadius:(CGFloat)outRadius{
    _outRadius = outRadius;
    _innerRadius = _outRadius - _line_width;
}
-(void)setAngle:(CGFloat)angle{
    
    _angle = angle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
