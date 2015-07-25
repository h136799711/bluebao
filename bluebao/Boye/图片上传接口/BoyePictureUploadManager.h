//
//  BoyePictureUploadManager.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/24.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureReqModel.h"
@interface BoyePictureUploadManager : NSObject

//头像请求
+(void)requestUserHeadDown:(PictureReqModel *) picModel complete:(void(^)(UIImage * headImage))complete;

//图片上传
+(void)requestPictureUpload:(PictureReqModel *)picModel complete:(void (^)(BOOL successed))complete;
@end
