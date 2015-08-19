//
//  PulsingRadarView.m
//  Bluetooth
//
//  Created by hebidu on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "PulsingRadarView.h"



@interface PulsingRadarView ()

@property (nonatomic) BOOL isAnimating;
@property (nonatomic) CGRect cacheRect;

@property (nonatomic) CGFloat lineWidth;

@property (nonatomic) int currentPulsingIndex;

@property (nonatomic,weak) NSTimer * timer;

@end

@implementation PulsingRadarView

static const CGFloat PI = 3.1415926;

static const int pulsingCount = 3;


-(void)didMoveToWindow{
//    DLog(@"MoveToWindow");
}
-(void)didMoveToSuperview{
    self.isAnimating = NO;
    self.currentPulsingIndex = -1;
//    DLog(@"didMoveToSuperview");
}
-(void)reset{
    self.isAnimating = NO;
    self.currentPulsingIndex = -1;
    
    if(self.timer  != nil){
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [self setNeedsDisplay];
}
-(void)stopAnimate{
    DLog(@"停止动画");
    self.isAnimating = NO;
    self.currentPulsingIndex = -1;
    
    if(self.timer  != nil){
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

-(void)startAnimate{
    DLog(@"开始动画");
    if(self.isAnimating == NO && self.timer == nil){
        
        self.isAnimating = YES;
        self.currentPulsingIndex = -1;
        NSTimeInterval  interval = 0.8;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(loopAnimating) userInfo:nil repeats:YES];
        
        DLog(@"当前是否播放动画s %d",self.isAnimating);
        
    }else{
        //在播放动画中 调用了开始动画则先结束动画，再调用
//        [self stopAnimate];
//        [self startAnimate];
        
    }
    
}

-(void)loopAnimating{
    [self setNeedsDisplay];
    
    if (!self.isAnimating) {
        return;
    }
    
    self.currentPulsingIndex++;
    if(self.currentPulsingIndex >= pulsingCount){
        self.currentPulsingIndex = 0;
    }
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    DLog(@"drawRect..%@",context);
    if(context == nil){
        return;
    }
    
    UIColor * bgColor = [UIColor colorWithRed:(248/255.0) green:(248/255.0) blue:(248/255.0) alpha:1];
    
    [bgColor setFill];
    UIRectFill(rect);
    self.cacheRect = rect;
    
    UIView *superview =  self.superview;
    CGFloat radius = 30;
    CGPoint start = CGPointMake((superview.frame.size.width - self.radarWidth)/2,(superview.frame.size.height-self.radarHeight)/2+8);
    
    CGContextSetLineWidth(context, 15.0);
    CGContextSetLineCap(context, kCGLineCapRound );
//    DLog(@"当前激活的index %d",self.currentPulsingIndex);
    
    //画弧线
    for (int i=0; i<pulsingCount; i++) {
        if (self.isAnimating && i == self.currentPulsingIndex) {
            CGContextSetRGBStrokeColor(context, 144/255.0,144/255.0 ,144/255.0 ,0.6);
        }else{
            CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);//画笔颜色
        }
        //左
        CGContextAddArc(context, start.x-5, start.y, radius + (i*25),130*PI/180, 230*PI/180, 0); //添加一个圆
        CGContextStrokePath(context);//绘画路径
            
        //右
        CGContextAddArc(context, start.x+5, start.y, radius+ (i*25),-50*PI/180, 50*PI/180, 0); //添加一个圆
        CGContextStrokePath(context);//绘画路径

    }
    
}

 //Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    DLog(@"%d",self.isAnimating);
//    
//    if (!self.isAnimating) {
//        return;
//    }
//    
////    DLog(@"rect= %f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
//    
//    [[UIColor whiteColor] setFill];
//    
//    UIView *superview =  self.superview;
////    if(superview !=nil){
//    
////        DLog(@"superview.frame= %f,%f,%f,%f",superview.frame.origin.x,superview.frame.origin.y,superview.frame.size.width,superview.frame.size.height);
////    }
//    
////    UIRectFill(rect);
//    
//    
//    CALayer *animationLayer =  [[CALayer alloc]init];
//    
//    for (int i=0; i<pulsingCount; i++) {
//        CALayer *pulsingLayer = [[CALayer alloc]init];
//        
//        pulsingLayer.frame = CGRectMake(superview.frame.size.width/2-self.radarWidth/2,superview.frame.size.height/2-self.radarHeight/2,self.radarWidth,self.radarHeight);
//        
//        pulsingLayer.borderColor = [[UIColor orangeColor] CGColor];
//        
//        pulsingLayer.borderWidth = 5;
//        
//        pulsingLayer.cornerRadius = self.radarWidth/2;
//        // rect.size.height / 4;
//        
//        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//        
//        CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
//        
//        animationGroup.fillMode = kCAFillModeBackwards;
//        
//        animationGroup.beginTime = CACurrentMediaTime() + (double)(i) * animationDuration / (double)(pulsingCount);
//        
//        animationGroup.duration = animationDuration;
//        
//        animationGroup.repeatCount = HUGE;
//        
//        animationGroup.timingFunction = defaultCurve;
//        
//        CABasicAnimation *  scaleAnimation =  [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        
//        
//        scaleAnimation.autoreverses = false;
//        
//        scaleAnimation.fromValue = 0;
//        scaleAnimation.toValue = [NSNumber numberWithFloat:5];
//        
//        
//        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
//    
//        opacityAnimation.values = @[@1,@0.7,@0];
//        
//        opacityAnimation.keyTimes = @[@0,@0.5,@1];
//        
//        animationGroup.animations = @[scaleAnimation,opacityAnimation];
//        
//        [pulsingLayer addAnimation:animationGroup forKey:@"pulsing"];
//        
//        [animationLayer addSublayer:pulsingLayer];
//        
//    }
//    [self.layer addSublayer:animationLayer];
//    [self setNeedsDisplay];
//}


@end
