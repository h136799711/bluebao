//
//  HeadCollectionViewCell.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/10.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "HeadCollectionViewCell.h"
 
@implementation HeadCollectionViewCell{
    
    UILabel           * _infoLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self ) {
//        self.backgroundColor = [UIColor redColor];
        
        //指标
        CGFloat  s_nit = 20;

        self.labelSort = [[UILabel alloc] init];
        self.labelSort.bounds = CGRectMake(0, 0, self.contentView.width+10, s_nit);
        self.labelSort.center = CGPointMake(self.contentView.width/2.0, self.contentView.height-self.labelSort.height/2.0);
        self.labelSort.textColor =[UIColor colorWithHexString:@"#888888"];
//        self.labelSort.backgroundColor = [UIColor yellowColor];
        self.labelSort.textAlignment = NSTextAlignmentCenter;
        self.labelSort.font = FONT(13);
        [self.contentView addSubview:self.labelSort];
        
        
        //数值
        _infoLabel= [[UILabel alloc] init];
        _infoLabel.bounds = CGRectMake(0,0,40,35);
        _infoLabel.center = CGPointMake(self.contentView.width/2.0,self.labelSort.top - _infoLabel.height/2.0+5);
        _infoLabel.textColor = [UIColor colorWithHexString:@"#74e7f8"]; //
        _infoLabel.font = FONT(28);
       _infoLabel.textAlignment = NSTextAlignmentCenter;

        [self.contentView addSubview:_infoLabel];
        
        //单位
        CGFloat  h_unit = 15;
        self.labelUnit = [[UILabel alloc] init];
        self.labelUnit.bounds = CGRectMake(0,0 , 15, h_unit);
        self.labelUnit.center = CGPointMake(_infoLabel.right + self.labelUnit.width/2.0, _infoLabel.center.y+2);
//        self.labelUnit.textColor =[UIColor blackColor];
        
        self.labelUnit.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.labelUnit];
         self.labelUnit.font = FONT(13);
    }
    return self;
}

-(void)setInfoValue:(NSInteger)infoValue{
    _infoLabel.text = [NSString stringWithFormat:@"%d",(int)infoValue];
    
}

@end
