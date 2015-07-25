//
//  UserUpdataReqModel.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/25.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserUpdataReqModel : NSObject


@property (nonatomic,copy)  NSString         *username;
@property (nonatomic,copy)  NSString         *nickname;
@property (nonatomic,copy)  NSString         *sex;
@property (nonatomic,copy)  NSString         * birthday;
@property (nonatomic,copy)  NSString         *signature;


@property (nonatomic,copy)  NSString       * uid;
@property (nonatomic,copy)  NSString       * weight;
@property (nonatomic,copy)  NSString       * height;
@property (nonatomic,copy)  NSString       * target_weight;
@property (nonatomic,copy)  NSString       *  age;



@end
