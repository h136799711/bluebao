//
//  ShareCell.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/14.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "ShareCell.h"

@implementation ShareCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.width = SCREEN_WIDTH;
        [self _initViews];
    }
    return self;
}
-(void)_initViews{
    
    CGFloat  left = 60;
    CGFloat  right = 75;
    //头像
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.bounds = CGRectMake(0, 0, 30, 30);
    self.headImageView.center = CGPointMake(left + self.headImageView.width/2.0, self.contentView.center.y);
    [self.contentView addSubview:self.headImageView];
    
    // 方式
    self.labelSort = [[UILabel alloc] init];
    self.labelSort.bounds = CGRectMake(0, 0, 60, 30);
    self.labelSort.center = CGPointMake(self.headImageView.right + self.labelSort.width/2.0+15, self.headImageView.center.y);
    self.labelSort.font = FONT(20);
    self.labelSort.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.labelSort];
//    [MyTool testViewsBackGroundView:self.labelSort colorNum:1];
    
    //单位
    self.labelUnit = [[UILabel alloc] init];
    self.labelUnit.bounds = CGRectMake(0, 0, 40, self.self.labelSort.height);
    self.labelUnit.center = CGPointMake(self.contentView.width - right - self.labelUnit.width/2.0, self.labelSort.center.y);
    self.labelUnit.font = FONT(20);
    self.labelUnit.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.labelUnit];
    
    //值
    CGFloat spacing = 4;
    CGFloat valueWidth = self.labelUnit.left - self.labelSort.right - spacing * 2 ;
    self.labelValueNum = [[UILabel alloc] init];
    self.labelValueNum.bounds = CGRectMake(0, 0, valueWidth, self.labelUnit.height);
    self.labelValueNum.center = CGPointMake(self.labelSort.right + spacing + self.labelValueNum.width/2.0 , self.labelUnit.center.y);
    self.labelValueNum.textColor = [UIColor colorWithHexString:@"#4ab4e4"];
    self.labelValueNum.font = FONT(22);
    self.labelValueNum.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.labelValueNum];
//    [MyTool testViewsBackGroundView:self.labelValueNum colorNum:2];
    
    //线
    UILabel * lineLabel = (UILabel *)[MyTool createLineInView:self.contentView fram:self.labelValueNum.frame];
    lineLabel.height = 1;
    lineLabel.top = self.labelSort.bottom -1;
    lineLabel.backgroundColor = self.labelValueNum.textColor;
    lineLabel.tag = 1008;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
