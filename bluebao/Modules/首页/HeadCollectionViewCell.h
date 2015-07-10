//
//  HeadCollectionViewCell.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/10.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign) NSInteger      infoValue;
@property (nonatomic,strong) UILabel        * labelSort;
@property (nonatomic,strong) UILabel        * labelUnit;

@end
