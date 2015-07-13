//
//  MessageCell.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //label1
        self.label_sort = [[UILabel alloc] init];
        self.label_sort.frame = CGRectMake(30, 0, SCREEN_WIDTH/2.0 -30, self.contentView.height);
        self.label_sort.font = FONT(15);
        [self.contentView addSubview:self.label_sort];
        
        
        //label2
        self.label_value = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0-30, self.contentView.height)];
        
        self.label_value.textAlignment = NSTextAlignmentRight;
        self.label_value.font = FONT(15);
        [self.contentView addSubview:self.label_value];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
