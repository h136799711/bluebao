//
//  BoyePictureUploadManager.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/24.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyePictureUploadManager.h"

@implementation BoyePictureUploadManager

//头像请求
+(void)requestUserHeadDown:(PictureReqModel *) picModel complete:(void(^)(UIImage * headImage))complete{
    
    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
    picModel.uid = @"2";
//    NSDictionary *params = @{@"username":user.username,@"password":user.password};
    
    NSString * urlstr = [NSString stringWithFormat:@"Avatar/index?uid=%@",picModel.uid];
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
+(void)requestPictureUpload:(PictureReqModel *) picModel complete:(void (^)(BOOL successed))complete{
    
//    picModel.uid = @"1";
    
    NSString *token = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
    BoyeHttpClient * client = [[BoyeHttpClient alloc] init];
    
    NSDictionary * params =  @{@"uid":picModel.uid,@"type":@"avatar"};
    NSString * urlString = [NSString stringWithFormat:@"File/upload?access_token=%@",token];
    
//    NSString * fileStrng = [[NSBundle  mainBundle] pathForResource:@"testhead" ofType:@"png"];
NSString * fileStrng = @"/Uploads\/UserPicture\/2015-07-24\/55b19c3855c66.jpg";
    [client   upload:urlString
          withParams:params
                    :fileStrng :^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSData * data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        
                        if (dict == nil) {
                         
                            NSLog(@"dic parse failed \r\n");
                            return ;
                        }
                        NSNumber * code = [dict objectForKey:@"data"];
                        if ([code intValue] == 0) {

                            complete(YES);
                        }
                        
                        
                        NSLog(@"dict %@ ",dict);

              
          } :^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@" error %@",error);
          }];
    
    
    
}


@end
