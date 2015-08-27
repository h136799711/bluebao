//
//  BoyePictureUploadManager.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/24.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyePictureUploadManager.h"
@implementation BoyePictureUploadManager



static NSInteger cache=0;


+(NSString *)getAvatarURL:(NSInteger )uid :(NSInteger )size {
    return [self getAvatarURL:uid :size :NO];
}

+(NSString *)getAvatarURL:(NSInteger )uid :(NSInteger )size :(BOOL)refresh{
    
    if(refresh){
        cache = cache+1;
    }
    
    NSString * urlstring = [NSString stringWithFormat:@"%@Picture/avatar?uid=%ld&size=%ld&cache=%ld",[BoyeHttpClient getBaseApiURL],(long)uid,(long)size,(long)cache];
    
    return urlstring;
}

//头像请求
+(void)requestUserHeadDown:(PictureReqModel *) picModel complete:(void(^)(UIImage * headImage))complete{
 
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced) {
            
            NSString * urlstring = [NSString stringWithFormat:@"%@Picture/avatar?uid=%ld&size=%ld",[BoyeHttpClient getBaseApiURL],picModel.uid,picModel.size];
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]];
            UIImage * resultImag = [UIImage imageWithData:data];
            complete( resultImag);
            
        }
    }];
}


//图片上传
+(void)requestPictureUpload:(PictureReqModel *)picModel :(void(^)(NSDictionary * ))success :(void(^)(NSString *))failure{
//        
//
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced) {
          
            NSString *token = [BoyeToken getAccessToken];
            BoyeHttpClient * client = [[BoyeHttpClient alloc] init];
            NSString * uid = [NSString stringWithFormat:@"%ld",picModel.uid];
            
            NSDictionary * params =  @{@"uid":uid,@"type":picModel.type};
            NSString * urlString = [NSString stringWithFormat:@"File/upload?access_token=%@",token];
            
            [SVProgressHUD showWithStatus:@"上传中..." maskType:SVProgressHUDMaskTypeClear];
            [client   upload:urlString
                  withParams:params
                            :picModel.filePath
                            :^(AFHTTPRequestOperation *operation, id responseObject) {
                                
                                NSDictionary * dict = nil;
                                
                                if(![responseObject isKindOfClass:[NSDictionary class]]){
                                    [SVProgressHUD showErrorWithStatus:@"数据无法识别,请重试!"];
                                    DLog(@" !NSDictionary ");
                                    
                                    return;
                                }
                                
                                dict = (NSDictionary *)responseObject;

                                if (dict == nil) {
                                    [SVProgressHUD showErrorWithStatus:@"数据为空,请重试!"];
                                    return ;
                                }
                                
                                
                                NSNumber * code = [dict objectForKey:@"code"];
                                
                                if ([code intValue] == 0) {
                                    
                                    success([dict objectForKey:@"data"]);
                                    [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                                }else{
                                    
                                    NSString * error = [dict valueForKey:@"data"];
                                    if(failure != nil){
                                        failure(error.description);
                                    }else{
                                        [SVProgressHUD showErrorWithStatus:error withDuration:3];
                                    }
                                }
                                
                                
                            } :^(AFHTTPRequestOperation *operation, NSError *error) {
                                if(failure != nil){
                                    failure(error.description);
                                }else{
                                    [SVProgressHUD showErrorWithStatus:@"头像上传失败" withDuration:3];
                                }
                            }];
        }
        
    }];
    
}


@end
