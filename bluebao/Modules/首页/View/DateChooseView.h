//
//  DateChooseView.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/17.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateChooseView;
@protocol DateChooseViewDelegate  <NSObject>

-(void)dateChooseView:(DateChooseView *)dateChooseView datestr:(NSString *)datestr;

@end

@interface DateChooseView : UIView
@property (nonatomic,strong) NSDate   * newbDate;
@property (nonatomic,strong) NSDate   * nowDayDate;
@property (nonatomic,assign) id<DateChooseViewDelegate>delegate;

@end
