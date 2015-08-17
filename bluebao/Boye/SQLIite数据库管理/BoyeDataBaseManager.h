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
 *  @param，model 数据库模型
 */

//插入数据
+ (void)insertGoalWithDate:(BoyeGoaldbModel *) model;

/**
 * 读取，某一周的目标计划，
 * @param uid 用户 uid ，
 * @param week 周

 */

+(NSArray *) getGoalDataUserID:(NSInteger) uid week:(NSInteger) weekday;


/**
 *删除一条记录
 *  @param ，数据id db_id
 */

//删除数据
+(void) deleteDataID:(NSInteger)db_id;

/**
 *  删除所有记录
 */

+(void)deleteAllData;

/**
 * 修改记录
 * @param model  数据模型 
 *      标识         ( uid,用户uid；weekday ，星期；
        修改     date_time，时间；target ， 目标
 *
 **/
//修改数据
+(void) alertData:(BoyeGoaldbModel *)model;

//获得所有数据
+(NSArray *) getAllData;
/**
 *
 * 获得用户数据
 *  @param uid  用户 uid
 **/

+(NSArray *) getAllDataUserID:(NSInteger)uid;

/**
 *
 * 数据是否存在
 *  @param   uid ,weekday data_time
 **/

//数据是否存在
+(BOOL )isExistUserGoal:(BoyeGoaldbModel *) model;
//搜索数据

/**
 *
 * 查询数据
 *  @param   uid ,weekday ,data_time
 **/

+(BoyeGoaldbModel*) selectDataModel:(BoyeGoaldbModel*)model;

/**
 *查询数据ID
 * @param   uid ,weekday ,data_time
 */

+(NSInteger)selectedDateModelID:(BoyeGoaldbModel *)model;
/**
 *
 * 查询数据
 *  @param  db_id 数据 id 
 **/
//搜索数据
+(BoyeGoaldbModel*) selectDataID:(NSInteger)db_id;

/**
 找到距离当前时间最近的
 闹铃
  **/
+(BoyeGoaldbModel *) getNearlyNotifyGoalOfUser:(NSInteger)uid;

+(void) test:(NSArray *)array;




@end
