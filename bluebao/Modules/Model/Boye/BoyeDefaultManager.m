//
//  BoyeDefaultManager.m
//  AFNTest
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeDefaultManager.h"

@interface BoyeDefaultManager()

//@property(nonatomic ,strong) NSString* name;


@end

@implementation BoyeDefaultManager



+(NSDateFormatter *)getDateFormatter:(NSString *)format{
    
    
    if(format == nil){
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    return formatter;
}

@end
