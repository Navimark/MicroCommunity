//
//  EntityCategoryModel.m
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import "EntityCategoryModel.h"
#import "ACDBManager.h"

@interface EntityCategoryModel ()

@property (nonatomic , strong) NSDateFormatter *innerTimeFormatter;

@end

@implementation EntityCategoryModel

- (BOOL)isEqual:(id)object
{
    if (object && [object isKindOfClass:[EntityCategoryModel class]]) {
        EntityCategoryModel *anotherObj = (EntityCategoryModel *)object;
        if ([anotherObj.categoryId isEqualToString:self.categoryId]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)tableName
{
    return @"T_Category";
}

- (NSArray *)allUnEditableCategoryModels
{
    NSMutableArray *tempArray = [@[] mutableCopy];
    for (EntityCategoryModel *tempModel in self.allCategoryModels) {
        if (tempModel.isEditable == NO) {
            [tempArray addObject:tempModel];
        }
    }
    return tempArray;
}

- (NSArray *)allEditableCategoryModels
{
    NSMutableArray *tempArray = [@[] mutableCopy];
    for (EntityCategoryModel *tempModel in self.allCategoryModels) {
        if (tempModel.isEditable) {
            [tempArray addObject:tempModel];
        }
    }
    return tempArray;
}

+ (NSString *)tableName
{
    return @"T_Category";
}

- (NSDictionary *)convertToDictionary
{
    NSMutableDictionary *dict = [@{} mutableCopy];
    [dict setValue:self.categoryId forKey:@"categoryId"];
    [dict setValue:self.categoryName forKey:@"categoryName"];
    [dict setValue:@(self.isEditable) forKey:@"isEditable"];
    return dict;
}

- (NSString *)description
{
    return [[self convertToDictionary] description];
}

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
        self.categoryId = [@(tempTime) stringValue];
    }
    return self;
}

+ (EntityCategoryModel *)fetchOneCategoryWithCategoryName:(NSString *)categoryName
{
    if (categoryName.length == 0) {
        return nil;
    }
    NSString *condition = [NSString stringWithFormat:@"where categoryName='%@'",categoryName];
    NSArray *attributes = [[ACDBManager sharedInstance] queryTable:[self tableName] withSQLCondition:condition];
    NSDictionary *tempDict = [attributes firstObject];
    
    if (tempDict.count != 0) {
        EntityCategoryModel *tempModel = [[EntityCategoryModel alloc] init];
        tempModel.categoryId = tempDict[@"categoryId"];
        tempModel.categoryName = categoryName;
        return tempModel;
    } else {
        return nil;
    }
}

+ (EntityCategoryModel *)fetchOneCategoryWithCategoryId:(NSString *)categoryId
{
    if (categoryId.length == 0) {
        return nil;
    }
    
    NSString *condition = [NSString stringWithFormat:@"where categoryId='%@'",categoryId];
    NSArray *attributes = [[ACDBManager sharedInstance] queryTable:[self tableName] withSQLCondition:condition];
    NSDictionary *tempDict = [attributes firstObject];
    
    if (tempDict.count != 0) {
        EntityCategoryModel *tempModel = [[EntityCategoryModel alloc] init];
        tempModel.categoryName = tempDict[@"categoryName"];
        tempModel.categoryId = categoryId;
        return tempModel;
    } else {
        return nil;
    }
}

- (void)fetchAllCategoriesWithCompletionHandler:(void (^)(NSArray *))completionHandler
{
    NSString *condition = [NSString stringWithFormat:@"order by categoryId asc"];
    NSArray *attributes = [[ACDBManager sharedInstance] queryTable:[self tableName] withSQLCondition:condition];
    NSMutableArray *tempArray = [@[] mutableCopy];
    for (NSDictionary *tempDict in attributes) {
        EntityCategoryModel *categoryModel = [[EntityCategoryModel alloc] init];
        [categoryModel setValuesForKeysWithDictionary:tempDict];
        [tempArray addObject:categoryModel];
    }
    completionHandler(self.allCategoryModels = tempArray);
}

- (BOOL)insertIntoDatabase
{
    return [[ACDBManager sharedInstance] insertIntoTable:[self tableName] withAttribute:[self convertToDictionary]];
}

- (BOOL)deleteInDatabase
{
    NSString *condition = [NSString stringWithFormat:@"where categoryId='%@'",self.categoryId];
    return [[ACDBManager sharedInstance] deleteInTable:[self tableName] withSQLCondition:condition];
}

@end
