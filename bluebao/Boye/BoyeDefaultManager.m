//
//  BoyeDefaultManager.m
//  AFNTest
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeDefaultManager.h"

@interface BoyeDefaultManager()

//@property(nonatomic ,strong) NSString* name;


@end

@implementation BoyeDefaultManager



+(BOOL)isNeedLogin{
    
    
    NSDate *date=[[NSUserDefaults standardUserDefaults]  objectForKey:BOYE_ENDTIME];
    NSDate *now_date=[NSDate date];
    
    BOOL isNeed = [now_date compare:date]==NSOrderedAscending;
    
    return !isNeed;
    
    //return YES;
}
+(NSDateFormatter *)getDateFormatter:(NSString *)format{
    
    
    if(format == nil){
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    return formatter;
}

//用户登录接口
+(void)requestLoginUser:(UserInfo *)user complete:(void (^)(BOOL succed))complete{
//    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
//    
//    NSDictionary *params = @{@"grant_type":@"client_credentials",@"client_id":@BOYE_CLIENT_ID,@"client_secret":@BOYE_CLIENT_SECRET};
//    
//    NSDate *date = [NSDate date];
//    
//    NSInteger query_time = [date timeIntervalSince1970];
//    
//    
//    NSLog(@"query  at %lu",query_time);
//    
//    [client post:@"Api/Token/index"
//                :params
//                :^(AFHTTPRequestOperation *operation ,id responseObject){
//                    NSString *html = operation.responseString;
//                    NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
//                    id dict=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                    
//                    NSDictionary *json = (NSDictionary *)dict;
//                    
//                    NSLog(@"结果: %@", dict);
//                    
//                    if(json == nil){
//                        NSLog(@"json parse failed \r\n");
//                        return;
//                    }
//                    
//                    NSNumber *code = [json valueForKey:@"code"];
//                    
//                    NSDictionary *info = [json valueForKey:@"info"];
//                    
//                    NSLog(@"请求成功!%fl",[code floatValue]);
//                    
//                    
//                    if ([code intValue] == 0){
//                        NSString * access_token = [info objectForKey:@"access_token"];
//                        NSLog(@"请求成功!");
//                        NSLog(@"info = %@\r\n",info);
//                        NSLog(@"access_token = %@\r\n",access_token);
//                        NSNumber *expires_in = [info objectForKey:@"expires_in"];
//                        NSLog(@"expires_in %@ \r\n",expires_in);
//                        
//                        //                        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//                        //
//                        //                        [formatter setDateStyle:NSDateFormatterMediumStyle];
//                        //                        [formatter setTimeStyle:NSDateFormatterShortStyle];
//                        //                        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                        //
//                        //                        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//                        //                        [formatter setTimeZone:timeZone];
//                        //                        //                        expires_in =;
//                        //                        NSString* time = [NSString stringWithFormat:@"%lu" , (query_time + [expires_in integerValue])];
//                        //                        NSLog(@"end  at %@",time);
//                        
//                        
//                        //
//                        //                        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
//                        //                        //                        confromTimesp
//                        //
//                        //                        NSLog(@"expires at %@",[formatter stringFromDate:confromTimesp]);
//                        
//                        [self saveDataWithDic:info];
//                        
//                        complete (YES);
//                        
//                    }else{
//                        
//                        NSLog(@"请求失败!%ld",(long)code);
//                        complete (NO);
//                        
//                    }
//                    
//                    //                    NSLog(@"code = %lu %@\r\n",(unsigned long)[code count],code);
//                    //                    [self testGetRequest:@"Api/User/login"]
//                    
//                }
//                :^(AFHTTPRequestOperation *operation ,NSError *error){
//                    NSLog(@"Error: %@", error);
//                    complete (NO);
//                    
//                }];
    
    complete (YES);
    
}



//保存token 以及计算出过期的时间并保存

+(void)saveDataWithDic:(NSDictionary *)dic{
    
    NSString *access_token=[dic objectForKey:@"access_token"];
    double time=[[dic objectForKey:@"expires_in"] doubleValue];
    
    //计算出距离当前日期 长度为time的日期
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:time];
    
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:BOYE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:BOYE_ENDTIME];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
//    NSLog(@" date =%@",date);
    
}






@end
