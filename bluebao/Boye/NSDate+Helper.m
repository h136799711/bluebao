//
//  NSDate+Helper.m
//  Bluetooth
//
//  Created by hebidu on 15/7/18.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

+(NSNumber *)currentTimeStamp{
    
    NSTimeInterval  interval =  [[NSDate defaultCurrentDate] timeIntervalSince1970];
    return [[NSNumber alloc] initWithDouble:interval];
}

+(NSDate *) defaultCurrentDate{
//    NSDateFormatter *formatter = [NSDate defaultDateFormatter];
    return [NSDate date];
}

+(NSNumber *) date2UnixTimeStamp:(NSDate *)date{
    
    NSTimeInterval  interval =  [date timeIntervalSince1970];
    
    return [[NSNumber alloc]initWithDouble:interval];
}


+(NSDateFormatter *)defaultDateFormatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = [NSDate defaultDateTimeFormatString];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    return formatter;
}

+(NSString *)defaultDateTimeFormatString{
    return @"yyyy-MM-dd hh:mm:ss";
}

+(NSString *)defaultDateFormatString{
    return @"yyyy-MM-dd";
}

-(NSString *)defaultTimeFormatString{
    return @"hh:mm:ss";
}

@end
