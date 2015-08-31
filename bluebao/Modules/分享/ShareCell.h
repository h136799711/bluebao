//
//  ShareCell.h
//  bluebao
//
//  Created by boye_mac1 on 15/8/14.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareCell : UITableViewCell
@property (nonatomic,strong) UIImageView        * headImageView;
@property (nonatomic,strong) UILabel            * labelValueNum;
@property (nonatomic,copy) NSString *             valueNum;

@property (nonatomic,strong) UILabel            * labelSort;
@property (nonatomic,strong) UILabel            * labelUnit;


@end
