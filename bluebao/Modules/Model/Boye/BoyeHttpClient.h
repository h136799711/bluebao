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


// Post请求
- (void)post:(NSString *)url :(NSDictionary *)withParams :(void(^)(id responseObject))success :(void(^)(NSError* error))failure;

// GET请求
- (void)get:(NSString *)urlWithParams :(void (^)(AFHTTPRequestOperation *operation ,id responseObject))success :(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)downloadTask:(NSString *)url;

@end
