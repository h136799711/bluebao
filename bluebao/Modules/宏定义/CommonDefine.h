//
//  CommonDefine.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#ifndef bluebao_CommonDefine_h
#define bluebao_CommonDefine_h


#define ALERTVIEW(_message_)  UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:_message_ delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];\
[alertView show];

#define ACCOUNTNum @"accountNum" //账号名
#define ACCOUNTPSW @"accountPsw"//账号密码



#endif
