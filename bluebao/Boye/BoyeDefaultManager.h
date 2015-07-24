//
//  BoyeDefaultManager.h
//  AFNTest
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoyeDefaultManager : NSObject

+ (NSDateFormatter *)getDateFormatter:(NSString *)format;

//是否存在有效token
+(BOOL)isTokenEffective;

//是否过期
+(BOOL)isDateOut;

//token是否存在
+(BOOL) isTokenExist;


//获取令牌
+(void)requtstAccessTokenComplete:(void(^)(BOOL  succed))complete;


//用户登录接口
+(void)requestLoginUser:(User *)user complete:(void (^)(BOOL succed))complete;


//用户注册接口
+(void)requestRegisterUser:(User *)user complete:(void(^)(BOOL succed))complete;


//用户信息接口
+(void)requestUserInfoUpdata:(UserInfo *)userInfo complete:(void(^)(BOOL succed))complete;

@end
