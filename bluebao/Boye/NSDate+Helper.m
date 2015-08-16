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
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    formatter.locale = locale;
    return formatter;
}

+(NSString *)defaultDateTimeFormatString{
    return @"yyyy-MM-dd hh:mm:ss";
}

+(NSString *)defaultDateFormatString{
    return @"yyyy-MM-dd";
}

+(NSString *)defaultTimeFormatString{
    return @"hh:mm:ss";
}


-(NSString *)defaultTimeFormatString{
    return @"hh:mm:ss";
}

-(BOOL) isToday{
    
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    formatter.dateFormat = [NSDate defaultDateFormatString];
    NSDate *newdate = [NSDate date];
    NSString * newDateString = [formatter stringFromDate:newdate];
    NSString * nowDateString = [formatter stringFromDate:self];

    if ([newDateString isEqualToString:nowDateString]) {
        return YES;
    }else{
        return NO;
    }
}

//日期转化为时间戳
-(NSNumber *)dateDayTimeStamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = [NSDate defaultDateFormatString];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];

    NSString * timestr = [formatter stringFromDate:self];
    NSDate * date = [formatter dateFromString:timestr];   //yyy-MM-dd 格式

    NSNumber * number = [NSDate date2UnixTimeStamp:date];
  //  NSLog(@"******************************************");
  //   NSLog(@"  number  -%@- %@ ",timestr,number);
    
//    [NSDate getDateFromeNumber:number];
    //    NSLog(@"******************************************");
    
    return number;
}
//时间戳转化为日期
+(NSDate *) getDateFromeNumber:(NSNumber *)number{
    
    NSTimeInterval time = [number doubleValue] + 8*3600;
    NSDate * detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSLog(@"  number  -- %@ -- %@ ",number,detaildate);

    return detaildate;
}



//某个时间是否超过设定时间
-(BOOL)isOutSetDateTime:(NSDate *)newDate{
   
    NSLog(@" == currentData %@  === setingDate %@== ",self,newDate);
    if ([self compare:newDate] == NSOrderedAscending) {
       
        return NO;
    }
    return YES;
}

//当前时间是否超过某个设定时间
+(BOOL) currDateIsOutSetingTime:(NSDate *)date{
    
   return   [[NSDate date] isOutSetDateTime:date];
}

//时间转化小时，分钟，秒
+(NSString *) getDateHour:(NSTimeInterval )time{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    //转化为 yyyy-mm --dd 日期
    formatter.dateFormat = [NSDate  defaultDateFormatString];
    NSString * dstr = [formatter stringFromDate:[NSDate date]];
    //新日期
    NSDate * date = [[formatter dateFromString:dstr] dateByAddingTimeInterval:time];
    //新格式 hh:mm:ss
//    formatter.dateFormat = @"mm:ss";
    formatter.dateFormat = [NSDate defaultTimeFormatString];
    NSString * datestr = [formatter stringFromDate:date];
    NSLog(@" date %@  %f ",datestr,time);
    return datestr;
}

@end
