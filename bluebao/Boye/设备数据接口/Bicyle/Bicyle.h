//
//  Bicyle.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bicyle : NSObject

@property (nonatomic,assign) NSInteger          uid;
@property (nonatomic,copy) NSString             *uuid;//设备id
@property (nonatomic,assign) long long          time;
@end
