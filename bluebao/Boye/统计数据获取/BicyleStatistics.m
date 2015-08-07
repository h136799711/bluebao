//
//  BicyleStatistics.m
//  bluebao
//
//  Created by hebidu on 15/8/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BicyleStatistics.h"

@implementation BicyleStatistics

+(void) queryBestResult:(NSNumber *)uid :(void(^)(id ))success :(void(^)(NSString * ))failure;{
    
    [BoyeToken isTokenEffectiveComplete:^(BOOL result){
       
        if (result) {
            
            BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
            
            NSString * postUrl = [NSString stringWithFormat: @"Bicyle/bestResult?access_token=%@", [BoyeToken getAccessToken] ];
            
            NSDictionary * params = NSDictionaryOfVariableBindings(uid);
            
            [client post:postUrl :params :^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"%@",responseObject);
                
                NSDictionary * result = nil;
                
                if([responseObject isKindOfClass:[NSDictionary class]]){
                    result = (NSDictionary *)responseObject;
                }
                NSNumber * code =  [result objectForKey:@"code"];
                
                NSDictionary * data = [result objectForKey:@"data"];
                if([code integerValue] == 0){
                    
                    success(data);
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:@"查询失败!" withDuration:3];
                }
                
            } :^(AFHTTPRequestOperation *operation, NSError *error) {
                if(failure != nil){
                    failure(error.description);
                }else{
                    [SVProgressHUD showErrorWithStatus:@"获取失败!" withDuration:3];
                }
            } ];
            
        }
        
    }];
    
}



+(void) queryTotalResult:(NSNumber *)uid :(void(^)(id ))success :(void(^)(NSString * ))failure;{
    
    [BoyeToken isTokenEffectiveComplete:^(BOOL result){
        
        if (result) {
            
            BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
            
            NSString * postUrl = [NSString stringWithFormat: @"Bicyle/total?access_token=%@", [BoyeToken getAccessToken] ];
            
            NSDictionary * params = NSDictionaryOfVariableBindings(uid);
            
            [client post:postUrl :params :^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"%@",responseObject);
                
                NSDictionary * result = nil;
                
                if([responseObject isKindOfClass:[NSDictionary class]]){
                    result = (NSDictionary *)responseObject;
                }
                NSNumber * code =  [result objectForKey:@"code"];
                
                NSDictionary * data = [result objectForKey:@"data"];
                if([code integerValue] == 0){
                    
                    success(data);
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:@"查询失败!" withDuration:3];
                }
                
            } :^(AFHTTPRequestOperation *operation, NSError *error) {
                if(failure != nil){
                    failure(error.description);
                }else{
                    [SVProgressHUD showErrorWithStatus:@"获取失败!" withDuration:3];
                }
            } ];
            
        }
        
    }];
    
}


@end
