//
//  PictureReqModel.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/25.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureReqModel : NSObject

@property (nonatomic,assign)NSInteger      uid;
@property (nonatomic,copy)NSString      * type;
@property (nonatomic,copy)NSString      * filePath;


@property (nonatomic,assign) NSInteger    size;

@end
