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

//是否存在有效token
+(BOOL)isTokenEffective{
    
    if ([BoyeDefaultManager isTokenExist]) {
        
        if ([BoyeDefaultManager isDateOut]) {
            
            ALERTVIEW(@"token过期");
            
            return NO;
        }
        return YES;
    }else{
        
        ALERTVIEW(@"token不存在");
        
        return NO;
    }
}

//是否过期
+(BOOL)isDateOut{
    
    NSDate *end_date=[[NSUserDefaults standardUserDefaults]  objectForKey:BOYE_ENDTIME];
    NSDate *now_date=[NSDate date];
    
//    NSLog(@" \r *** nowDate: %@   \r  ***  endDate:%@",now_date,end_date);
    BOOL isOut = [now_date compare:end_date]==NSOrderedAscending;
    
//    NSLog(@" \r *** is out  %d  ",isOut);
    return !isOut;
    
    //return YES;
}

//token是否存在
+(BOOL) isTokenExist{
    
    NSString * token = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
    
    if (token == nil) {
        return NO;
    }
    //874d69325dfd98c1eb40f9b7f20de36d75bd5413

//    NSLog(@" \r *** 当前 token : %@",token);
    return YES;
}

//日期
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



//保存token 以及计算出过期的时间并保存

+(void)saveDataWithDic:(NSDictionary *)dic{
    
    NSString *access_token=[dic objectForKey:@"access_token"];
    double time=[[dic objectForKey:@"expires_in"] doubleValue];
    
    //计算出距离当前日期 长度为time的日期
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:time];
    
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:BOYE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:BOYE_ENDTIME];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    //    NSLog(@" token   - =%@",[USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN]);
    
}


//获取令牌
+(void)requtstAccessTokenComplete:(void(^)(BOOL  succed))complete{
    
    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
    NSDictionary *params = @{@"grant_type":@"client_credentials",@"client_id":@BOYE_CLIENT_ID,@"client_secret":@BOYE_CLIENT_SECRET};
    
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
//                        NSString * access_token = [info objectForKey:@"access_token"];
//                        NSLog(@" \r access_token:   %@",access_token);
                        [self saveDataWithDic:info];
                        complete (YES);
  
                    }else{
                        
                        NSLog(@"请求失败!%ld",(long)code);
                        complete (NO);
                    }
                }
                :^(AFHTTPRequestOperation *operation ,NSError *error){
                    NSLog(@"Error: %@", error);
                    complete (NO);
                }];
    
}


//用户注册接口
+(void)requestRegisterUser:(User *)user complete:(void(^)(BOOL succed))complete{
 

    NSString * token = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
    //e1622ce558609222b6aa91da4beebe91510d93f1
    NSLog(@" \r---- userName: %@ \r ----userword:  %@ \n ---- 令牌token: %@",user.username ,user.password  ,token);

    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
    NSDictionary *params = @{@"username":user.username,@"password":user.password};
    NSString * urlstr = [NSString stringWithFormat:@"User/register?access_token=%@",token];

    [client post:urlstr
                :params
                :^(AFHTTPRequestOperation *operation ,id responseObject){
                    
                    NSString *html = operation.responseString;
                    
                  //  NSLog(@"结果: %@", html);
                    
                    NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                    id dict=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    
                    NSDictionary *json = (NSDictionary *)dict;
                    
                    NSLog(@"结果: %@", json);

                    
                    if(json == nil){
                        NSLog(@"json parse failed \r\n");
                        return;
                    }
                    
                    NSNumber *code = [json valueForKey:@"code"];
                    NSLog(@"请求成功!%fl",[code floatValue]);
                    
                    if ([code intValue] == 0){

                        complete (YES);
                        
                    }else{
                        
                        NSLog(@"请求失败!%ld",(long)code);
                        
                        [BoyeDefaultManager getCodeWrongData:json];//
                    }
                    
                }
                :^(AFHTTPRequestOperation *operation ,NSError *error){
                    
                    NSLog(@"Error: %@", error.description);
                    complete (NO);
                    
                }];
}





//用户登录接口
+(void)requestLoginUser:(User *)user complete:(void (^)(BOOL succed))complete{
    
    NSString * token = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
    NSLog(@" \r---- userName: %@ \r ----userword:  %@ \n ---- 令牌token: %@",user.username ,user.password  ,token);

    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
    
    NSDictionary *params = @{@"username":user.username,@"password":user.password};
    
    NSString * urlstr = [NSString stringWithFormat:@"User/login?access_token=%@",[USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN]];
    [client post:urlstr
                :params
                :^(AFHTTPRequestOperation *operation ,id responseObject){
                    NSString *html = operation.responseString;
                    NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                    id dict=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    NSDictionary *json = (NSDictionary *)dict;
                    
                    NSLog(@"结果: %@", dict);
                    
                    if(json == nil){
                        NSLog(@"json parse failed \r\n");
                        return;
                    }
                    
                    NSNumber *code = [json valueForKey:@"code"];
                    
                    NSLog(@"请求成功!%fl",[code floatValue]);
            
                    if ([code intValue] == 0){
                       
                        NSDictionary *info = [json valueForKey:@"data"];

//                        NSLog(@"info = %@\r\n",info);
                        
                        complete (YES);
                        
                    }else{
                        
                        [BoyeDefaultManager getCodeWrongData:json];
                        
                        NSLog(@"请求失败!%ld",(long)code);
                    }
                    
                }
                :^(AFHTTPRequestOperation *operation ,NSError *error){

                    NSLog(@"Error: %@", error);
                    NSString * errorstr = [NSString stringWithFormat:@"%@",error];
                    ALERTVIEW(errorstr);
                    
                }];
    
//    complete (YES);
    
}

//返回响应成功后请求失败原因 code 非 0 原因
+(void)getCodeWrongData:(NSDictionary *)dic{
    NSString * errorData = [dic valueForKey:@"data"];
    ALERTVIEW(errorData);
    
}


//用户信息接口
+(void)requestUserInfoUpdata:(UserInfo *)userInfo complete:(void(^)(BOOL succed))complete{
    
    
    
    
}



@end
