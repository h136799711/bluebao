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
 DLog(@"json parse failed \r\n");
 return;
 }
 
 DLog(@"dic %@",dic);
 
 NSNumber * code = [dic valueForKey:@"code"];
 DLog(@"请求成功！%fl",[code floatValue]);

**/


//动感单车数据获取
+(void)requestBicyleData:(BicyleReqModel *)bicyReqModel :(void(^)(NSDictionary * ))success :(void(^)(NSString *))failure{
    
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced ) {
            
            NSString * token  = [BoyeToken getAccessToken];
            NSString * urlString = [NSString stringWithFormat:@"Bicyle/day?access_token=%@",token];
            NSString * uid = [NSString stringWithFormat:@"%ld",(long)bicyReqModel.uid];
            NSString * time = [NSString stringWithFormat:@"%ld",(long)bicyReqModel.time];
            DLog(@"--\r-uid- %@- %@ -uuid -time-%@ ",uid,bicyReqModel.uuid,time);
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
                            
                                   DLog(@" 动感单车数据获取 responseObject :%@",responseObject);
                            NSDictionary * dic = (NSDictionary *)responseObject;
                            
                            if (!dic) {
                                [SVProgressHUD showErrorWithStatus:@"请求返回不为字典,请重试!"];
                                return ;
                                
                            }

//                            DLog(@"\r 动感单车数据获取 bicyle dic :%@",dic);
                            NSNumber * code = [dic valueForKey:@"code"];
                            DLog(@"请求成功！%fl",[code floatValue]);
                            if ([code integerValue] == 0) {
                                NSDictionary * dataDic = [dic valueForKey:@"data"];
                                success(dataDic);
                                
//                                [SVProgressHUD showSuccessWithStatus:@"请求成功"];
                                [SVProgressHUD dismiss];
                                DLog(@"--------");
                            }else{
                                
                                NSString * errorData = [dic valueForKey:@"data"];
                                failure (errorData);
                                DLog(@"%@",errorData);
                                [SVProgressHUD showErrorWithStatus:errorData];
                            }
                        } :^(AFHTTPRequestOperation *operation, NSError *error) {
                            DLog(@"error %@",error);
                           failure (@"请求失败");
                            [SVProgressHUD showErrorWithStatus:@"请求失败"];
                        }];
        }
    }];
}

//动感单车数据上传
+(void)requestBicyleDataUpload:(BicyleReqModel *)bicyReqModel complete:(void(^)(BOOL bicyleSuccessed))complete{
    
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        if (tokenSucced) {
            NSString * token  =   [BoyeToken getAccessToken];
            
            NSString * urlString = [NSString stringWithFormat:@"Bicyle/add?access_token=%@",token];
            NSString * uid = [NSString stringWithFormat:@"%ld",bicyReqModel.uid];
            DLog(@" %ld  -----   %@",bicyReqModel.bicyleModel.speed,[MyTool getStringToInteger:bicyReqModel.bicyleModel.speed]);
            DLog(@"----uid %@-uuid %@ - -upload_time-%@ ",uid,bicyReqModel.uuid,[MyTool getStringToInteger:bicyReqModel.bicyleModel.upload_time]);

            NSDictionary * params =  @{
                                       @"uid":uid,
                                       @"uuid":bicyReqModel.uuid,
                                        @"speed":[MyTool getStringToInteger:bicyReqModel.bicyleModel.speed],
                                        @"heart_rate":[MyTool getStringToInteger:bicyReqModel.bicyleModel.heart_rate],
                                        @"distance":[MyTool getStringToInteger:bicyReqModel.bicyleModel.distance],
                                        @"total_distance":[MyTool getStringToInteger:bicyReqModel.bicyleModel.total_distance],
                                        @"cost_time":[MyTool getStringToInteger:bicyReqModel.bicyleModel.cost_time],
                                       @"calorie":[MyTool getStringToInteger:bicyReqModel.bicyleModel.calorie],
                                       @"target_calorie":[MyTool getStringToInteger:bicyReqModel.bicyleModel.target_calorie],
                                       @"upload_time":[MyTool getStringToInteger:bicyReqModel.bicyleModel.upload_time]
                                       };
            
//            [SVProgressHUD showWithStatus:@"数据上传中..." maskType:SVProgressHUDMaskTypeClear];
            
            BoyeHttpClient * client = [BoyeHttpClient alloc];
            [client post:urlString
                        :params
                        :^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSData * data = [operation.responseString  dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                            if (!dic) {
                                DLog(@"json parse failed \r\n");
                                return ;
                            }
                            DLog(@"bicyle uplod dic %@",dic);
                            NSNumber * code = [dic valueForKey:@"code"];
                            DLog(@"请求成功！%fl",[code floatValue]);
                            if ([code integerValue] == 0) {
                                
//                                NSString * successedData = [dic valueForKey:@"data"];
//                                [SVProgressHUD showSuccessWithStatus:successedData];
                                [SVProgressHUD dismiss];
                                complete(YES);
                            }else{
                                
                                NSString * errorData = [dic valueForKey:@"data"];
                                [SVProgressHUD showErrorWithStatus:errorData];
                                
                            }
                        } :^(AFHTTPRequestOperation *operation, NSError *error) {
                            
//                            DLog(@"error %@",error);
                            [SVProgressHUD showErrorWithStatus:@"请求失败"];
                            
                        }];
        }
    }];
}

//动感单车数据获取
+(void)requestMonthlyBicyleData:(BicyleReqModel *)bicyReqModel :(void(^)(NSDictionary * ))success :(void(^)(NSString *))failure{
    
    [BoyeToken isTokenEffectiveComplete:^(BOOL tokenSucced) {
        
        if (tokenSucced ) {
            
            NSString * token  = [BoyeToken getAccessToken];
            NSString * urlString = [NSString stringWithFormat:@"Bicyle/month?access_token=%@",token];
            NSString * uid = [NSString stringWithFormat:@"%ld",bicyReqModel.uid];
            NSString * time = [NSString stringWithFormat:@"%ld",bicyReqModel.time];
            DLog(@"--\r-- %@- %@ -  ",uid,bicyReqModel.uuid);
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
                            
                            [SVProgressHUD dismiss];
                            if(responseObject == nil){
                                
                                [SVProgressHUD showErrorWithStatus:@"请求返回为空,请重试!" withDuration:3];
                                return ;
                            }
                            
                            NSDictionary * dict = (NSDictionary *)responseObject;
                            
                            if (!dict) {
                                [SVProgressHUD showErrorWithStatus:@"请求返回不为字典,请重试!" withDuration:3];
                                return ;
                                
                            }
                            DLog(@"bicyle dic %@",dict);
                            NSNumber * code = [dict valueForKey:@"code"];
                            DLog(@"请求成功！%fl",[code floatValue]);
                            if ([code integerValue] == 0) {
//                                complete(YES);
                                success(dict);
                            }else{
                                
                                NSString * errorData = [dict valueForKey:@"data"];
                                if(failure == nil){
                                
                                    [SVProgressHUD showErrorWithStatus:errorData withDuration:3];
                                    
                                }else{
                                    failure(errorData);
                                }
                            }
                        } :^(AFHTTPRequestOperation *operation, NSError *error) {
                            DLog(@"error %@",error);
                            
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
