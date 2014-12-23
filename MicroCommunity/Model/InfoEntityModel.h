//
//  InfoEntityModel.h
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityCategoryModel.h"

@interface InfoEntityModel : NSObject

@property (nonatomic , copy) NSString *contentId;//内部唯一编号
@property (nonatomic , copy) NSString *contentText;//内容
@property (nonatomic , copy) NSString *copiedTimes;//复制的次数
@property (nonatomic , copy) NSString *lastestCopyTimeStamp;//最近一次copy的时间
@property (nonatomic , strong) EntityCategoryModel *categoryModel;//所属类别
@property (nonatomic , copy) NSString *addedTimeStamp;//加入的时间

@property (nonatomic , strong) NSArray *allInfoEntityModels;

/**
 *  app启动时，查询所有的记录，显示在首页
 *
 *  @param completionHandler 回调
 */
- (void)fetchAllEntitiesForAppFirstLoadingWithCompletionHandler:(void(^)(NSArray *allEntities))completionHandler;

/**
 *  在数据库里面删除
 */
- (BOOL)deleteInDatabase;

/**
 *  插入数据库
 */
- (BOOL)insertIntoDatabase;

/**
 *  在数据库中更新
 */
- (BOOL)updateInDatabase;

@end
