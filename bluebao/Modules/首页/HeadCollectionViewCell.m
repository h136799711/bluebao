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
        
        //分类
        CGFloat  s_nit = 20;

        self.labelSort = [[UILabel alloc] init];
        self.labelSort.bounds = CGRectMake(0, 0, self.contentView.width, s_nit);
        self.labelSort.center = CGPointMake(self.contentView.width/2.0, self.contentView.height-self.labelSort.height/2.0);
        self.labelSort.textColor =[UIColor colorWithHexString:@"#888888"];
        self.labelSort.textAlignment = NSTextAlignmentCenter;
        self.labelSort.font = FONT(12);
        [self.contentView addSubview:self.labelSort];
        
        
        //数值
        _infoLabel= [[UILabel alloc] init];
        _infoLabel.bounds = CGRectMake(0,0,self.contentView.width - 10,self.contentView.height - self.labelSort.height);
        _infoLabel.center = CGPointMake(_infoLabel.width/2.0, _infoLabel.height/2.0);
        _infoLabel.textColor = [UIColor colorWithHexString:@"#74e7f7"];
        _infoLabel.font = FONT(25);
       _infoLabel.textAlignment = NSTextAlignmentCenter;

        [self.contentView addSubview:_infoLabel];
        
        //单位
        CGFloat  h_unit = 10;
        self.labelUnit = [[UILabel alloc] init];
        self.labelUnit.frame = CGRectMake(_infoLabel.right+1 , _infoLabel.center.y , 7, h_unit);
        self.labelUnit.textColor =[UIColor colorWithHexString:@"#d9d3ae"];
        self.labelUnit.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.labelUnit];

    }
    return self;
}

-(void)setInfoValue:(NSInteger)infoValue{
    _infoLabel.text = [NSString stringWithFormat:@"%d",(int)infoValue];
    
}

@end
