//
//  EntityCategoryModel.h
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntityCategoryModel : NSObject

@property (nonatomic , copy) NSString *categoryName;
@property (nonatomic , copy) NSString *categoryId;
@property (nonatomic , assign) BOOL isEditable;
@property (nonatomic , copy) NSString *categoryBackHEXColor;//16进制的颜色字符串

@property (nonatomic , strong) NSArray *allCategoryModels;
@property (nonatomic , strong) NSArray *allEditableCategoryModels;
@property (nonatomic , strong) NSArray *allUnEditableCategoryModels;

- (void)fetchAllCategoriesWithCompletionHandler:(void(^)(NSArray *allCategories))completionHandler;

+ (EntityCategoryModel *)fetchOneCategoryWithCategoryId:(NSString *)categoryId;

+ (EntityCategoryModel *)fetchOneCategoryWithCategoryName:(NSString *)categoryName;

/**
 *  在数据库里面删除
 */
- (BOOL)deleteInDatabase;

/**
 *  插入数据库
 */
- (BOOL)insertIntoDatabase;

@end
