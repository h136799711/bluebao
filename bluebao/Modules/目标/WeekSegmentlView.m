//
//  WeekSegmentlView.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "WeekSegmentlView.h"

@interface WeekSegmentlView (){
    NSArray * array ;
    NSMutableArray * btnArray;

}

@end
@implementation WeekSegmentlView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        array = [[NSArray alloc]initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
        [self _initViews];
        
    }
    return self;

}

-(void)_initViews{
    
    btnArray = [[NSMutableArray alloc] initWithCapacity:7];
    
    CGFloat  width = self.bounds.size.width/array.count;
    for (int i = 0 ; i < array.count; i ++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(width * i,0  , width , self.frame.size.height - 3);
        
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#949494"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

        btn.titleLabel.font  = FONT(15);
        btn.tag = i;
        
        [btnArray addObject:btn];
        
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(btn.frame.origin.x, btn.frame.size.height, width, 2);
        label.backgroundColor = [UIColor lightGrayColor];
        label.tag = i +1;
        [self addSubview:label];
        
        if (i == 0) {
            [self btnClick:btn];
        }
    }
}

-(void)btnClick:(UIButton *)btn{
    self.selectIndex = btn.tag;

    
    [self changeSelectedIndex:btn.tag];
    
    if ([_delegate respondsToSelector:@selector(segment:index:)]) {
        [_delegate segment:self index:btn.tag];
    }
    
}
-(void)setDelegate:(id<WeekSegmentlViewDelegate>)delegate{
    
    _delegate = delegate;
    
}
-(void)setSelectIndex:(NSInteger)selectIndex{
    
    _selectIndex = selectIndex;
    
    [self changeSelectedIndex:_selectIndex];
}

-(void) changeSelectedIndex:(NSInteger) index{
    for (int i = 0 ; i < btnArray.count; i ++) {
        UIButton * button = btnArray[i];
        UILabel * label = (UILabel *)[self viewWithTag:button.tag +1];
        
        if (button.tag == index) {
            button.selected = YES;
            label.backgroundColor = [UIColor colorWithHexString:@"#74e7f8"];;
        }else{
            
            button.selected = NO;
            label.backgroundColor = [UIColor colorWithHexString:@"#949494"];
        }
    }
 
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
