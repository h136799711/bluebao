//
//  RegistVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistVC : BaseViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;

@property (weak, nonatomic) IBOutlet UITextField *textfield_LeterBox;
@property (weak, nonatomic) IBOutlet UITextField *textfield_newpsw;
@property (weak, nonatomic) IBOutlet UITextField *textfield_confirmpsw;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;

//方法
- (IBAction)agree:(UIButton *)sender;



@end
