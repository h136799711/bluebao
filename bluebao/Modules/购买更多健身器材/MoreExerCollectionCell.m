//
//  MoreExerCollectionCell.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/16.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "MoreExerCollectionCell.h"

@implementation MoreExerCollectionCell



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //imageView
        self.webImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.width)];

        self.webImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.webImageView];
        
        //label
        self.webLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.webImageView.bottom, self.webImageView.width, self.contentView.height - self.webImageView.height)];
        self.webLabel.font = FONT(15);
        self.webLabel.textAlignment = NSTextAlignmentCenter;
        self.webLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.webLabel];
        
        
        
    }
    return self;
}

@end
