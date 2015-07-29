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
    
    NSInteger              _hour;
    NSInteger              _minute;
    NSInteger              _hundre;
    NSInteger              _ten;
    NSInteger              _digit;
}



@end

@implementation GoalPickerView



-(instancetype)initWithPicker{
    
    self = [super init];
    if (self) {
        
        _hour = 0;
        _minute = 0;
        _hundre = 0;
        _ten = 0;
        _digit = 0;
        
        
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
        topView.frame = CGRectMake(0, 0, self.width, 35);
        topView.backgroundColor = [UIColor  whiteColor];
        [self addSubview:topView];
        [MyTool createLineInView:topView fram:CGRectMake(0, 0, topView.width, 1)];
        [MyTool createLineInView:topView fram:CGRectMake(0, topView.height-1,topView.width ,1)];
        [self addSubview:topView];


        //取消按钮
        UIButton * cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancalBtn.tag = 0;
        cancalBtn.bounds = CGRectMake(0, 0, 40, 30);
        
        cancalBtn.center = CGPointMake(cancalBtn.bounds.size.width/2.0 + 10, topView.bounds.size.height /2.0);
        [cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [cancalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancalBtn setTitleColor:[UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:1] forState:UIControlStateNormal];

        [topView addSubview:cancalBtn];
        [cancalBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        

        //完成按钮
        UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        finishBtn.tag = 1;
        finishBtn.bounds = CGRectMake(0, 0, 40, 30);
        CGFloat  x  =  topView.bounds.size.width - 10 - finishBtn.bounds.size.width/2.0;
        finishBtn.center = CGPointMake(x, topView.height /2.0);
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
//        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn setTitleColor:[UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:1] forState:UIControlStateNormal];

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
        self.pickerView.backgroundColor = [UIColor whiteColor];
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
        
        NSString  *numstr = [self getDateString:row];
        return  numstr;
    }else if (component == 5){
        
        return [NSString stringWithFormat:@"%ld卡",row];
    }else{
        
        return [self getNumberString:row];
    }

}

#pragma mark -- 选中之后  --
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    
    switch (component) {
        case 0:
            _hour = row;
            break;
            
        case 2:
            _minute = row;
            break;
            
        case 3:
            _hundre = row;
            break;
            
        case 4:
            _ten= row;
            break;
            
        case 5:
            _digit = row;
            break;
            
        default:
            break;
    }
    
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
    

        #pragma mark ---- 代理 ----
        NSString * timestr = [NSString stringWithFormat:@"%@:%@",[self getDateString:_hour],[self getDateString:_minute]];
        NSInteger  goalnum = [[NSString stringWithFormat:@"%ld%ld%ld",_hundre,_ten,_digit] integerValue];

        //先响应代理，再close
        
        if ([_delegate respondsToSelector:@selector(goalPickerView:dateString:goalNumber:)]) {
            [_delegate goalPickerView:self dateString:timestr goalNumber:goalnum];
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
    
//    NSLog(@"  ---picker top - %@--",heightString);
    [center postNotificationName:@"Goalpicker" object:self userInfo:@{@"goalViewHeightInfo":heightString}];
}

#pragma mark -- 转化为字符串  01- 09 - 24 - 60
-(NSString *) getDateString:(NSInteger)num{
    
    NSString  *numstr = [[NSString alloc] init];
    if (num < 10) {
        numstr = [NSString stringWithFormat:@"0%ld",num];
    }else{
        
        numstr = [NSString stringWithFormat:@"%ld",num];
    }
    
    return numstr;
}

//数值转化为字符串
-(NSString *) getNumberString:(NSInteger)num{
    
    NSString * numstr = [NSString stringWithFormat:@"%ld",num];
    return numstr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
