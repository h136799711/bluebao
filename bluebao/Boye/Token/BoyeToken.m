//
//  BoyeToken.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/28.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeToken.h"

@implementation BoyeToken

+(NSString *)getAccessToken{
    return [[CacheFacade sharedCache] get:BOYE_ACCESS_TOKEN];
}

//是否存在有效token
+(BOOL)isTokenEffective{
    
    
    NSString * token = [[CacheFacade sharedCache]get:BOYE_ACCESS_TOKEN];
//    NSLog(@"token=%@",token);
    if (token == nil) {
        [SVProgressHUD showWithStatus:@" token 失效!"];
        return NO;
    }
    
    return YES;

}

//保存token 以及计算出过期的时间并保存

+(void)saveDataWithDic:(NSDictionary *)dic :(NSNumber *)questTime{
    
    NSString *access_token=[dic objectForKey:@"access_token"];
    double time=[[dic objectForKey:@"expires_in"] doubleValue];
    
    [[CacheFacade sharedCache] setObject:access_token forKey:BOYE_ACCESS_TOKEN afterTimeStamp: [NSNumber numberWithDouble:[questTime doubleValue] + time ]];
    
}


//获取有效令牌
+(void)isTokenEffectiveComplete:(void(^)(BOOL  tokenSucced))complete{
    
    if ([self isTokenEffective]) {
        
        NSLog(@"token有效");
        
        complete (YES);
        
    }else{
        
        
        BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
        NSDictionary *params = @{@"grant_type":@"client_credentials",@"client_id":@BOYE_CLIENT_ID,@"client_secret":@BOYE_CLIENT_SECRET};
        
        //
        [SVProgressHUD showWithStatus:@"请求Token" maskType:SVProgressHUDMaskTypeClear];
        
       NSNumber * questTime = [NSDate currentTimeStamp];
        
        [client post:@"Token/index"
                    :params
                    :^(AFHTTPRequestOperation *operation ,id responseObject){
                        NSString *html = operation.responseString;
                        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                        id dict=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        
                        NSDictionary *json = (NSDictionary *)dict;
                        
                        NSNumber *code = [json valueForKey:@"code"];
                        
                        NSDictionary *info = [json valueForKey:@"info"];
                        
//                        NSLog(@"请求结果  info  ：%@",info);
                        
                        
                        if ([code intValue] == 0){
                            
                            [self saveDataWithDic:info :questTime];
                            [SVProgressHUD showSuccessWithStatus:@"Token请求成功"];
                            complete (YES);
                            
                        }else{
                            
//                            NSLog(@"请求失败!%ld",(long)code);
                            complete (NO);
                            [SVProgressHUD showErrorWithStatus:@"Token请求失败"];

                        }
                    }
                    :^(AFHTTPRequestOperation *operation ,NSError *error){
//                        NSLog(@"Error: %@", error);

                        complete (NO);
                        [SVProgressHUD showSuccessWithStatus:@"Token请求失败"];

                    }];
        
    }
    
}




@end
