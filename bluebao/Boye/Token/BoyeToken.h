//
//  BoyeToken.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/28.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoyeToken : NSObject


//是否存在有效token
+(BOOL)isTokenEffective;

//获取有效令牌

+(void)isTokenEffectiveComplete:(void(^)(BOOL  tokenSucced))complete;

+(NSString *)getAccessToken;
@end
