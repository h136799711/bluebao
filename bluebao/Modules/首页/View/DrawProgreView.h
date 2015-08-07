//
//  DrawProgreView.h
//  DrawCircle
//
//  Created by Mac on 15-7-19.
//  Copyright (c) 2015年 WZG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrawProgreView;

@protocol DrawProgreViewDelegate <NSObject>

-(void)drawProgreView:(DrawProgreView *)drawProgreView;

@end


@interface DrawProgreView : UIView
@property (nonatomic,assign)CGFloat     goalNum;  //目标
@property (nonatomic,assign)CGFloat     finishNum;//完成数量

//展示园
-(void) showCircleView;
//创建 cirele
-(void)creatCiecleView;
//清除 cirele
-(void)removeCircleView;

@end
