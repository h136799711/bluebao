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
    NSLog(@"token=%@",token);
    if (token == nil) {
        [SVProgressHUD showWithStatus:@" token 失效!"];
        return NO;
    }
    
    return YES;

    
//    if ([self isTokenExist]) {
//        
//        if ([self isDateOut]) {
//            
//            // ALERTVIEW(@"token过期");
//            [SVProgressHUD showWithStatus:@"token过期"];
//            return NO;
//        }
//        return YES;
//    }else{
//        
//        // ALERTVIEW(@"token不存在");
//        [SVProgressHUD showWithStatus:@"token不存在"];
//
//        return NO;
//    }
}

//是否过期
//+(BOOL)isDateOut{
//    
//    NSDate *end_date=[[NSUserDefaults standardUserDefaults]  objectForKey:BOYE_ENDTIME];
//    NSDate *now_date=[NSDate date];
//    
//    //    NSLog(@" \r *** nowDate: %@   \r  ***  endDate:%@",now_date,end_date);
//    BOOL isOut = [now_date compare:end_date]==NSOrderedAscending;
//    
//    //    NSLog(@" \r *** is out  %d  ",isOut);
//    return !isOut;
//    
//    //return YES;
//}

////token是否存在
//+(BOOL) isTokenExist{
//    
////    NSString * token = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
//    
//    NSString * token = [[CacheFacade sharedCache]get:BOYE_ACCESS_TOKEN];
//    
//    if (token == nil) {
//        return NO;
//    }
//    
//    return YES;
//}



//日期
//+(NSDateFormatter *)getDateFormatter:(NSString *)format{
//    
//    
//    if(format == nil){
//        format = @"yyyy-MM-dd HH:mm:ss";
//    }
//    
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:format];
//    
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    
//    [formatter setTimeZone:timeZone];
//    
//    return formatter;
//}



//保存token 以及计算出过期的时间并保存

+(void)saveDataWithDic:(NSDictionary *)dic :(NSNumber *)questTime{
    
    NSString *access_token=[dic objectForKey:@"access_token"];
    double time=[[dic objectForKey:@"expires_in"] doubleValue];
    
    [[CacheFacade sharedCache] setObject:access_token forKey:BOYE_ACCESS_TOKEN WithExpireTime: [NSNumber numberWithDouble:[questTime doubleValue] + time ]];
    
    //计算出距离当前日期 长度为time的日期
//    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:time];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:BOYE_ACCESS_TOKEN];
//    [[NSUserDefaults standardUserDefaults] setObject:date forKey:BOYE_ENDTIME];
//    
//    [[NSUserDefaults standardUserDefaults] synchronize];
    //    NSLog(@" token   - =%@",[USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN]);
    
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
                        
                        NSLog(@"请求成功!%fl",[code floatValue]);
                        NSLog(@"请求结果  info  ：%@",info);
                        
                        
                        if ([code intValue] == 0){
                            
                            [self saveDataWithDic:info :questTime];
                            [SVProgressHUD showSuccessWithStatus:@"Token请求成功"];
                            complete (YES);
                            
                        }else{
                            
                            NSLog(@"请求失败!%ld",(long)code);
                            complete (NO);
                            [SVProgressHUD showErrorWithStatus:@"Token请求失败"];

                        }
                    }
                    :^(AFHTTPRequestOperation *operation ,NSError *error){
                        NSLog(@"Error: %@", error);

                        complete (NO);
                        [SVProgressHUD showSuccessWithStatus:@"Token请求失败"];

                    }];
        
    }
    
}




@end
