//
//  BoyeConnectView.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoyeConnectView;
@protocol BoyeConnectViewDelegate <NSObject>

-(void)BoyeConnectViewconnected:(BoyeConnectView *)BoyeConnectView;

@end
 

@interface BoyeConnectView : UIView


@property (nonatomic,assign) id <BoyeConnectViewDelegate>delegate;


@end
