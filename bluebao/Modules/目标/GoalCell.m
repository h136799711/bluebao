//
//  GoalCell.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "GoalCell.h"

@interface GoalCell (){
    
    NSInteger   _count ;
}


@end

@implementation GoalCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self _init];
    }
    return self;
}


-(void)_init{
    
    //修改
    
   _count = 4;
    
    CGFloat quarter =  SCREEN_WIDTH/_count;
    CGFloat left = 15;
    CGFloat width_btn = (quarter - left*2 - 12)/2.0;
    
    self.alterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.alterBtn.bounds = CGRectMake(0, 0, width_btn, width_btn);
    CGFloat  alt_x = quarter *3 + left + self.alterBtn.width/2.0;
    self.alterBtn.center = CGPointMake(alt_x, self.contentView.center.y);
    [self.alterBtn setBackgroundImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.alterBtn];
    
    //删除
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.bounds = CGRectMake(0, 0, self.alterBtn.width, self.alterBtn.height);
    CGFloat  delete_x = self.alterBtn.right + 6+ self.deleteBtn.width/2.0;
    self.deleteBtn.center = CGPointMake(delete_x, self.alterBtn.center.y);
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.deleteBtn];
    
    //竖线
    for (int i = 0; i < _count -1 ; i ++) {

        [MyTool createLineInView:self.contentView fram:CGRectMake(quarter* (i+1), 0, 1, self.contentView.height)];
    }
    
    [self creatLabel:self.timeLabel labeltext:@"16:30" num:0];
    [self creatLabel:self.goalLael labeltext:@"1000卡" num:1];
//    [self creatLabel:self.operateLael labeltext:@"0%" num:2];
    
    //横线
    [MyTool createLineInView:self.contentView fram:CGRectMake(0, self.contentView.bottom -1,SCREEN_WIDTH,1)];
}

-(void ) creatLabel:(UILabel *)label labeltext:(NSString *)string num:(int) place{
    
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.frame = CGRectMake(SCREEN_WIDTH/_count * place, -1, SCREEN_WIDTH/_count, self.contentView.height);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = string;
        label.font = FONT(15);
        [self.contentView addSubview:label];
        
        if (place == 0) {
            self.timeLabel = label;
        }else if (place == 1){
            self.goalLael = label;
        }else{
            self.operateLael = label;
        }
        
    }
    
}




@end
