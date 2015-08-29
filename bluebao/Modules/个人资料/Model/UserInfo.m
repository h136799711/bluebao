//
//  UserInfo.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/8.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(NSString *)nickname{
    
    if(self->_nickname == nil || self->_nickname.length == 0){
        return self.username;
    }
    
    return self->_nickname;
}

-(id)initWithUserInfoDictionary:(NSDictionary * )diction{
    
    self = [super init];
    if (self) {
        _birthday = [diction objectForKey:@"birthday"];
        _height = [[diction valueForKey:@"height"] integerValue];
        _nickname = [diction valueForKey:@"nickname"];
        _sex = [[diction valueForKey:@"sex"] integerValue];
        _weight = [[diction valueForKey:@"weight"] integerValue];
        _uid = [[diction valueForKey:@"uid"] integerValue];
        _username = [diction valueForKey:@"username"];
        _target_weight = [[diction valueForKey:@"target_weight"] integerValue];
        _signature = [diction valueForKey:@"signature"];
        _continuous_day = [[diction valueForKey:@"continuous_day"] integerValue];
        NSInteger  year = [[MyTool getCurrentDateFormat:@"yyyy"] integerValue];
        
//        DLog(@" --_bring%ld--year %ld---",[_birthday integerValue],year);
//        _age =  year+10 - [_birthday integerValue];
        if(_birthday.length > 4){
            _age = year +1 - [[_birthday substringWithRange:NSMakeRange(0, 4)] integerValue];
        }
//        DLog(@"age=%ld",(long)self.age);
    }
    
    return self;
}
//+(id)initUserInfoDictionary:(NSDictionary *)diction{
//
//  return  [super initUserInfoDictionary:diction];
//}

@end
