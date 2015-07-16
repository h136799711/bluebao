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
    topView.frame = CGRectMake(0, 0, self.width, 30);
    topView.backgroundColor = [UIColor blackColor];
    [self addSubview:topView];
    
    //完成按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.bounds = CGRectMake(0, 0, 40, 30);
    CGFloat  x  =  topView.width - 10 - button.bounds.size.width/2.0;
    button.center = CGPointMake(x, topView.height /2.0);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topView addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
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
    return self.maximumZoom -self.minimumZoom+1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        if (self.dataName == nil) {
            self.dataName = @"";
        }
        return self.dataName;
    }else{
        
        int count = (int )(self.maximumZoom - self.minimumZoom +1);
        
         NSString * unitstring = @"";
        for (int i = 0; i < count; i ++) {
            
            int num = (int )self.minimumZoom + count;
            
           unitstring  = [NSString stringWithFormat:@"%d %@",num,self.dataUnit];
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
            string = self.dataName;
        }else{
            string = self.dataUnit;
        }
        [_delegate pickerKeyBoard:self selectedText:string];
    }

    NSLog(@"%@, %@",self.dataName,self.dataUnit);
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
//    [self.pickerView reloadAllComponents];
}
#pragma mark -- 重载 max 属性 --
-(void)setMaximumZoom:(NSInteger)maximumZoom{
    _maximumZoom = maximumZoom;
//    [self.pickerView reloadAllComponents];
    
}
#pragma mark -- 重载 curren数值 属性 --
-(void)setCurrentmumZoom:(NSInteger)currentmumZoom{
    _currentmumZoom = currentmumZoom;
//    [self.pickerView reloadAllComponents];
    
}
#pragma mark -- 重载 数据单位 属性 --

-(void)setDataUnit:(NSString *)dataUnit{

    _dataUnit = dataUnit;
//    [self.pickerView reloadAllComponents];
}

#pragma mark -- 重载 数据分类 属性 --
-(void)setDataName:(NSString *)dataName{
    _dataUnit = dataName;
//    [self.pickerView reloadAllComponents];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
