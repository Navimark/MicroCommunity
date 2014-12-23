//
//  ACDataBaseUpGrade.m
//  AnyCheckMobile
//
//  Created by IOS－001 on 14-4-24.
//  Copyright (c) 2014年 e-techco Group. All rights reserved.
//

#import "ACDataBaseUpGrade.h"
#import "ACDBManager.h"

#define PATH_OF_DOCUMENT                                [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
@interface ACDataBaseUpGrade ()

@property (nonatomic , strong) NSDictionary *oldVersionInfoDict;
@property (nonatomic , strong) NSDictionary *newestVersionInfoDict;
@property (nonatomic , assign) NSInteger oldVersionCount;
@property (nonatomic , assign) NSInteger newVersionCount;

@property (nonatomic , strong) NSArray *nnewDictAllKeysArray;
@property (nonatomic , copy) NSString *oldVersionPlistPath;
@property (nonatomic , copy) NSString *nnewVersionPlistPath;

@end

@implementation ACDataBaseUpGrade

//准备新旧版本各种的数据
- (BOOL)initVersionData
{
    self.nnewVersionPlistPath = [[NSBundle mainBundle] pathForResource:@"DataBaseUpGradeRecord" ofType:@"plist"];
    self.newestVersionInfoDict = [NSDictionary dictionaryWithContentsOfFile:self.nnewVersionPlistPath];
    NSArray *allKeyArray = [self.newestVersionInfoDict allKeys];
    self.nnewDictAllKeysArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSLog(@"self.newestVersionInfoDict = %@",self.newestVersionInfoDict);
    
    self.oldVersionPlistPath = [[self getOldderDBConfigPath] stringByAppendingPathComponent:@"DB_OldderConfig.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:self.oldVersionPlistPath])//如果存在旧版本，读取出来
    {
        self.oldVersionInfoDict = [NSDictionary dictionaryWithContentsOfFile:self.oldVersionPlistPath];
        NSLog(@"self.oldVersionInfoDict = %@",self.oldVersionInfoDict);
        
    } else{//如果不存在，这只是创建目录
        NSString *upperPath = [self.oldVersionPlistPath stringByDeletingLastPathComponent];
        NSError *createError = nil;
        [fileManager createDirectoryAtPath:upperPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&createError];
        if (createError) {
            NSLog(@"创建DB_OldderConfig.plist出错:%@",createError);
            //创建目录失败，可能是因为目录已经存在了呢？所以这里不急于返回NO,再给点机会
            //           return NO;
        }
    }
    return YES;
}

//活得用户目录
- (NSString *)getOldderDBConfigPath
{
    NSString *oldderConfigPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"AnyCheckDB"];
    return oldderConfigPath;
}

/*
 *检查是否有更新的版本
 */
- (void)checkUpGradeDataBase
{
    if (![self initVersionData]) {
        NSLog(@"初始化数据失败！");
    }
    if ([self isNeedUpGrade]) {
        //根据新旧两个字典开始更新
        [self startUpdate];
        if (![self copyNewestPlistToDocument]) {
            NSLog(@"更新成功了，但是替换旧文件失败!");
        }
    } else {
        NSString *lastKey = [self.nnewDictAllKeysArray lastObject];
        NSLog(@"当前数据库是最新版本的%@，无需更新",lastKey);
    }
}

//检查是否需要更新
- (BOOL)isNeedUpGrade
{
    self.oldVersionCount = [self.oldVersionInfoDict count];
    self.newVersionCount = [self.newestVersionInfoDict count];
    
    if (_oldVersionCount < _newVersionCount) {
        return YES;
    } else{
        return NO;
    }
}

//开始更新。
- (void)startUpdate
{
    //    NSLog(@"有没有排序啊尼玛:%@",self.nnewDictAllKeysArray);
    for (; _oldVersionCount != _newVersionCount; ++ self.oldVersionCount) {
        NSString *tobeUpdataKey = [self.nnewDictAllKeysArray objectAtIndex:_oldVersionCount];
        NSArray *SQLArray = [self.newestVersionInfoDict objectForKey:tobeUpdataKey];
        for (NSString *sqlString in SQLArray) {
            if (![self executeDBUpdate:sqlString]) {
                NSLog(@"数据库更新失败");
            }
        }
    }
}

//执行更新的SQL语句
- (BOOL)executeDBUpdate:(NSString *)sqlString
{
    FMDatabaseQueue * dbQueue = [[ACDBManager sharedInstance] database];
    __block BOOL result = NO;
    [dbQueue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            if (![db executeUpdate:sqlString]) {
                NSLog(@"程序更新数据库出错,%@",db.lastErrorMessage);
                result = NO;
            } else {
                result = YES;
            }
            [db close];
        }
    }];
    return result;
}

//删除旧的文件，然后将新的复制过去
- (BOOL)copyNewestPlistToDocument
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //如果存在旧版本，先删除掉
    if([fileManager fileExistsAtPath:self.oldVersionPlistPath]) {
        NSError *removeError = nil;
        [fileManager removeItemAtPath:self.oldVersionPlistPath error:&removeError];
        if (removeError) {
            NSLog(@"删除旧的DB_OldderConfig.plist出错:%@",removeError);
            return NO;
        }
    }
    //再复制
    NSError *copyError = nil;
    [fileManager copyItemAtPath:self.nnewVersionPlistPath
                         toPath:self.oldVersionPlistPath
                          error:&copyError];
    if (copyError) {
        NSLog(@"复制替换到DB_OldderConfig.plist出错:%@",copyError);
        return NO;
    }
    return YES;
}

@end
