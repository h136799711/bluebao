//
//  BoyeBicyleManager.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BicyleReqModel.h"

@interface BoyeBicyleManager : NSObject

//动感单车数据获取
+(void)requestBicyleData:(BicyleReqModel *)bicyReqModel complete:(void(^)(BOOL bicyleSuccessed))complete;

//动感单车数据上传
+(void)requestBicyleDataUpload:(BicyleReqModel *)bicyReqModel complete:(void(^)(BOOL bicyleSuccessed))complete;

//动感单车数据按月获取
+(void)requestMonthlyBicyleData:(BicyleReqModel *)bicyReqModel complete:(void(^)(BOOL bicyleSuccessed))complete;



@end
