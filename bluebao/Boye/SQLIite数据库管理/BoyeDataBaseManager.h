//
//  BoyeDataBaseManager.h
//  bluebao
//
//  Created by boye_mac1 on 15/8/13.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteManager.h"
#import "BoyeGoaldbModel.h"

@interface BoyeDataBaseManager : NSObject

+(BoyeDataBaseManager *) sharedataBaseManager;

/**数据库初始化

 * 判断数据库文件是否存在，否，创建一个数据库文件
 */

+ (void)initDatabase;

/**
 *  向数据库插入记录
 *
 *  参数， 数据库模型
 */

//插入数据
+ (void)insertGoalWithDate:(BoyeGoaldbModel *) model;

/**
 * 读取，某一周的目标计划，
 * 参数 ，用户id ， week
 */

+(NSArray *) getGoalDataUserID:(NSInteger) uid week:(NSInteger) weekday;


/**
 *删除一条记录
 * 参数，目标键值 key
 */

//删除数据
+(void) deleteDataID:(NSInteger)db_id;
+(void)deleteAllData;

/**
 * 修改记录
 **/

//获得所有数据
+(NSArray *) getAllData;
//数据是否存在
+(BOOL )isExistUserGoal:(BoyeGoaldbModel *) model;

//修改数据
+(void) alertData:(BoyeGoaldbModel *)model;
+(void) test:(NSArray *)array;

//搜索数据
+(BoyeGoaldbModel*) selectDataModel:(BoyeGoaldbModel*)model;
@end
