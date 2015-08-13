//
//  BoyeDataBaseManager.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeDataBaseManager.h"

@interface BoyeDataBaseManager (){
    
   
}
@end

static  SQLiteManager   * sqlManager;

@implementation BoyeDataBaseManager

+(BoyeDataBaseManager *) sharedataBaseManager{
    
    static BoyeDataBaseManager *dataBase;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataBase = [[BoyeDataBaseManager alloc] init];
        sqlManager = [[SQLiteManager alloc] initWithDatabaseNamed:@"boye_goalDataBase"];
        
    });
    return dataBase;
}

//打开数据库
+(void)open{
    [sqlManager openDatabase];
}
//关闭数据库
+(void)close{
    
    [sqlManager closeDatabase];
}


-(void) createdTable{
    
}
@end
