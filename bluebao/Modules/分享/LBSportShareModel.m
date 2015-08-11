//
//  LBSportShareModel.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/11.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "LBSportShareModel.h"

@implementation LBSportShareModel


+(LBSportShareModel *) sharedLBSportShareModel{
    
    static LBSportShareModel * lbsport;
    static dispatch_once_t oncelb;
    dispatch_once(&oncelb, ^{
        lbsport = [[self alloc] init];
    });
    return lbsport;
}

@end
