//
//  BoyeGoaldbModel.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/14.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeGoaldbModel.h"

@implementation BoyeGoaldbModel
 
-(void)setFireDate:(NSDate *)fireDate{
    if (_fireDate == nil) {
        _fireDate = [[NSDate alloc] init];
    }
    _fireDate = fireDate;
}

@end
