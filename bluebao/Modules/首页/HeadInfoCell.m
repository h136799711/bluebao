//
//  HeadInfoCell.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/10.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "HeadInfoCell.h"



@implementation HeadInfoCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.contentView.frame = CGRectMake(self.contentView.left, self.contentView.top, SCREEN_WIDTH, self.contentView.height);
        
        //图标
        self.signImageView = [[UIImageView alloc] init];
        self.signImageView.bounds = CGRectMake(0, 0, 30, 30);
        self.signImageView.center = CGPointMake(self.signImageView.width/2.0 + 20, self.contentView.center.y);
        [self.contentView addSubview:self.signImageView];
       
        //分类
        self.signLabelSort = [[UILabel alloc] init];
        self.signLabelSort.bounds = CGRectMake(0, 0, 100, self.contentView.height);
        CGFloat x = self.signImageView.right + 10 + self.signLabelSort.width/2.0;
        self.signLabelSort.center = CGPointMake(x, self.contentView.center.y);
        [self.contentView addSubview:self.signLabelSort];
        self.signLabelSort.textColor = [UIColor blackColor];
//        self.signLabelSort.text = @"1111";
        //值
        self.signLabelValue = [[UILabel alloc] init];
        self.signLabelValue.bounds = CGRectMake(0 ,0, 100, self.contentView.height);
        CGFloat vx = self.contentView.width-20-self.signLabelValue.width/2.0;
        self.signLabelValue.center = CGPointMake(vx, self.contentView.center.y);
        self.signLabelValue.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.signLabelValue];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
