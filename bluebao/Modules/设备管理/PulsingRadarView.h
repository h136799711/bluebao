//
//  PulsingRadarView.h
//  Bluetooth
//
//  Created by hebidu on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PulsingRadarView : UIView

@property (nonatomic)CGFloat radarWidth;
@property (nonatomic)CGFloat radarHeight;

-(void)stopAnimate;

-(void)startAnimate;

-(void)reset;
@end
