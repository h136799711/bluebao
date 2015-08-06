//
//  LoginVC.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/6.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : BaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *accontNumView;

@property (weak, nonatomic) IBOutlet UITextField *accontNumTextfield;
@property (weak, nonatomic) IBOutlet UIView *pswView;
@property (weak, nonatomic) IBOutlet UITextField *pswTextfield;

@property (weak, nonatomic) IBOutlet UIButton *remberCodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *label_remberCode;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;



+ (LoginVC*)sharedSliderController;
- (IBAction)login:(UIButton *)sender;
- (IBAction)rememberCodeClick:(UIButton *)sender;
- (IBAction)forgetCodeBtnClick:(UIButton *)sender;

@end
