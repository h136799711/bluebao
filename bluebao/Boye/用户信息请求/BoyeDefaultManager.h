//
//  BoyeDefaultManager.h
//  AFNTest
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserUpdataReqModel.h"

@interface BoyeDefaultManager : NSObject

+ (NSDateFormatter *)getDateFormatter:(NSString *)format;


//用户登录接口
//+(void)requestLoginUser:(User *)user complete:(void (^)(BOOL succed))complete;

+(void)requestLoginUser:(User *)user complete:(void (^)(UserInfo * userInfo))complete;

//用户注册接口
+(void)requestRegisterUser:(User *)user complete:(void(^)(BOOL succed))complete;


//用户信息接口
+(void)requestUserInfoUpdata:(UserUpdataReqModel *)userUpdata complete:(void(^)(BOOL succed))complete;

@end
