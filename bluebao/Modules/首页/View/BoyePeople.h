//
//  BoyePeople.h
//  bluebao
//
//  Created by boye_mac1 on 15/8/5.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoyePeople : NSObject

@property (nonatomic,assign) NSInteger       uid;
@property (nonatomic,assign) NSInteger       weight;
@property (nonatomic,assign) NSInteger       height;
@property (nonatomic,assign) NSInteger       target_weight;
@property (nonatomic,assign) NSInteger       age;
@property (nonatomic,assign) CGFloat         bMI;
@property (nonatomic,assign) NSInteger       sex ; //0 ,女;1,男
@property (nonatomic,copy)  NSString         * sexstr;  //男，女

@end
