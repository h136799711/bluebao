//
//  HttpClient.h
//  AFNTest
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"



@interface BoyeHttpClient : NSObject


+ (void)startMonitorNetwork;
+ (void)stopMonitorNetwork;
/**
 *  获取api的地址
 *
 *  @return api的地址字符串
 */
+(NSString *)getBaseApiURL;

// Post请求
- (void)post:(NSString *)url :(NSDictionary *)withParams :(void(^)(AFHTTPRequestOperation *operation ,id responseObject))success :(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// GET请求
- (void)get:(NSString *)urlWithParams :(void (^)(AFHTTPRequestOperation *operation ,id responseObject))success :(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//图片上传
-(void)upload:(NSString*)url withParams:(NSDictionary *)withParams :(NSString *)filePath :(void (^)(AFHTTPRequestOperation *operation ,id responseObject))success :(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)downloadTask:(NSString *)url;

@end
