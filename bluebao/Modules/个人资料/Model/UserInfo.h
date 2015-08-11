//
//  UserInfo.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
/* 
 data =     {
 birthday = 2015;
 email = "";
 height = 120;
 idnumber = "";
 "last_login_time" = 1433570548;
 mobile = "";
 nickname = "\U7528\U6237\U6635\U79f0";
 realname = itboye;
 sex = 1;
 signature = itboye2;
 "target_weight" = "12577.00";
 uid = 1;
 "update_time" = 1437637626;
 username = "2540927273@qq.com";
 weight = "125.00";
 };
 **/



@property (nonatomic,copy)  NSString         *username;
@property (nonatomic,copy)  NSString         *nickname;
@property (nonatomic,assign)NSInteger        sex;
@property (nonatomic,copy)  NSString         * birthday;
@property (nonatomic,copy)  NSString         * email;
@property (nonatomic,copy)  NSString         * mobile;


@property (nonatomic,assign) NSInteger       uid;
@property (nonatomic,assign) NSInteger       weight;
@property (nonatomic,assign) NSInteger       height;
@property (nonatomic,assign) NSInteger       target_weight;
@property (nonatomic,assign) NSInteger       age;
@property (nonatomic,assign) NSInteger        continuous_day;


@property (nonatomic,copy)  NSString         *realname;
@property (nonatomic,copy)  NSString         *signature;
@property (nonatomic,copy)  NSString         *idnumber;
@property (nonatomic,copy)  NSString         *last_login_time;
@property (nonatomic,copy)  NSString         *update_time;


//
-(id)initWithUserInfoDictionary:(NSDictionary * )diction;
//+(id)initUserInfoDictionary:(NSDictionary *)diction;

@end
