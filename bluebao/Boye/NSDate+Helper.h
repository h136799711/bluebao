//
//  NSDate+Helper.h
//  Bluetooth
//
//  Created by hebidu on 15/7/18.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate  (Helper)

/**
 *  返回默认时间格式
 *
 *  @return <#return value description#>
 */
+(NSDateFormatter *)defaultDateFormatter;
/**
 *  默认GMT 8
 *
 *  @return 日期
 */
+(NSDate *)defaultCurrentDate;

/**
 *  日期转Unix时间戳
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+(NSNumber *)date2UnixTimeStamp:(NSDate *)date;
/**
 *  当前时间戳 距离1970 经过的秒数
 *
 *  @return NSNumber
 */
+(NSNumber *)currentTimeStamp;
@end
