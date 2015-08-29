//
//  GoalData.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/20.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "GoalData.h"

@implementation GoalData

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        
    }
    return self;
}



-(void)setTimestr:(NSString *)timestr{
    
    _timestr = timestr;
    
    NSMutableString * string = [[NSMutableString alloc] initWithString:timestr];
    NSArray * timearray = [string componentsSeparatedByString:@":"];
    NSInteger hour = [[timearray firstObject] integerValue];
    NSInteger mine = [[timearray lastObject] integerValue];
    _maxIndex = hour * 60 + mine;
//    DLog(@"\r timestr :%@ \r hour: %ld  \r mine %ld  %ld",timestr,(long)hour,mine,self.maxIndex);
    
}


//编码方法，把People对象编码为二进制数据。
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    //在编码方法中，需要对这个类的每一个属性进行编码。
    [aCoder encodeObject:_timestr forKey:@"goal_time"];
    [aCoder encodeInteger:_goalID forKey:@"goal_ID"];
    [aCoder encodeInteger:_goalNumber forKey:@"goalNumbe"];
    [aCoder encodeInteger:_maxIndex forKey:@"maxIndex"];
    [aCoder encodeObject:_dateTime forKey:@"dateTime"];
}

//解码方法，把二进制数据转化为People对象。
- (id)initWithCoder:(NSCoder *)aDecoder{
    //在解码方法中，需要对每一个属性进行解码。
    self = [super init];
    if (self) {
        _timestr = [[aDecoder decodeObjectForKey:@"goal_time"] copy];
        _goalID = [aDecoder decodeIntegerForKey:@"goal_ID"];
        _goalNumber = [aDecoder decodeIntegerForKey:@"goalNumbe"];
        _maxIndex = [aDecoder decodeIntegerForKey:@"maxIndex"];
        _dateTime = [aDecoder decodeObjectForKey:@"_dateTime"];
    }
    return self;
}


//创建默认目标 
+(GoalData *) defauleGoal{
    GoalData * data = [[self alloc] init];
    data.goalNumber = 500;
    data.timestr = @"00:00";
    return data;
}

@end
