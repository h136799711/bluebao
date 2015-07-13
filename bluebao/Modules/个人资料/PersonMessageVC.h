//
//  PersonMessageVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonMessageVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate >

@property (nonatomic,strong) UIButton           * headImageBtn;

@property (nonatomic,strong) UITextField           * personSignTextfield;
@end
