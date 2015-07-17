//
//  GoalPickerView.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/17.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "GoalPickerView.h"

@implementation GoalPickerView



-(instancetype)initWithPicker{
    
    self = [super init];
    if (self) {
        
        
        [self _initViews];
    }
    return self;
}

//
-(void)_initViews{
    
    if (self.pickerView == nil) {
        //视图
        self.backgroundColor = [UIColor lightGrayColor];
        self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 240);
        self.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT + self.height/2.0 - STATUS_HEIGHT -NAV_HEIGHT );
        
        //顶部黑条
        UIView * topView = [[UIView alloc] init];
        topView.frame = CGRectMake(0, 0, self.width, 30);
        topView.backgroundColor = [UIColor blackColor];
        [self addSubview:topView];
        
        //完成按钮
        UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        finishBtn.tag = 1;
        finishBtn.bounds = CGRectMake(0, 0, 40, 30);
        CGFloat  x  =  topView.bounds.size.width - 10 - finishBtn.bounds.size.width/2.0;
        finishBtn.center = CGPointMake(x, topView.height /2.0);
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [topView addSubview:finishBtn];
        [finishBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
        //取消按钮
        UIButton * cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancalBtn.tag = 0;
        cancalBtn.bounds = CGRectMake(0, 0, 40, 30);
      
        cancalBtn.center = CGPointMake(cancalBtn.bounds.size.width/2.0 + 10, topView.bounds.size.height /2.0);
        [cancalBtn setTitle:@"完成" forState:UIControlStateNormal];
        [cancalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [topView addSubview:cancalBtn];
        [cancalBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        

        
        
        
        
        
        
        //底部
        UIView * downView = [[UIView alloc] init];
        downView.frame = CGRectMake(0, topView.bottom, topView.width, self.height-topView.height);
        [self addSubview:downView];
        
#pragma mark -- PickView
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [downView addSubview: self.pickerView];
    }
    
}



#pragma mark --- pickView --

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return 1;
    }
    
    if (self.maximumZoom < self.minimumZoom ) {
        
        return 0;
    }
    return self.maximumZoom -self.minimumZoom+1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return self.dataName;
    }else{
        
        int count = (int )(self.maximumZoom - self.minimumZoom +1);
        
        NSString * unitstring = @"";
        for (int i = 0; i < count; i ++) {
            
            int num = (int )self.minimumZoom + i;
            
            unitstring  = [NSString stringWithFormat:@"%d%@",num,self.dataUnit];
            
            if (i ==row) {
                break;
            }
            
        }
        
        return unitstring;
        
    }
}

#pragma mark -- 选中之后  --
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    if ([_delegate respondsToSelector:@selector(goalPickerView:selectedText:)]) {
        
        NSString * string = @"";
        if (component == 0) {
            //名称
            string = self.dataName;
            
            return;
            
        }else{
            self.currentmumZoom = self.minimumZoom + row;
            
            //当前值含单位
            string = [NSString stringWithFormat:@"%d%@",(int)self.currentmumZoom,self.dataUnit];
        }
        [_delegate goalPickerView:self selectedText:string];
    }
    
    // NSLog(@"%@, %@",self.dataName,self.dataUnit);
}

#pragma mark -重载delegate --
-(void)setDelegate:(id<GoalPickerViewDelegate>)delegate{
    
    _delegate = delegate;
}
#pragma mark -- 重载NSArray

-(void)setDataArray:(NSArray *)dataArray{
    
    self.dataArray = dataArray;
    [self.pickerView reloadAllComponents];
    
}

#pragma mark --  open  --
-(void)open{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - self.height/2.0 - STATUS_HEIGHT -NAV_HEIGHT);
    [UIView commitAnimations];
}


#pragma mark --  close  --
-(void)close{
    
    [MyTool setAnimationCentView:self
                        duration:0.15
                       pointCent:CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT + self.height/2.0 - STATUS_HEIGHT -NAV_HEIGHT)];
    
}



#pragma mark --  showInView  --
-(void)showInView:(UIView *)view{
    
    [view addSubview:self];
}

#pragma mark -- 完成  --
-(void)buttonClick{
    
    [self close];
}



#pragma mark -- 重载 min 属性 --
-(void)setMinimumZoom:(NSInteger)minimumZoom{
    
    _minimumZoom = minimumZoom;
}
#pragma mark -- 重载 max 属性 --
-(void)setMaximumZoom:(NSInteger)maximumZoom{
    _maximumZoom = maximumZoom;
    
}
#pragma mark -- 重载 curren数值 属性 --
-(void)setCurrentmumZoom:(NSInteger)currentmumZoom{
    _currentmumZoom = currentmumZoom;
    if (_currentmumZoom < self.minimumZoom) {
        _currentmumZoom = self.minimumZoom;
    }
    [self.pickerView selectRow:_currentmumZoom-self.minimumZoom inComponent:1 animated:NO];
}
#pragma mark -- 重载 数据单位 属性 --

-(void)setDataUnit:(NSString *)dataUnit{
    
    _dataUnit = dataUnit;
}

#pragma mark -- 重载 数据分类 属性 --

-(void)setDataName:(NSString *)dataName{
    _dataName = dataName;
    //    NSLog(@"dataName %@",dataName);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
