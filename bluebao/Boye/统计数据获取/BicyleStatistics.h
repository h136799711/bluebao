//
//  BicyleStatistics.h
//  bluebao
//
//  Created by hebidu on 15/8/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BicyleStatistics : NSObject


/**
 *  查询累计总成绩
 *
 *  @param uid 用户ID
 */
+(void) queryTotalResult:(NSNumber *)uid :(void(^)(id ))success :(void(^)(NSString * ))failure;

/**
 *  查询个人最好成绩
 *
 *  @param uid 用户ID
 */
+(void) queryBestResult:(NSNumber *)uid :(void(^)(id ))success :(void(^)(NSString * ))failure;

@end
