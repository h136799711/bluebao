//
//  EquiMentCell.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "EquiMentCell.h"

@implementation EquiMentCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.height = 70;
        [self _inits];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)_inits{
    
    CGFloat   left = 20;
    //头像
    self.headImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bluetooth.png"]];
    self.headImage.bounds = CGRectMake(0, 0, 50, 50);
    self.headImage.center = CGPointMake(left + self.headImage.width/2.0, self.contentView.center.y);
    
    [self.contentView addSubview:self.headImage];
    
    //名称
    self.bundingLabel = [[UILabel alloc] init];
    self.bundingLabel.bounds = CGRectMake(0, 0, 60, 30);
    self.bundingLabel.center = CGPointMake(SCREEN_WIDTH - left - self.bundingLabel.width/2.0, self.contentView.bottom-self.bundingLabel.height/2.0-10);
    self.bundingLabel.font = FONT(15);
    self.bundingLabel.textColor = [UIColor lightGrayColor];
    self.bundingLabel.text = @"未绑定";
    self.bundingLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.bundingLabel];
    
    CGFloat  width = self.bundingLabel.left - self.headImage.right - 15;
    //名称
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImage.right + 10, self.headImage.top+3, width, 25)];
    self.nameLabel.font = FONT(16);
    self.nameLabel.text = @"动感单车家用脚踏车";
    [self.contentView addSubview:self.nameLabel];
    
    //型号
    CGFloat  spacing = 20;
    self.modelLabel = [[UILabel alloc]init];
    self.modelLabel.frame = CGRectMake(self.nameLabel.left + spacing, self.nameLabel.bottom, width - 30, 15);
    self.modelLabel.text = @"OTO458-1082";
    self.modelLabel.font = FONT(13);
    [self.contentView addSubview: self.modelLabel];
    
    
    //线
    [MyTool createLineInView:self.contentView fram:CGRectMake(0, self.contentView.height, SCREEN_WIDTH, 1)];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
