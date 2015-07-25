//
//  PersonMessageVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"
#import "PickerKeyBoard.h"
@interface PersonMessageVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PickerKeyBoardDelegate >


@property (nonatomic,strong) UITableView  * tableView_person;

@property (nonatomic,strong) UIButton           * headImageBtn; //头像图片
@property (nonatomic,strong) UITextField        * personSignTextfield;//个人姓名
@property (nonatomic,strong) UILabel            * signLabel;//提醒标签
//@property (nonatomic,strong) UIButton           * heightButton;//用户身高
@property (nonatomic,strong) UIButton           * sexButton;//体重
@property (nonatomic,strong) NSMutableArray     * valueArray; //值
@property (nonatomic,strong) PickerKeyBoard     * pickerKeyBoard; //pickerView
@property (nonatomic,assign) CGFloat             outHeight;
@property (nonatomic,strong) UIButton           * ageBtn; //用户年龄
@property (nonatomic,strong) UIButton           * ageImageBtn; //用户年龄

@property (nonatomic,strong) UserInfo * userInfo;
@end
