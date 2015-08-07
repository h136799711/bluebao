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


#pragma mark --- 用户注册接口
+(void)requestRegisterUser:(User *)user complete:(void(^)(BOOL succed))complete{
 
    //请求Token
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced) {
           //注册请求
            [self reqRegister:user complete:^(BOOL registSucced) {
                
                if (registSucced) {
                    complete(YES);
                }
            }];
        
        }
    }];


    
    
  }

//用户注册接口
+(void)reqRegister:(User *)user complete:(void(^)(BOOL registSucced))complete{
    
    NSString * token = [BoyeToken getAccessToken];
    //e1622ce558609222b6aa91da4beebe91510d93f1
    //    NSLog(@" \r---- userName: %@ \r ----userword:  %@ \n ---- 令牌token: %@",user.username ,user.password  ,token);
    
    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
    NSDictionary *params = @{@"username":user.username,@"password":user.password};
    NSString * urlstr = [NSString stringWithFormat:@"User/register?access_token=%@",token];
    [SVProgressHUD showWithStatus:@"正在注册..." maskType:SVProgressHUDMaskTypeClear];
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
                        
                        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                    }else{
                        
                        NSLog(@"请求失败!%ld",(long)code);
                        
                        [BoyeDefaultManager getCodeWrongData:json];//
                    }
                    
                }
                :^(AFHTTPRequestOperation *operation ,NSError *error){
                    
                    NSLog(@"Error: %@", error.description);
                    complete (NO);
                    
                    [SVProgressHUD showErrorWithStatus:@"注册失败"];
                }];
}



#pragma mark ---用户登录接口
+(void)requestLoginUser:(User *)user complete:(void (^)(UserInfo * userInfo))complete{
    
    //Token请求
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSuccesed) {
        
        if (tokenSuccesed) {
            //用户登陆
            [self reqLogin:user complete:^(UserInfo *_userInfo) {
                if (_userInfo) {
                    
                    complete(_userInfo);
                }
            }];
        }
    }];
    
  }
//用户登录接口
+(void)reqLogin:(User *)user complete:(void (^)(UserInfo * _userInfo))complete{
    
    NSString * token = [BoyeToken getAccessToken];
    NSLog(@" \r---- userName: %@ \r ----userword:  %@ \n ---- 令牌token: %@",user.username ,user.password  ,token);
    
    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
    
    [SVProgressHUD showWithStatus:@"正在登陆..." maskType:SVProgressHUDMaskTypeClear];
    
    NSDictionary *params = @{
                             @"username":user.username,
                             @"password":user.password
                             };
    
    NSString * urlstr = [NSString stringWithFormat:@"User/login?access_token=%@",token];
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
                        
                        UserInfo * responInfo = [[UserInfo alloc ]initWithUserInfoDictionary:info];
                        //                          NSLog(@"info ==%@=====%@===%ld===%ld=",responInfo.username,responInfo.nickname,responInfo.height,responInfo.target_weight);
                        
                        
                        complete (responInfo);
                        [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                    }else{
                        
                        [BoyeDefaultManager getCodeWrongData:json];
                        
                        NSLog(@"请求失败!%ld",(long)code);
                    }
                    
                }
                :^(AFHTTPRequestOperation *operation ,NSError *error){
                    [SVProgressHUD showErrorWithStatus:@"登陆失败"];
                }];

}

//返回响应成功后请求失败原因 code 非 0 原因
+(void)getCodeWrongData:(NSDictionary *)dic{
    NSString * errorData = [dic valueForKey:@"data"];
    [SVProgressHUD showErrorWithStatus:errorData];
    
}


#pragma mark ---用户信息接口
+(void)requestUserInfoUpdata:(UserUpdataReqModel *)userUpdata complete:(void(^)(BOOL succed))complete{

    
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced) {
            
            [self reqInfoUpdata:userUpdata complete:^(BOOL userInfoUpdatasucced) {
                
                complete(userInfoUpdatasucced);
            }];
            
            }
    }];



}

//pragma mark ---用户信息接口
+(void)reqInfoUpdata:(UserUpdataReqModel *)userUpdata complete:(void(^)(BOOL userInfoUpdatasucced ))complete{
    
//    User/update?access_token=ACCESS_TOKEN
    
    NSString * token = [BoyeToken getAccessToken];
    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
    
    [SVProgressHUD showWithStatus:@"信息更新..." maskType:SVProgressHUDMaskTypeClear];
    NSDictionary *params = @{
                             @"uid"             :  [NSNumber numberWithInteger:userUpdata.uid],
                             @"sex"             :userUpdata.sex,
                             @"nickname"        :userUpdata.nickname,
                             @"signature"       :userUpdata.signature,
                             @"height"          :userUpdata.height,
                             @"weight"          :userUpdata.weight,
                             @"target_weight"   :userUpdata.target_weight,
                             @"birthday"        :userUpdata.birthday
                             };

    NSString * urlstr = [NSString stringWithFormat:@"User/update?access_token=%@",token];
    
    [client post:urlstr
                :params
                :^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSData * data = [operation.responseString  dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

                    if (dic == nil) {
                        NSLog(@"json parse failed \r\n");
                        return;
                    }
                    
                   // NSLog(@"dic %@",dic);

                    NSNumber * code = [dic valueForKey:@"code"];
                    NSLog(@"请求成功！%fl",[code floatValue]);
                    
                    if ([code intValue] == 0) {
                       
                        NSString * successedData = [dic valueForKey:@"data"];
                        [SVProgressHUD showSuccessWithStatus:successedData];
                      
                    }else{
                        //更新失败
                        [BoyeDefaultManager getCodeWrongData:dic];
                    
                    }
                    
                } :^(AFHTTPRequestOperation *operation, NSError *error) {
        
                    [SVProgressHUD showErrorWithStatus:@"更新失败"];
                    
                    
                    NSLog(@" error:%@ ",error);
                    
                }];
}



@end
