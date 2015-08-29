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

    NSString *sql = [NSString stringWithFormat:@"INSERT INTO lanbao_target (target,date_time,uid,weekday,create_time)VALUES(%ld,'%@',%ld,%ld,'%@')",(long)model.target,model.date_time,(long)model.uid,(long)model.weekday,model.create_time];

    [__db open];
    [__db executeUpdate:sql];
    [__db close];
    
}


//读取数据
+(NSArray *) getGoalDataUserID:(NSInteger) uid week:(NSInteger) weekday{
  
    [self safeDataBase];
    [__db open];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target WHERE uid = %ld AND weekday = %ld",(long)uid,(long)weekday];
    
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
    
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray  *arr = [self getAllData];
    for (BoyeGoaldbModel * model in arr) {
        if (model.uid == uid) {
            [array addObject:model];
        }
    }
    DLog(@" -- %ld --",(long)uid);
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
    NSString * sql = [NSString stringWithFormat:@"DELETE FROM lanbao_target WHERE id = %ld",(long)db_id];
    [__db open];
  
    [__db executeUpdate:sql];
    [__db close];
}
//搜索数据
+(BoyeGoaldbModel*) selectDataID:(NSInteger)db_id {
    
    
    [self safeDataBase];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target WHERE id = %ld",(long)db_id];
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
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target WHERE uid = %ld AND  weekday = %ld AND date_time = '%@'",(long)model.uid,(long)model.weekday,model.date_time];
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
        DLog(@"  select id %ld  ",(long)selectModel.db_id);
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
    
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM lanbao_target WHERE uid = %ld AND  weekday = %ld AND date_time = '%@'",(long)model.uid,(long)model.weekday,model.date_time];
    
    
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
        DLog(@"yes");
    }else{

    DLog(@"no");
    }
    [set close];
    [__db close];
    return isExist;
}

//修改数据
+(void) alertData:(BoyeGoaldbModel *)model{
    
    NSString * sql = [NSString stringWithFormat:@"UPDATE lanbao_target SET date_time = '%@' , target = %ld WHERE id = %ld ",model.date_time,(long)model.target,(long)model.db_id];
  
    [self safeDataBase];
    [__db open];
    [__db executeUpdate:sql];
    
    [__db close];
}

+( NSInteger ) getMin:(NSArray * )goalArray {
    
    BoyeGoaldbModel * minModel = [goalArray objectAtIndex:0];
    NSInteger  maxIndex = 0;
    
    for  (NSInteger j = 0 ;j < goalArray.count; j++) {
     
        BoyeGoaldbModel  * nextModel = [goalArray objectAtIndex:j];
        if (minModel.goalIndex > nextModel.goalIndex) {
            minModel = nextModel;
            maxIndex = j;
        }
    }
    return maxIndex;
}

+(BoyeGoaldbModel *) getNearlyNotifyGoalOfUser:(NSInteger)uid{
    NSInteger weekDay =[NSDate getcurrentWeekDay];
    NSArray * arr = [self getGoalDataUserID:uid week:weekDay];
   //放到可变数组 goalArray中
    NSMutableArray * goalArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableArray * pax = [[NSMutableArray alloc] initWithCapacity:0];

    if (arr == nil) {
        return [[BoyeGoaldbModel alloc] init];
    }else{
        for (BoyeGoaldbModel * model in arr) {
            [goalArray addObject:model];
        }
    }
    //排序
    NSInteger countd = goalArray.count;

    for (NSInteger i = 0 ; i < countd; i ++) {
        NSInteger maxIndex = [self getMin:goalArray];
        
        [pax addObject:[goalArray objectAtIndex:maxIndex]];
        [goalArray removeObjectAtIndex:maxIndex];
    }
    [self test:pax];
    
    BoyeGoaldbModel * resultModel = [[BoyeGoaldbModel alloc] init];
    static NSInteger count = 0;

    for (BoyeGoaldbModel * model in pax) {
    
        NSDate * nowDate = [NSDate date];
        NSString * dataFormatt = @"yyyy-MM-dd";
        NSString *  timestr = [MyTool getCurrentDateFormat:dataFormatt];
        NSString * datestring = [NSString stringWithFormat:@"%@ %@",timestr,model.date_time];
        
        NSDate  * date = [[MyTool  getDateFormatter:@"yyyy-MM-dd HH:mm"] dateFromString:datestring];
        
        NSComparisonResult result = [date compare:nowDate];
        if ( result != NSOrderedAscending) {
            resultModel = model;
            count ++;
            break;
        }
    }
    if (count >= pax.count) {
        resultModel = [pax lastObject];
    }
    
    DLog(@"**resultModel %@*****model **%ld**",resultModel.date_time,(long)resultModel.target);

    return resultModel;
}

+(void) test:(NSArray *)array{
    return ;
//    for (BoyeGoaldbModel * model in array) {
//      DLog(@"*****************");
//        DLog(@"id %ld",(long)model.db_id);
//        DLog(@"date_time %@",model.date_time);
//        DLog(@"goalIndex %ld",model.goalIndex);
        
//        DLog(@"target %ld",model.target);
//        DLog(@"uid %ld",(long)model.uid);
//        DLog(@"weekday %ld",model.weekday);
//        DLog(@"create_time %@ ",model.create_time);

//    }
    
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
