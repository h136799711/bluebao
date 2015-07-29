//
//  PictureRespModel.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/25.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureRespModel : NSObject

/**
 
 "create_time" = 1438132400;
 ext = jpg;
 id = 15;
 imgurl = "http://192.168.0.100/github/201507lanbao/Uploads/UserPicture/2015-07-29/55b828b09b6fe.jpg";
 md5 = 2ef6b8c5aff667c828c27848b6bf5b40;
 "ori_name" = "xxx.jpg";
 path = "/Uploads/UserPicture/2015-07-29/55b828b09b6fe.jpg";
 savename = "55b828b09b6fe.jpg";
 sha1 = 3dbf6c8962c4f1372a3701c5c10a10492bef69d9;
 sha1 = 86160;
 status = 1;
 type = avatar;
 uid = 14;

 
 */

@property (nonatomic,copy)      NSString             *create_time;
@property (nonatomic,copy)      NSString             *ext;
@property (nonatomic,assign)    NSInteger            pic_id;
@property (nonatomic,copy)      NSString             *imgurl;
@property (nonatomic,copy)      NSString             *md5;
@property (nonatomic,copy)      NSString             *path;
@property (nonatomic,copy)      NSString             *sha1;
@property (nonatomic,assign)    NSInteger             size;
@property (nonatomic,assign)    NSInteger            status;
@property (nonatomic,copy)      NSString             *type;
@property (nonatomic,assign)    NSInteger              uid;





@end
