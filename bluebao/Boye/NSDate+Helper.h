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

/**
 *是否是今天
 *
 */

-(BOOL) isToday;

/*
 *时间转化为时间戳 ，yyyy-MM-dd
 */
-(NSNumber *)dateDayTimeStamp;

/*
 *时间戳转化为时间 yyyy-MM-dd
 */
+(NSDate *) getDateFromeNumber:(NSNumber *)number;

/*
 *是否超过设定时间 ，yes，超过，no ，没有
 */
-(BOOL)isOutSetDateTime:(NSDate *)newDate;

/*
 *当前时间是否超过某个设定时间 ，yes，超过，no ，没有
 */
+(BOOL) currDateIsOutSetingTime:(NSDate *)date;
/**
 * 时间转化小时，分钟，秒
 */

+(NSString *) getDateHour:(NSTimeInterval )time;

//默认日期格式
+(NSString *)defaultDateTimeFormatString;

/**
 获得当前星期 0-6，周一-周日
 */

+(NSInteger) getcurrentWeekDay;

@end
