//
//  EngineHttpRequest.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EngineHttpRequest : NSObject

//请求
+(void)loginGetRequtsComplete:(void(^)(BOOL successed ))complete;
+(void)loginPostRequstComplete:(void(^)(BOOL successed))complete;


@end
