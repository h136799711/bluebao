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
    
//    BoyeHttpClient *client = [[BoyeHttpClient alloc]init];
//    picModel.uid = @"8";
//    NSDictionary *params = @{@"username":user.username,@"password":user.password};
    
//    NSString * urlstr = [NSString stringWithFormat:@"Avatar/index?uid=%@",picModel.uid];
   
    NSString * urlstring = [NSString stringWithFormat:@"http://192.168.0.100/github/201507lanbao/api.php/Avatar/index?uid=%@",picModel.uid];

    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]];
    UIImage * resultImag = [UIImage imageWithData:data];
    complete( resultImag);
    
   
}


//图片上传
+(void)requestPictureUpload:(PictureReqModel *) picModel complete:(void (^)(BOOL successed))complete{
    
//    picModel.uid = @"8";
    
    NSLog(@"\r --uid : %@,  ",picModel.uid);
    
    NSString *token = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
    BoyeHttpClient * client = [[BoyeHttpClient alloc] init];
    
    NSDictionary * params =  @{@"uid":picModel.uid,@"type":picModel.type};
    NSString * urlString = [NSString stringWithFormat:@"File/upload?access_token=%@",token];
    
    NSString * filePath = [NSString stringWithFormat:@"file://%@",picModel.filePath];

    
    
    
//    NSLog(@" \r--- filePath  %@",filePath);
    
    [client   upload:urlString
          withParams:params
                    :filePath
                    :^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSLog(@" !responseObject %@",responseObject);
                        
//                        NSData * data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
//                        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        NSDictionary * dict = nil;
                        
                        if(![responseObject isKindOfClass:[NSDictionary class]]){
                            
                            NSLog(@" !NSDictionary ");

                            return;
                        }
                        
                        dict = (NSDictionary *)responseObject;
                        
                        if (dict == nil) {
                         
                            NSLog(@"dic parse failed \r\n");
                            return ;
                        }
                        
                        NSLog(@"dict %@ ",dict);

                        NSNumber * code = [dict objectForKey:@"code"];
                        
                        if ([code intValue] == 0) {

                            
                        }else{
                            
                            NSString * error = [dict valueForKey:@"data"];
                            NSLog(@"%@",error);
                        }
                        
              
          } :^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@" error %@",error);
          }];
    
}


@end
