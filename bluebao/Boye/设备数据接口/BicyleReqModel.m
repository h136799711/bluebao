//
//  BicyleReqModel.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BicyleReqModel.h"
@interface BicyleReqModel()
{
    NSString             *_uuid;
}

//@property (nonatomic,strong) NSString             *uuid;//设备id

@end


@implementation BicyleReqModel


-(Bicyle*)bicyleModel{
    if (_bicyleModel == nil) {
        
        _bicyleModel = [[Bicyle alloc] init];
    }
    return _bicyleModel;
}

-(NSString *)uuid{
    
    if (_uuid == nil) {
        _uuid = @"";
    }
    return  _uuid;
}

-(void)setUuid:(NSString *)uuid{
    
    if (uuid == nil) {
        _uuid = @"";
    }
    _uuid = uuid;
}
@end
