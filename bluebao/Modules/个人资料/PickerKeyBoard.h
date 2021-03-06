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

@property (nonatomic,strong) UIPickerView       * pickerView;
@property (nonatomic,strong) NSArray            * dataArray;
@property (nonatomic,copy) NSString             * dataUnit; //数据单位
@property (nonatomic,copy) NSString             * dataName; // 数据名称
@property (nonatomic,assign) NSInteger          minimumZoom;//最小数量
@property (nonatomic,assign) NSInteger          maximumZoom;//最大数量
@property (nonatomic,assign) NSInteger          currentmumZoom; //当前数量
@property (nonatomic,assign) BOOL               isOpen;


@property (nonatomic,assign)id <PickerKeyBoardDelegate>delegate;
-(instancetype)initWithPicker;

//父视图
-(void)showInView:(UIView *)view;

-(void)close;
-(void)open;

@end
