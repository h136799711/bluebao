//
//  GoalPickerView.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/17.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "GoalPickerView.h"
#import "GoalVC.h"

@interface GoalPickerView (){
    
    NSInteger              _currentRow;
    NSInteger              _currentComponent;
}



@end

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
        

        //取消按钮
        UIButton * cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancalBtn.tag = 0;
        cancalBtn.bounds = CGRectMake(0, 0, 40, 30);
        
        cancalBtn.center = CGPointMake(cancalBtn.bounds.size.width/2.0 + 10, topView.bounds.size.height /2.0);
        [cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [topView addSubview:cancalBtn];
        [cancalBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        

        //完成按钮
        UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        finishBtn.tag = 1;
        finishBtn.bounds = CGRectMake(0, 0, 40, 30);
        CGFloat  x  =  topView.bounds.size.width - 10 - finishBtn.bounds.size.width/2.0;
        finishBtn.center = CGPointMake(x, topView.height /2.0);
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [topView addSubview:finishBtn];
        [finishBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
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
    
    return 6;
}
//行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    if (component == 0) {
        
        return 24;
    } else if (component == 1){
        
        return 1;
    }else if (component == 2){
        return 60;
    }else{
        return 10;
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    if (component == 1) {
       
        return @":";
    }else if (component == 0||component == 2){
        
        NSString  *numstr = [[NSString alloc] init];
        if (row < 10) {
            numstr = [NSString stringWithFormat:@"0%ld",row];
        }else{
            numstr = [NSString stringWithFormat:@"%ld",row];
        }
        
        return  numstr;
    }else if (component == 5){
        
        return [NSString stringWithFormat:@"%ld卡",row];
    }else{
        
        return [NSString stringWithFormat:@"%ld",row];
    }

}

#pragma mark -- 选中之后  --
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    
    if (row <3) {
        self.tabrow = 0;
        self.datastr = [NSString stringWithFormat:@"%@:%@",self.goalData.hour,self.goalData.minute];
        
        
    }else{
        self.tabrow = 1;
        self.datastr = [NSString stringWithFormat:@"%ld%ld%ld",self.goalData.hundredPlace,self.goalData.tendPlace,self.goalData.digitPlace];

    }
    
    
    
    
    _currentComponent = row;
    _currentRow = component;
    
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
    self.isOpen = YES;
    
    [self sendSelfFrameNotification];
}


#pragma mark --  close  --
-(void)close{
    
    [MyTool setAnimationCentView:self
                        duration:0.15
                       pointCent:CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT + self.height/2.0 - STATUS_HEIGHT -NAV_HEIGHT)];
    self.isOpen = NO;
    [self sendSelfFrameNotification];
}



#pragma mark --  showInView  --
-(void)showInView:(UIView *)view{
    
    [view addSubview:self];
}

#pragma mark -- 完成  --

#pragma mark -- 完成  取消 --
-(void)buttonClick:(UIButton *)button{
    
    //取消
    if (button.tag == 0) {
        [self close];

        //完成
    }else{
    
        if (self.datastr == nil) {
            self.datastr = @"";
        }
        
        #pragma mark ---- 代理 ----
        if ([_delegate respondsToSelector:@selector(goalPickerView:finishRow:textInRow:)]) {
            [_delegate goalPickerView:self finishRow:self.tabrow textInRow:self.datastr];
            
        }

        [self close];
    }
    
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

-(void)setGoalData:(GoalData *)goalData{
    
    _goalData = goalData;
 
    //小时

}
#pragma mark -- 重载 数据分类 属性 --

-(void)setDataName:(NSString *)dataName{
    _dataName = dataName;
    //    NSLog(@"dataName %@",dataName);
}


-(void)sendSelfFrameNotification{
    NSString  * heightString = [NSString stringWithFormat:@"%f",self.top];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //postNotificationName发送一个通知，第一个参数是通知的名字，第二个参数是通知的发送者，一般写self，第三个参数是通知的传参。
    [center postNotificationName:@"Goalpicker" object:self userInfo:@{@"viewHeightInfo":heightString}];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
