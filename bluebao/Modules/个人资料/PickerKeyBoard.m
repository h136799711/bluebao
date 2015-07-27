//
//  PickerKeyBoard.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/14.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "PickerKeyBoard.h"

@implementation PickerKeyBoard

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
    topView.frame = CGRectMake(0, 0, self.width, 35);
        topView.backgroundColor = [UIColor  whiteColor];
    [self addSubview:topView];
        [MyTool createLineInView:topView fram:CGRectMake(0, 0, topView.width, 1)];
        [MyTool createLineInView:topView fram:CGRectMake(0, topView.height-1,topView.width ,1)];
        
        
    //完成按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.bounds = CGRectMake(0, 0, 60, 30);
    CGFloat  x  =  topView.width - 10 - button.bounds.size.width/2.0;
    button.center = CGPointMake(x, topView.height /2.0);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:1] forState:UIControlStateNormal];
    [topView addSubview:button];
//    [ButtonFactory   decorateButton:button forType:BOYE_BTN_SUCCESS];
        
        
    [button addTarget:self action:@selector(buttonCloseClick) forControlEvents:UIControlEventTouchUpInside];
    
        
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
    
    
    if ([_delegate respondsToSelector:@selector(pickerKeyBoard:selectedText:)]) {
        
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
        [_delegate pickerKeyBoard:self selectedText:string];
    }
}

#pragma mark -重载delegate --
-(void)setDelegate:(id<PickerKeyBoardDelegate>)delegate{
    
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

-(void)buttonCloseClick{
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
    [self.pickerView selectRow:self.currentmumZoom-self.minimumZoom inComponent:1 animated:NO];
    
//    NSLog(@" - -%ld--   %ld -  row - %ld" ,self.minimumZoom,self.currentmumZoom, self.currentmumZoom-self.minimumZoom );
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



-(void)sendSelfFrameNotification{
    NSString  * heightString = [NSString stringWithFormat:@"%f",self.top];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //postNotificationName发送一个通知，第一个参数是通知的名字，第二个参数是通知的发送者，一般写self，第三个参数是通知的传参。
    [center postNotificationName:@"pickerKey" object:self userInfo:@{@"viewHeightInfo":heightString}];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
