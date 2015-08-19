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
//      
//    if (self.isConnect) {
//    
//        DLog(@"连接");
//        [SVProgressHUD showOnlyStatus:connArr[1] withDuration:0.5];
//        return;
//    }
//    
    
    LNowDevice * device = [BoyeBluetooth sharedBoyeBluetooth].connectedDevice;
    if (device == nil) {
        DLog(@"device is nil");

                
        [[MainViewController sharedSliderController].leftView jumpToequipmentManager];

    }else{
      
        if (device.state == CBPeripheralStateDisconnected ) {
            [[MainViewController sharedSliderController].leftView jumpToequipmentManager];

            return;
        }
        
    }
}


-(void)setDelegate:(id<BoyeConnectViewDelegate>)delegate{
    
    _delegate = delegate;
}

-(void)setIsConnect:(BOOL)isConnect{
    
    _isConnect = isConnect;
    
    self.connectStateLabel.text = connArr[_isConnect];
  
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
