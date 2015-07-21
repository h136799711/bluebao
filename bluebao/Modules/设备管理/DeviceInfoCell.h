//
//  DeviceInfoCell.h
//  Bluetooth
//
//  Created by hebidu on 15/7/17.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceInfoCell : UITableViewCell

@property (copy,nonatomic)NSString * name;

@property (copy,nonatomic)NSString * state;

@property (copy,nonatomic)NSString * uuid;

@property (nonatomic)NSNumber * rssi;

-(void)setGray;
@end
