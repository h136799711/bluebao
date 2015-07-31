//
//  MainViewController.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfo.h"
#import "LetfView.h"

@interface MainViewController : BaseViewController<LetfViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UserInfo * userInfo;
@property (nonatomic,assign) BOOL       isOpen;
@property (nonatomic,strong)   LetfView          *leftView;



+ (MainViewController*)sharedSliderController;


//close
-(void)moveLeft;
//open
-(void)moveRight;

@end
