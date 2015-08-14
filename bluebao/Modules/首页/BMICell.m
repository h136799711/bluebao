//
//  BMICell.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/10.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BMICell.h"

@implementation BMICell{
    
    UILabel * weightLabel;    //体重
    UILabel * weightValueLabel; //体重值
    UILabel * bMILabel; // bim
    UILabel * bMIValueLabel;
    UILabel * bMITargetLabel;
    UILabel * middleLabel;//中间线
    NSArray  * array ;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.height = 56;
        array = @[@"体重",@"BMI",@"正常"];
       
        //顶部线条
        UILabel * topLabel = [self line:0];
        [self.contentView addSubview:topLabel];
        
        //底部线条
        UILabel * botLabel = [self line: self.contentView.height - 1];
        [self.contentView addSubview:botLabel];
        
        //中间线
        middleLabel = [[UILabel alloc] init];
        middleLabel.frame = CGRectMake(SCREEN_WIDTH/2.0, 0, 1, self.contentView.height);
        [self.contentView addSubview:middleLabel];
        middleLabel.backgroundColor = [UIColor colorWithHexString:@"#babbb8"];
        
        //体重
//        [self creatlabel:weightLabel text:array[0]];
        weightLabel = [[UILabel alloc] init];
        weightLabel.bounds = CGRectMake(0, 0, 40, 60);
        weightLabel.center = CGPointMake(30+weightLabel.width/2.0, self.contentView.center.y);
        weightLabel.text = array[0];
        weightLabel.font = FONT(15);

        [self.contentView addSubview:weightLabel];
        
        
        //体重值
        weightValueLabel = [[UILabel alloc] init];
        weightValueLabel.bounds = CGRectMake(0, 0, middleLabel.left - weightLabel.right - 20 , self.contentView.height);
        weightValueLabel.center = CGPointMake(weightLabel.right + weightValueLabel.width/2.0, weightLabel.center.y);
        weightValueLabel.font = FONT(20);
        weightValueLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:weightValueLabel];
        
       // NSLog(@"√");
        
        //BMI
        bMILabel = [[UILabel alloc] init];
        bMILabel.text = array[1];
        bMILabel.bounds = CGRectMake(0, 0, 40, 60);
        bMILabel.center = CGPointMake(middleLabel.right + 15 + bMILabel.width/2.0, weightLabel.center.y);
        [self.contentView addSubview:bMILabel];

        //BMI指标
        bMITargetLabel = [[UILabel alloc] init];
        bMITargetLabel.text = array[2];
        bMITargetLabel.bounds = CGRectMake(0, 0, 35, 60);
        bMITargetLabel.center = CGPointMake(SCREEN_WIDTH - 15 - bMILabel.width/2.0, weightLabel.center.y);
        [self.contentView addSubview:bMITargetLabel];

        //BMI值
        bMIValueLabel = [[UILabel alloc] init];
        bMIValueLabel.bounds = CGRectMake(0, 0, bMITargetLabel.left - bMILabel.right, self.contentView.height);
        bMIValueLabel.center = CGPointMake(bMILabel.right + bMIValueLabel.width/2.0, bMITargetLabel.center.y);
        [self.contentView addSubview:bMIValueLabel];
        bMIValueLabel.font = FONT(20);
        bMIValueLabel.textAlignment = NSTextAlignmentCenter;
       // [MyTool testViews:bMILabel];[MyTool testViews:bMIValueLabel];[MyTool testViews:bMITargetLabel];
        
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
//
//设置体重
-(void)setWeight:(CGFloat)weight{

    weightValueLabel.text = [NSString stringWithFormat:@"%.1f",weight];
    
}
//////设置BMI
-(void)setBmiValue:(CGFloat)bmiValue{
   
    bMIValueLabel.text = [NSString stringWithFormat:@"%.1f",bmiValue];
    bMITargetLabel.text = [MyTool getBMITarget:bmiValue];
}



#pragma mark -- label --

//线
-(UILabel *)line:(CGFloat)height{
    
    UILabel * label = [[UILabel alloc] init];
    label.frame =CGRectMake(0, height, SCREEN_WIDTH, 0.5);
    label.backgroundColor =[UIColor colorWithHexString:@"#babbb8"];
    return label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
