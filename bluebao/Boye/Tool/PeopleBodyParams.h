//
//  PeopleBodyParams.h
//  bluebao
//
//  Created by hebidu on 15/8/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleBodyParams : NSObject


/**
 *  获取体脂肪率
 *  计算公式：
 *  ①BMI=体重（公斤）÷（身高×身高）（米）
 *  ②体脂率：1.2×BMI+0.23×年龄-5.4-10.8×性别（男为1，女为0
 *
 *  @param age    年龄
 *  @param sex    性别(0: 女 1:男)
 *  @param weight 体重（单位：公斤）
 *  @param height 身高(单位： 米)
 *
 *  @return 体脂肪率
 */
+(NSInteger )getBodyFatRateBy:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height;


/**
 *  获取人体水分含量
 *
 *  @param age    年龄
 *  @param sex    性别(0: 女 1: 男)
 *  @param weight 体重
 *  @param height 身高
 *
 *  @return 体水分含量
 */
+(NSInteger )getBodyWaterRateBy:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height;

/**
 *  获取体年龄
 *
 *  @param age    年龄
 *  @param sex    性别(0: 女 1: 男)
 *  @param weight 体重
 *  @param height 身高
 *
 *  @return 体年龄
 */
+(NSInteger )getBodyAge:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height;

/**
 *  获取基础代谢率
 *
 *  @param age    年龄
 *  @param sex    性别(0: 女 1: 男)
 *  @param weight 体重
 *  @param height 身高
 *
 *  @return 基础代谢率
 */
+(NSInteger )getBasalMetabolicRate:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height;

/**
 *  获取 肌肉含量
 *
 *  @param age    年龄
 *  @param sex    性别(0: 女 1: 男)
 *  @param weight 体重
 *  @param height 身高
 *
 *  @return 肌肉含量
 */
+(NSInteger )getMusclePate:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height;

/**
 *  获取 内脏含量
 *
 *  @param age    年龄
 *  @param sex    性别(0: 女 1: 男)
 *  @param weight 体重
 *  @param height 身高
 *
 *  @return 内脏含量
 */
+(NSInteger )getViscusPate:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height;

/**
 *  获取 骨骼含量
 *
 *  @param age    年龄
 *  @param sex    性别(0: 女 1: 男)
 *  @param weight 体重
 *  @param height 身高
 *
 *  @return 骨骼含量
 */
+(NSInteger )getSkeletonRate:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height;


/**
 *  获取 皮下脂肪率
 *
 *  @param age    年龄
 *  @param sex    性别(0: 女 1: 男)
 *  @param weight 体重
 *  @param height 身高
 *
 *  @return 皮下脂肪率
 */
+(NSInteger )getSubcutaneousFatRate:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height;



@end
