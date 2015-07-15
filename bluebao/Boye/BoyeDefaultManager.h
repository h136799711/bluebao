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

//是否需要登录
+(BOOL)isNeedLogin;

//用户登录接口
+(void)requestLoginUser:(UserInfo *)user complete:(void (^)(BOOL succed))complete;



@end
