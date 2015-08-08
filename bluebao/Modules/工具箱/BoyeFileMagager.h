//
//  BoyeFileMagager.h
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoyeFileMagager : NSObject

#pragma mark --- 将文件保存在沙河下 ---
+(NSString *) getDocumentsImageFile:(NSData *)dataImag userID:(NSInteger)uid;



#pragma mark --- goalData数组保存
+(void) saveGoalData:(NSArray *)goalDataArray plistName:(NSString *)plistname;

#pragma mark --- goalData数组读取    
+(void)readGoalDataName:(NSString *)plistname complete:(void (^)(NSArray * goalArr))complete;


/*
 * 保存到默认文件名下 ，始终都会保存
 */
+(void)saveDefaultGoalData:(NSArray *)goalDataArray;


/*
 * 读取默认文件名下的目标 ，始终都会保存
 */

+(void) readDefaultGoalData:(void(^)( NSArray * goalArr))complete;
@end
