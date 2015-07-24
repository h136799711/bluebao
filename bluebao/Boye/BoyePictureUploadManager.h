//
//  BoyePictureUploadManager.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/24.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoyePictureUploadManager : NSObject

//图片接口
+(void)requestUserHeadDown:(UserInfo *) userInfo complete:(void(^)(UIImage * headImage))complete;

//图片上传
+(void)requestPictureUpload:(UserInfo *)userInfo complete:(void (^)(BOOL successed))complete;
@end
