//
//  CommonDefine.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#ifndef bluebao_CommonDefine_h
#define bluebao_CommonDefine_h

//#import "BicyleReqModel.h"
//#import "BicyleRespModel.h"




#define ALERTVIEW(_message_)  UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:_message_ delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];\
[alertView show];

#define BOYE_USER_NAME @"boye_user_name" //账号名
#define BOYE_USER_PSW @"boye_user_psw"//账号密码

//何必都测试请求口令
//#define BOYE_CLIENT_ID "by55c45a981b1101"
//#define BOYE_CLIENT_SECRET "8153f22f12c2b37755c555e2048cbccc"
//请求口令
#define BOYE_CLIENT_ID "by559a8de1c325c1"
#define BOYE_CLIENT_SECRET "aedd16f80c192661016eebe3ac35a6e7"

#define BOYE_ACCESS_TOKEN  @"access_token"  //token

#define BOYE_EQUIPMENT_UUID @"boye_equipment_uuid"  //设备UUID

#define BOYE_TODAY_TARGET_CALORIE @"today_target_calorie" //今天目标卡路里

//#define BOYE_CODEKEY @""
#define BOYE_ENDTIME @"endTime"             //到期时间
#define BOYE_USER_HEIGHT @"user_height"     //用户身高
#define BOYE_USER_WEIGHT @"user_weight"     //用户体重
#define BOYE_USER_AGE @"user_age"           //用年龄
#define DEFAULT_GOAL 500 //默认的目标值


// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define UMENG_APP_KEY                              "55c2b2e667e58e2950003a3e"
#define UMENG_APP_MASTER_SECRET    "yuo6aflppz9rwmbvh5z8sfsfoa05lz4u"


#endif
