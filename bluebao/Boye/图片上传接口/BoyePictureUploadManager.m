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
//    picModel.uid = @"1";
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
    
    NSDictionary * params =  @{@"uid":picModel.uid,@"type":picModel.type};
    NSString * urlString = [NSString stringWithFormat:@"File/upload?access_token=%@&uid=%@",token,picModel.uid];
    
    
    
    /**
     
     -- testHeadfileString  :file:///Users/boye-mac/Library/Developer/CoreSimulator/Devices/F5C31269-9F48-4DDF-B145-15476F4E5C9A/data/Containers/Bundle/Application/14285784-FFC5-437C-B40F-30AC22DA7AD8/bluebao.app/testhead.png
     
     --- filePath  :file:///Users/boye-mac/Library/Developer/CoreSimulator/Devices/F5C31269-9F48-4DDF-B145-15476F4E5C9A/data/Containers/Data/Application/32F5197B-CF39-49D6-928A-55079A2C92F6/Documents/image.png
     file:///Users/boye-mac/Library/Developer/CoreSimulator/Devices/F5C31269-9F48-4DDF-B145-15476F4E5C9A/data/Containers/Data/Application/4A6859CC-87AB-4517-BCF3-5CCEE64C3F42/Documents/image.png
     */

    
    //@"file://path/to/image.png"
//    NSString * testHeadfileString = [[NSBundle  mainBundle] pathForResource:@"testhead" ofType:@"png"];
//    
//    NSLog(@" \r-- testHeadfileString  :%@",testHeadfileString);

    NSString * filePath = [NSString stringWithFormat:@"file://%@",picModel.filePath];
    
    NSLog(@" \r--- filePath  %@",filePath);
    
    [client   upload:urlString
          withParams:params
                    :filePath
                    :^(AFHTTPRequestOperation *operation, id responseObject) {
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
