//
//  PickerKeyBoard.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/14.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PickerKeyBoard;

@protocol PickerKeyBoardDelegate <NSObject>

-(void)pickerKeyBoard:(PickerKeyBoard *)picker selectedText:(NSString *)string;

@end

@interface PickerKeyBoard : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UIPickerView   * pickerView;
@property (nonatomic,strong) NSArray         * dataArray;
@property (nonatomic,assign)id <PickerKeyBoardDelegate>delegate;
-(instancetype)initWithPicker;

//父视图
-(void)showInView:(UIView *)view;

-(void)close;
-(void)open;

@end
