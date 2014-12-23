//
//  EditCategoryTableViewController.h
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityCategoryModel.h"
#import "EditEntityViewController.h"

@interface EditCategoryTableViewController : UITableViewController

@property (nonatomic , strong) EntityCategoryModel *currentCategroyModel;
@property (nonatomic , weak) EditEntityViewController *parentVC;

@end
