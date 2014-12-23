//
//  ContentTableViewCell.h
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "InfoEntityModel.h"

@interface ContentTableViewCell : SWTableViewCell

@property (nonatomic , strong) InfoEntityModel *infoModel;

@property (nonatomic , copy) void(^copyButtonAction)(void);

@end
