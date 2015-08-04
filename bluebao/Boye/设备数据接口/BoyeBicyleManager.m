//
//  BoyeBicyleManager.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeBicyleManager.h"

@implementation BoyeBicyleManager

/*

 NSData * data = [operation.responseString  dataUsingEncoding:NSUTF8StringEncoding];
 NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
 
 if (dic == nil) {
 NSLog(@"json parse failed \r\n");
 return;
 }
 
 NSLog(@"dic %@",dic);
 
 NSNumber * code = [dic valueForKey:@"code"];
 NSLog(@"请求成功！%fl",[code floatValue]);

**/


//动感单车数据获取
+(void)requestBicyleData:(BicyleReqModel *)bicyReqModel complete:(void(^)(BOOL bicyleSuccessed))complete;
{
    
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced ) {
            
            NSString * token  = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
            NSString * urlString = [NSString stringWithFormat:@"Bicyle/day?access_token=%@",token];
            NSString * uid = [NSString stringWithFormat:@"%ld",bicyReqModel.uid];
            NSString * time = [NSString stringWithFormat:@"%lld",bicyReqModel.time];
            NSLog(@"--\r-- %@- %@ -  ",uid,bicyReqModel.uuid);
            NSDictionary * params =  @{
                                       @"uid":uid,
                                       @"uuid":bicyReqModel.uuid,
                                       @"time":time
                                       };
           
            [SVProgressHUD showWithStatus:@"数据请求中..." maskType:SVProgressHUDMaskTypeClear];
            
            BoyeHttpClient * client = [BoyeHttpClient alloc];
            [client post:urlString
                        :params
                        :^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSData * data = [operation.responseString  dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                            if (!dic) {
                                NSLog(@"json parse failed \r\n");
                                return ;
                            }
                            NSLog(@"bicyle dic %@",dic);
                            NSNumber * code = [dic valueForKey:@"code"];
                            NSLog(@"请求成功！%fl",[code floatValue]);
                            if ([code integerValue] == 0) {
                                complete(YES);
                                [SVProgressHUD showSuccessWithStatus:@"请求成功"];
 
                            }else{
                                
                                NSString * errorData = [dic valueForKey:@"data"];
//                                ALERTVIEW(errorData)
                                [SVProgressHUD showErrorWithStatus:errorData];
                            }
                        } :^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"error %@",error);
                            [SVProgressHUD showErrorWithStatus:@"请求失败"];
                        }];
        }
    }];
    
}

//动感单车数据上传
+(void)requestBicyleDataUpload:(BicyleReqModel *)bicyReqModel complete:(void(^)(BOOL bicyleSuccessed))complete{
    
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        if (tokenSucced) {
            NSString * token  = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
            NSString * urlString = [NSString stringWithFormat:@"Bicyle/add?access_token=%@",token];
            NSString * uid = [NSString stringWithFormat:@"%ld",bicyReqModel.uid];
            NSString * time = [NSString stringWithFormat:@"%lld",bicyReqModel.time];
            
            NSDictionary * params =  @{
                                       @"uid":uid,
                                       @"uuid":bicyReqModel.uuid,
                                       @"time":time,
                                        @"speed":time,
                                        @"heart_rate":time,
                                        @"distance":time,
                                        @"total_distance":time,
                                        @"cost_time":time,
                                       @"calorie":time,
                                       @"upload_time":time,
                                       
                                       };
            
            [SVProgressHUD showWithStatus:@"数据上传中..." maskType:SVProgressHUDMaskTypeClear];
            
            BoyeHttpClient * client = [BoyeHttpClient alloc];
            [client post:urlString
                        :params
                        :^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSData * data = [operation.responseString  dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                            if (!dic) {
                                NSLog(@"json parse failed \r\n");
                                return ;
                            }
                            NSLog(@"bicyle uplod dic %@",dic);
                            NSNumber * code = [dic valueForKey:@"code"];
                            NSLog(@"请求成功！%fl",[code floatValue]);
                            if ([code integerValue] == 0) {
                                
                                NSString * successedData = [dic valueForKey:@"data"];
                                [SVProgressHUD showSuccessWithStatus:successedData];
                                complete(YES);
                            }else{
                                
                                NSString * errorData = [dic valueForKey:@"data"];
                                [SVProgressHUD showErrorWithStatus:errorData];
                                
                            }
                        } :^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                            NSLog(@"error %@",error);
                            [SVProgressHUD showErrorWithStatus:@"请求失败"];
                            
                        }];
        }
    }];
}

//动感单车数据获取
+(void)requestMonthlyBicyleData:(BicyleReqModel *)bicyReqModel :(void(^)(NSDictionary * ))success :(void(^)(NSString *))failure{
    
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced ) {
            
            NSString * token  = [USER_DEFAULT objectForKey:BOYE_ACCESS_TOKEN];
            NSString * urlString = [NSString stringWithFormat:@"Bicyle/month?access_token=%@",token];
            NSString * uid = [NSString stringWithFormat:@"%ld",bicyReqModel.uid];
            NSString * time = [NSString stringWithFormat:@"%lld",bicyReqModel.time];
            NSLog(@"--\r-- %@- %@ -  ",uid,bicyReqModel.uuid);
            NSDictionary * params =  @{
                                       @"uid":uid,
                                       @"uuid":bicyReqModel.uuid,
                                       @"time":time
                                       };
            
            [SVProgressHUD showWithStatus:@"数据请求中..." maskType:SVProgressHUDMaskTypeClear];
            
            BoyeHttpClient * client = [BoyeHttpClient alloc];
            [client post:urlString
                        :params
                        :^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            if(responseObject == nil){
                                
                                [SVProgressHUD showErrorWithStatus:@"请求返回为空,请重试!"];
                                return ;
                            }
                            
                            NSDictionary * dict = (NSDictionary *)responseObject;
                            
                            if (!dict) {
                                [SVProgressHUD showErrorWithStatus:@"请求返回不为字典,请重试!"];
                                return ;
                                
                            }
                            NSLog(@"bicyle dic %@",dict);
                            NSNumber * code = [dict valueForKey:@"code"];
                            NSLog(@"请求成功！%fl",[code floatValue]);
                            if ([code integerValue] == 0) {
//                                complete(YES);
                                success(dict);
                                [SVProgressHUD dismiss];
                            }else{
                                
                                NSString * errorData = [dict valueForKey:@"data"];
                                if(failure == nil){
                                
                                    [SVProgressHUD showErrorWithStatus:errorData withDuration:3];
                                    
                                }else{
                                    failure(errorData);
                                }
                            }
                        } :^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"error %@",error);
                            
                            if(failure == nil){
                                [SVProgressHUD showErrorWithStatus:@"请求失败" withDuration:3];

                            }else{
                                failure(@"请求失败");
                            }

                        }];
        }
    }];
    
}

@end
