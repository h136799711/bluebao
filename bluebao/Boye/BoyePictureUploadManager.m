//
//  BoyePictureUploadManager.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/24.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyePictureUploadManager.h"

@implementation BoyePictureUploadManager

//图片接口
+(void)requestUserHeadDown:(UserInfo *) userInfo complete:(void(^)(UIImage * headImage))complete{
    
    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
    userInfo.uid = 2;
//    NSDictionary *params = @{@"username":user.username,@"password":user.password};
    
    NSString * urlstr = [NSString stringWithFormat:@"Avatar/index?uid=%ld",userInfo.uid];
    [client post:urlstr
                :nil
                :^(AFHTTPRequestOperation *operation ,id responseObject){
                    NSString *html = operation.responseString;
                    NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                    
                    id json = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];;
                    NSDictionary *dict = (NSDictionary *)json;
                    
                    NSLog(@"dict  %@",dict);
                    if(dict == nil){
                        NSLog(@"json parse failed \r\n");
                        return;
                    }
                    
                    NSNumber *code = [dict valueForKey:@"code"];
                    
                    NSLog(@"请求成功!%fl",[code floatValue]);
                    
                    if ([code intValue] == 0){
                        
                        NSDictionary *info = [dict valueForKey:@"info"];
                        
                        NSLog(@"info = %@\r\n",info);
                        
                        
                    }else{
                        
                        
                        NSLog(@"请求失败!%ld",(long)code);
                    }
                    
                }
                :^(AFHTTPRequestOperation *operation ,NSError *error){
                    
                    NSLog(@"Error: %@", error);
                    NSString * errorstr = [NSString stringWithFormat:@"%@",error];
                    ALERTVIEW(errorstr);
                    
                }];

    
}


//图片上传
+(void)requestPictureUpload:(UserInfo *)userInfo complete:(void (^)(BOOL successed))complete{
    
    userInfo.uid = 1;
    
    NSString *token = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
    BoyeHttpClient * client = [[BoyeHttpClient alloc] init];
    
    NSString * uidstr = [NSString stringWithFormat:@"%ld",userInfo.uid];
    NSDictionary * params =  @{@"uid":uidstr,@"type":@"avatar"};
    NSString * urlString = [NSString stringWithFormat:@"File/upload?access_token=%@",token];
    NSString * fileStrng = [[NSBundle  mainBundle] pathForResource:@"testhead" ofType:@"png"];

    [client   upload:urlString
          withParams:params
                    :fileStrng :^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSData * data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        
                        if (dict != nil) {
                            
                            NSLog(@"dict %@ ",dict);
                        }
                        
              
          } :^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@" error %@",error);
          }];
    
    
    
}


@end
