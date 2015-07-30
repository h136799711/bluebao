//
//  BoyePictureUploadManager.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/24.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyePictureUploadManager.h"
@implementation BoyePictureUploadManager

static NSString * const BASE_API_URL = @"http://192.168.0.100/github/201507lanbao/api.php/";

//头像请求
+(void)requestUserHeadDown:(PictureReqModel *) picModel complete:(void(^)(UIImage * headImage))complete{
 
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced) {
         
            NSString * urlstring = [NSString stringWithFormat:@"%@Picture/avatar?uid=%ld&size=%ld",BASE_API_URL,picModel.uid,picModel.size];
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]];
            UIImage * resultImag = [UIImage imageWithData:data];
            complete( resultImag);
            
        }
    }];
}

//头像上传
+(void)requestUploadUserHead:(PictureReqModel *)picModel complete:(void(^)(BOOL successed)) complete{
    
    
    
  }



//图片上传
+(void)requestPictureUpload:(PictureReqModel *) picModel complete:(void (^)(BOOL successed))complete{
//        
//
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced) {
          
            NSString *token = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
            BoyeHttpClient * client = [[BoyeHttpClient alloc] init];
            NSString * uid = [NSString stringWithFormat:@"%ld",picModel.uid];
            
            NSDictionary * params =  @{@"uid":uid,@"type":picModel.type};
            NSString * urlString = [NSString stringWithFormat:@"File/upload?access_token=%@",token];
            
            [SVProgressHUD showWithStatus:@"上传头像..." maskType:SVProgressHUDMaskTypeClear];
            [client   upload:urlString
                  withParams:params
                            :picModel.filePath
                            :^(AFHTTPRequestOperation *operation, id responseObject) {
                                
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
                                
                              //  NSLog(@"dict %@ ",dict);
                                
                                NSNumber * code = [dict objectForKey:@"code"];
                                
                                if ([code intValue] == 0) {
                                    
                                    complete (YES);
                                    [SVProgressHUD showSuccessWithStatus:@"头像上传成功"];
                                }else{
                                    
                                    NSString * error = [dict valueForKey:@"data"];
                                    [SVProgressHUD showErrorWithStatus:error];
                                    NSLog(@"%@",error);
                                }
                                
                                
                            } :^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                                NSLog(@" error %@",error);
                                [SVProgressHUD showErrorWithStatus:@"头像上传失败"];
                            }];
        }
        
    }];
    
}


@end
