//
//  BicyleReqModel.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BicyleReqModel : NSObject


@property (nonatomic,assign) NSInteger          uid;
//@property (nonatomic,copy) NSString          *uuid;//设备id
@property (nonatomic,assign)NSInteger          time;

@property (nonatomic,strong) Bicyle * bicyleModel;


-(NSString *)uuid;
-(void)setUuid:(NSString *)uuid;

@end