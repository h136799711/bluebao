//
//  LeftMenuCell.m
//  蜜吧
//
//  Created by ywang on 15/4/16.
//  Copyright (c) 2015年 嘉诚曼联. All rights reserved.
//

#import "LeftMenuCell.h"


@interface LeftMenuCell ()
@property(nonatomic, strong) UILabel *menuTitleLabel;
@property(nonatomic, strong) UIImageView *menuImageView;

@end


@implementation LeftMenuCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _menuImageView = [[UIImageView alloc] initWithFrame:(CGRect){{15, 6},{42,42}}];
        [self.contentView addSubview:_menuImageView];
        
        _menuTitleLabel = [[UILabel alloc] initWithFrame:(CGRect){{_menuImageView.right + 5, _menuImageView.top},{100, 42}}];
//        _menuTitleLabel.font = FONT(17);
        [self.contentView addSubview:_menuTitleLabel];
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMenu:(LeftMenu *)leftMenu
{
    _menuTitleLabel.text = leftMenu.title;

    if(leftMenu.isFocus)
    {
        _menuImageView.image = [UIImage imageNamed:leftMenu.focusImage];
        _menuTitleLabel.textColor = [UIColor colorWithRGBHex:leftMenu.focusColor];
    }
    else
    {
        _menuImageView.image = [UIImage imageNamed:leftMenu.normalImage];
        _menuTitleLabel.textColor = [UIColor colorWithRGBHex:leftMenu.normalColor];
    }
    
}

@end
