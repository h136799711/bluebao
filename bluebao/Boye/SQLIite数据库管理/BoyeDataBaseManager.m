//
//  BoyeDataBaseManager.m
//  bluebao
//
//  Created by boye_mac1 on 15/8/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeDataBaseManager.h"
#import "FMDatabase.h"

static FMDatabase *__db;
#define FILE_M [NSFileManager defaultManager]

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
        
    });
    return dataBase;
}

//数据库初始化
+ (void)initDatabase{
    //把数据库文件从工程文件及中赋值到Documents中
    NSString *sandBoxPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/lanbaoDtaBase.sqlite"];
    if (![FILE_M fileExistsAtPath:sandBoxPath]) {
        NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"lanbao" ofType:@"sqlite"];
        [FILE_M copyItemAtPath:databasePath toPath:sandBoxPath error:nil];
    }
    
    if (!__db) {
        __db = [[FMDatabase alloc] initWithPath:sandBoxPath];
    }
}

//保护数据库安全
+(void) safeDataBase{
    //初始化数据库
    [self initDatabase];

    if ([__db open]) {
        [__db close];
    }
}

//解析目标模型
+(BoyeGoaldbModel *) getGoalModel:(FMResultSet * )set{
    
    BoyeGoaldbModel *record = [[BoyeGoaldbModel alloc] init];
    record.db_id = [set intForColumn:@"id"];
    record.target = [set intForColumn:@"target"];
    record.date_time = [set stringForColumn:@"date_time"];
    record.uid = [set intForColumn:@"uid"];
    record.weekday = [set intForColumn:@"weekday"];
    record.create_time = [set stringForColumn:@"create_time"];
    return record;
}


//插入一条数据
+ (void)insertGoalWithDate:(BoyeGoaldbModel *) model{
    
    [self safeDataBase];

    NSString *sql = [NSString stringWithFormat:@"INSERT INTO lanbao_target (target,date_time,uid,weekday,create_time)VALUES(%ld,'%@',%ld,%ld,'%@')",model.target,model.date_time,(long)model.uid,model.weekday,model.create_time];

    [__db open];
    [__db executeUpdate:sql];
    [__db close];
    
}


//读取数据
+(NSArray *) getGoalDataUserID:(NSInteger) uid week:(NSInteger) weekday{
  
    [self safeDataBase];
    [__db open];

    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target WHERE uid = %ld AND weekday = %ld",uid,weekday];
    
    FMResultSet *set = [__db executeQuery:sql];
        NSMutableArray *array = [NSMutableArray array];
        while ([set next]) {

            [array addObject:[self getGoalModel:set]];
            
        }
        [set close];
    [__db close];
    
    return array;
}

//获得所有数据
+(NSArray *) getAllDataUserID:(NSInteger)uid{
    
    [self safeDataBase];
    [__db open];
    
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target uid = %ld",uid];
    
    FMResultSet *set = [__db executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        [array addObject:[self getGoalModel:set]];
    }
    [set close];
    [__db close];
    
    return array;
}
//获得所有数据
+(NSArray *) getAllData{
    
    [self safeDataBase];
    [__db open];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target"];
    FMResultSet *set = [__db executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        [array addObject:[self getGoalModel:set]];
    }
    [set close];
    [__db close];
    
    return array;
}

//删除数据
+(void) deleteDataID:(NSInteger)db_id {
    
    
    [self safeDataBase];
    NSString * sql = [NSString stringWithFormat:@"DELETE FROM lanbao_target WHERE id = %ld",db_id];
    [__db open];
  
    [__db executeUpdate:sql];
    [__db close];
}
//搜索数据
+(BoyeGoaldbModel*) selectDataID:(NSInteger)db_id {
    
    
    [self safeDataBase];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target WHERE id = %ld",db_id];
    [__db open];
    BoyeGoaldbModel *record;
    FMResultSet * set = [__db executeQuery:sql];
   
    if ([set next]) {
        record = [self getGoalModel:set];
    }
    
    [set close];
    [__db close];
    return record;
    
}

//搜索数据
+(BoyeGoaldbModel*) selectDataModel:(BoyeGoaldbModel*)model{
    
    [self safeDataBase];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target WHERE uid = %ld AND  weekday = %ld AND date_time = '%@'",model.uid,model.weekday,model.date_time];
    [__db open];
    BoyeGoaldbModel *record;
    FMResultSet * set = [__db executeQuery:sql];
    
    if ([set next]) {
        record = [self getGoalModel:set];
    }
    
    [set close];
    [__db close];
    return record;
}
//查询数据 id
+(NSInteger)selectedDateModelID:(BoyeGoaldbModel *)model{
    
    BoyeGoaldbModel * selectModel = [self selectDataModel:model];
    if (model!= nil) {
        return selectModel.db_id;
    }
    return 0;
}



//删除数据
+(void)deleteAllData{
    NSString * sql = [NSString stringWithFormat:@"DELETE FROM lanbao_target"];
    
    [self safeDataBase];
    [__db open];
    [__db executeUpdate:sql];
    [__db close];

    
}
//(target,date_time,uid,weekday,create_time)VALUES(%ld,'%@',%ld,%ld,'%@')"
//判断数据是否存在
+(BOOL )isExistUserGoal:(BoyeGoaldbModel *) model{
    
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target WHERE uid = %ld AND  weekday = %ld AND date_time = '%@'",model.uid,model.weekday,model.date_time];
    
    
    return [self isDataExistSQL:sql ];
}

//数据是否存在
+(BOOL) isDataExistSQL:(NSString  *)sql{
    
    [self safeDataBase];
    [__db open];
    BOOL   isExist = NO;
    
    FMResultSet *set = [__db executeQuery:sql];
    if ([set next]) {
        
        isExist = YES;
        NSLog(@"yes");
    }else{

    NSLog(@"no");
    }
    [set close];
    [__db close];
    return isExist;
}

//修改数据
+(void) alertData:(BoyeGoaldbModel *)model{
    
    NSString * sql = [NSString stringWithFormat:@"UPDATE lanbao_target SET date_time = '%@' , target = %ld WHERE id = %ld ",model.date_time,model.target,model.db_id];
  
    [self safeDataBase];
    [__db open];
    [__db executeUpdate:sql];
    
    [__db close];
}

+(void) test:(NSArray *)array{
    
    for (BoyeGoaldbModel * model in array) {
        NSLog(@"id %ld",model.db_id);
        NSLog(@"target %ld",model.target);
        NSLog(@"date_time %@",model.date_time);
        NSLog(@"uid %ld",model.uid);
        NSLog(@"weekday %ld",model.weekday);
        NSLog(@"create_time %@ ",model.create_time);
    }
    
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
