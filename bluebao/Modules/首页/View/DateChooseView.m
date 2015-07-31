//
//  DateChooseView.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/17.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "DateChooseView.h"

@interface DateChooseView (){
    
    UILabel         * dateLabel;
    NSDate          * _currentDate;
}

@end

@implementation DateChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, 190, 25);
        [self _inits];
        
    }else{
        self.frame = CGRectMake(0,0, 180, 25);
    }
    
    return self;
}

-(void)_inits{
    
    
    //左边
    UIButton  * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 25, self.bounds.size.height);
    [leftBtn setTitle:@"<" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = FONT(16);
    leftBtn.tag = 0;
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(changeDateClick:) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.backgroundColor = [UIColor blueColor];
    [self addSubview:leftBtn];
    
    
    //右边
    UIButton  * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.bounds.size.width - leftBtn.bounds.size.width, 0, leftBtn.bounds.size.width, self.bounds.size.height);
    [rightBtn setTitle:@">" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = FONT(16);
    rightBtn.tag = 1;
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(changeDateClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
//    rightBtn.backgroundColor = [UIColor blueColor];

    //日期显示
    CGFloat  widthLab = self.bounds.size.width - leftBtn.bounds.size.width - rightBtn.bounds.size.width;
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftBtn.frame.origin.x+leftBtn.bounds.size.width, 0, widthLab, self.bounds.size.height)];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = FONT(16);
    [self addSubview:dateLabel];
    
    self.newbDate = [NSDate date] ;
    _currentDate = self.newbDate;
    
    dateLabel.text =  [self getDateString: self.newbDate ];
    
}

#pragma mark -- 日期改变 --
-(void)changeDateClick:(UIButton *)button{
    

    
    int addDays =  button.tag == 0?-1:1;
  
    //再加上8个时区 8*3600
    NSDate * newDate = [self.newbDate dateByAddingTimeInterval:60 * 60 * 24 * addDays ];
    //当前时间与新时间是否是降序
    BOOL isout = [_currentDate compare:newDate] == NSOrderedAscending ;
    if (isout) {
        [SVProgressHUD showOnlyStatus:@"没有数据" withDuration:0.5];
        return;
    }

     self.newbDate= newDate;

    dateLabel.text = [self getDateString:self.newbDate];
}

-(NSString * )getDateString:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    //设置星期的文本描述
    [dateFormatter setWeekdaySymbols:@[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"]];
     [dateFormatter setDateFormat:@"yyyy-M-dd eeee"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    //代理传值
    if ([_delegate respondsToSelector:@selector(dateChooseView:datestr:)]) {
        
        [_delegate dateChooseView:self datestr:dateString];
    }
    return dateString;
}

-(void)setDelegate:(id<DateChooseViewDelegate>)delegate{
    
    _delegate = delegate;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"点击屏幕");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
