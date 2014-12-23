//
//  InfoEntityModel.m
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import "InfoEntityModel.h"
#import "ACDBManager.h"

@interface InfoEntityModel ()

@property (nonatomic , strong) NSDateFormatter *innerTimeFormatter;

@end

@implementation InfoEntityModel

- (NSDateFormatter *)innerTimeFormatter
{
    if (!_innerTimeFormatter) {
        _innerTimeFormatter = [[NSDateFormatter alloc] init];
        [_innerTimeFormatter setLocale:[NSLocale currentLocale]];
        [_innerTimeFormatter setTimeZone:[NSTimeZone localTimeZone]];
    }
    return _innerTimeFormatter;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self.innerTimeFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *referenceDate = [self.innerTimeFormatter dateFromString:@"2014-12-21 12:12:12"];
        NSTimeInterval tempTime = [[NSDate date] timeIntervalSinceDate:referenceDate];
        self.contentId = [@(tempTime) stringValue];
    }
    return self;
}

- (NSString *)tableName
{
    return @"T_Entity";
}

- (NSDictionary *)convertToDictionary
{
    NSMutableDictionary *dict = [@{} mutableCopy];
    [dict setValue:self.contentId forKey:@"contentId"];
    [dict setValue:self.contentText forKey:@"contentText"];
    [dict setValue:self.copiedTimes forKey:@"copiedTimes"];
    [dict setValue:self.lastestCopyTimeStamp forKey:@"lastestCopyTimeStamp"];
    [dict setValue:self.addedTimeStamp forKey:@"addedTimeStamp"];
    [dict setValue:self.categoryModel.categoryId forKey:@"categoryId"];
    
    return dict;
}

- (NSString *)description
{
    return [[self convertToDictionary] description];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    EntityCategoryModel *categoryModel = [EntityCategoryModel fetchOneCategoryWithCategoryId:value];
    self.categoryModel = categoryModel;
}

#pragma mark - 
#pragma mark - 整体

- (void)fetchAllEntitiesForAppFirstLoadingWithCompletionHandler:(void (^)(NSArray *))completionHandler
{
    NSString *condition = [NSString stringWithFormat:@"order by copiedTimes asc,addedTimeStamp desc"];
    NSArray *attributes = [[ACDBManager sharedInstance] queryTable:[self tableName] withSQLCondition:condition];
    NSMutableArray *tempArray = [@[] mutableCopy];
    for (NSDictionary *dict in attributes) {
        InfoEntityModel *entityModel = [[InfoEntityModel alloc] init];
        [entityModel setValuesForKeysWithDictionary:dict];
        [tempArray addObject:entityModel];
    }
    completionHandler(self.allInfoEntityModels = tempArray);
}

#pragma mark -
#pragma mark - Database

- (BOOL)insertIntoDatabase
{
    if ([self deleteInDatabase]) {
        NSLog(@"之前已经存在，现在删除了 - 编辑");
    }
    
    return [[ACDBManager sharedInstance] insertIntoTable:[self tableName] withAttribute:[self convertToDictionary]];
}

- (BOOL)updateInDatabase
{
    NSString *condition = [NSString stringWithFormat:@"where contentId='%@'",self.contentId];
    return [[ACDBManager sharedInstance] updateForTable:[self tableName] withAttribute:[self convertToDictionary] withSQLCondition:condition];
}

- (BOOL)deleteInDatabase
{
    NSString *condition = [NSString stringWithFormat:@"where contentId='%@'",self.contentId];
    return [[ACDBManager sharedInstance] deleteInTable:[self tableName] withSQLCondition:condition];
}

@end
