//
//  DeviceInfoCell.m
//  Bluetooth
//
//  Created by hebidu on 15/7/17.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "DeviceInfoCell.h"

@interface DeviceInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblUUID;
@property (weak, nonatomic) IBOutlet UILabel *lblState;

@end

@implementation DeviceInfoCell

-(void)setRssi:(NSNumber *)rssi{
    _rssi = rssi;
    [self.lblState.text stringByAppendingFormat:@" 信号:%@",_rssi ];
}

-(void)setState:(NSString *)state{
    _state = state;
    self.lblState.text = state;
}

-(void)setName:(NSString *)name{
    _name = name;
    self.lblName.text = name;
}
-(void)setUuid:(NSString *)uuid{
    _uuid = uuid;
    self.lblUUID.text = uuid;
}
- (void)awakeFromNib {
//    // Initialization code
//    UILabel * lbl = (UILabel *) self.lblName;
//    if(lbl != nil){
//        lbl.text = self.name;
//    }
//
//    lbl = (UILabel *) self.lblUUID;
//    if(lbl != nil){
//        lbl.text = self.uuid;
//    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setGray{
    self.lblName.textColor = [UIColor grayColor];
    self.lblState.textColor = [UIColor grayColor];
    self.lblUUID.textColor = [UIColor grayColor];
}
@end
