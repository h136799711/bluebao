//
//  BoyeFileMagager.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/30.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeFileMagager.h"

@implementation BoyeFileMagager

//文件是否存在
+(BOOL)isFileExists:(NSString*)stringname {
    BOOL isDirectory;
    
    NSString * filePath = [NSString stringWithFormat:@"Documents/%@.plist",stringname];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:filePath] isDirectory:&isDirectory]) {
        NSLog(@"文件存在，是一个%@",isDirectory?@"文件夹":@"文件");
        return  YES;
    }else{
        NSLog(@"文件不存在");
        return NO;
    }
}

#pragma mark --- 将文件保存在沙河下 ---
+(NSString *) getDocumentsImageFile:(NSData *)dataImag userID:(NSInteger)uid{
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中   Documents
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * datastr = [MyTool getCurrentDataFormat:@"yyyyMMddhhmmss"];
    NSString * imageName = [NSString stringWithFormat:@"/%@_%ld_%@",datastr,uid,@"image.png"];
    
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:imageName] contents:dataImag attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    
    NSString * filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,imageName];
    return filePath;
}

#pragma mark --- goalData数组保存
+(void) saveGoalData:(NSArray *)goalDataArray plistName:(NSString *)plistname{
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:goalDataArray];
    NSString * pathName = [NSString stringWithFormat:@"Documents/%@.plist",plistname];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:pathName];
    
    [data writeToFile:path atomically:NO];

}

#pragma mark --- goalData数组读取

+(void)readGoalDataName:(NSString *)plistname complete:(void (^)(NSArray * goalArr))complete{
  
    NSString * pathName = [NSString stringWithFormat:@"Documents/%@.plist",plistname];
    NSData * data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:pathName]];
    //
    NSArray * goalArray = [NSKeyedUnarchiver unarchiveObjectWithData:data] ;
   
    if (goalArray) {
        complete(goalArray);
    }
}

//
+(NSString *) defaultGoalArrFilePlistName{
    
    return @"lanbao_goal_arr_plistname";
}

+(NSString *) defaultGoalDataFileName{
    return @"lanbao_goal_name";
    
}

//保存默认目标 ，始终都会保存
+(void)saveDefaultGoalData:(NSArray *)goalDataArray {
    
    NSString * defaultName = [self defaultGoalArrFilePlistName];
    
    if (goalDataArray == nil) {
        GoalData * goal = [GoalData defauleGoal];
        goalDataArray = [[NSArray alloc]initWithObjects:goal, nil];
    }
    
    [self saveGoalData:goalDataArray plistName:defaultName];
}

//读取默认目标
+(void) readDefaultGoalData:(void(^)( NSArray * goalArr))complete{
    
    //文件不存在，创建一个文件
   BOOL isExist = [self isFileExists:[self defaultGoalArrFilePlistName]];
    if (!isExist) {
        [self saveDefaultGoalData:nil];
    }
    
    [self readGoalDataName:[self defaultGoalArrFilePlistName] complete:^(NSArray *goalArr) {
        if (goalArr == nil) {
            goalArr = [[NSArray alloc] initWithObjects:[GoalData defauleGoal], nil];
        }
        complete(goalArr);
    }];
    
}
@end
