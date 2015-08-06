//
//  BicyleReqModel.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BicyleReqModel.h"

@implementation BicyleReqModel

-(Bicyle*)bicyleModel{
    if (_bicyleModel == nil) {
        
        _bicyleModel = [[Bicyle alloc] init];
    }
    return _bicyleModel;
}

-(void)setUuid:(NSString *)uuid{
    
    if (uuid == nil) {
        _uuid = @"";
    }
    _uuid = uuid;
}
@end
