//
//  EngineHttpRequest.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "EngineHttpRequest.h"

@implementation EngineHttpRequest

+(void)loginGetRequtsComplete:(void(^)(BOOL successed ))complete{
    
    NSString * string  = @"";
    AFHTTPRequestOperationManager * magnage = [AFHTTPRequestOperationManager manager];
    [magnage GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            
            complete (YES);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        complete (NO);
    }];
    


}


+(void)loginPostRequstComplete:(void(^)(BOOL successed))complete{
    
    
    NSString * string  = @"";
    NSDictionary * parameter = [[NSDictionary alloc] init];
    
    AFHTTPRequestOperationManager * magnage = [AFHTTPRequestOperationManager manager];
    [magnage POST:string parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
}


@end
