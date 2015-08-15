//
//  WeekSegmentlView.h
//  bluebao
//
//  Created by boye_mac1 on 15/8/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WeekSegmentlView;

@protocol WeekSegmentlViewDelegate <NSObject>

-(void)segment:(WeekSegmentlView *) segment index:(NSInteger)index;

@end


@interface WeekSegmentlView : UIView

@property (nonatomic,assign) NSInteger       selectIndex;
@property (nonatomic,assign) id<WeekSegmentlViewDelegate> delegate;

@end