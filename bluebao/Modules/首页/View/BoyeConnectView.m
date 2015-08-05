//
//  BoyeConnectView.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeConnectView.h"

@interface BoyeConnectView (){
    
    NSArray   * connArr;
}

@property (nonatomic,strong) UILabel    * connectStateLabel;
@property (nonatomic,assign) BOOL       isConnect;

@end

@implementation BoyeConnectView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    self.width = 160;
    if (self) {
     
        
        connArr = @[@"没有连接设备",@"已连接"];
        [self _initViews];
        [self initNotification];
    }
    return self;
}

// 初始化 --
-(void)_initViews{
    
    //连接状态
    self.connectStateLabel = [[UILabel alloc] init];
    self.connectStateLabel.bounds = CGRectMake(0, 0, 100, self.height);
    self.connectStateLabel.textAlignment = NSTextAlignmentCenter;
    self.connectStateLabel.center = CGPointMake(10 + self.connectStateLabel.width/2.0, self.height/2.0);
    self.connectStateLabel.textColor = [UIColor blackColor];
    self.connectStateLabel.font = FONT(14);
    self.connectStateLabel.text = connArr[0];
    [self  addSubview:self.connectStateLabel];
    
    //连接按钮
    UIButton * connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    connectBtn.bounds = CGRectMake(0, 0, 30, 30);
    connectBtn.center = CGPointMake(self.connectStateLabel.right + connectBtn.width/2.0, self.connectStateLabel.center.y);
    [connectBtn setBackgroundImage:[UIImage imageNamed:@"connectImae.png"] forState:UIControlStateNormal];
    [connectBtn setBackgroundImage:[UIImage imageNamed:@"connectImae.png"] forState:UIControlStateHighlighted];
//    connectBtn.backgroundColor = [UIColor redColor];
    [connectBtn addTarget:self action:@selector(connectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:connectBtn];
    
}

#pragma  mark -- 连接 ---
-(void)connectClick:(UIButton * )connBtn{
    
    
    //如果已经连接
    if ([self.connectStateLabel.text isEqualToString:connArr[1]]) {
        [SVProgressHUD showOnlyStatus:connArr[1] withDuration:0.5];
        return;
    }
    
//    self.isConnect = !self.isConnect;
//    connBtn.selected = !connBtn.selected;
//    
//    //已连接
//    if (self.isConnect) {
//        
//
//
//        self.connectStateLabel.text = connArr[connBtn.selected];
//
//    }else{
//        [SVProgressHUD showOnlyStatus:connArr[0] withDuration:0.5];
//    }
//    
    
    NSLog(@"连接");
    

    LNowDevice * device = [BoyeBluetooth sharedBoyeBluetooth].connectedDevice;
    if (device == nil) {
        NSLog(@"device is nil");
    }else{
        
        
        [[MainViewController sharedSliderController].leftView jumpToequipmentManager];

    }
    
}


-(void)setDelegate:(id<BoyeConnectViewDelegate>)delegate{
    
    _delegate = delegate;
}

-(void)initNotification{
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
