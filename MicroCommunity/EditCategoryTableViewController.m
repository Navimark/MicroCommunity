//
//  EditCategoryTableViewController.m
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import "EditCategoryTableViewController.h"

@interface EditCategoryTableViewController ()

@property (nonatomic , strong) EntityCategoryModel *categroyModel;

@end

@implementation EditCategoryTableViewController

- (EntityCategoryModel *)categroyModel
{
    if (!_categroyModel) {
        _categroyModel = [[EntityCategoryModel alloc] init];
    }
    return _categroyModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择类别";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setEditing:NO];
    [self reloadTableViewDataSourceAfterReloadTableView:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) {
        self.title = @"编辑类别";
    } else {
        self.title = @"选择类别";
    }
}

- (void)reloadTableViewDataSourceAfterReloadTableView:(BOOL)shouldReloadTableView
{
    __weak __typeof(self)weakSelf = self;
    [self.categroyModel fetchAllCategoriesWithCompletionHandler:^(NSArray *allCategories) {
        if (!shouldReloadTableView) {
            return ;
        }
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (allCategories.count != 0) {
            dispatch_async(dispatch_get_main_queue(), ^(){
                [strongSelf.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 1) {
//        return 10;
//    } else {
//        return 0;
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.categroyModel.allEditableCategoryModels.count;
    } else if (section == 0) {
        return self.categroyModel.allUnEditableCategoryModels.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditCategoryTableViewCellKey" forIndexPath:indexPath];
    EntityCategoryModel *model = nil;
    if (indexPath.section == 0) {
        model = self.categroyModel.allUnEditableCategoryModels[indexPath.row];
    } else if (indexPath.section == 1) {
        model = self.categroyModel.allEditableCategoryModels[indexPath.row];
    }
    
    if ([model isEqual:self.currentCategroyModel]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = model.categoryName;
    cell.indentationLevel = 2;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EntityCategoryModel *model = nil;
    if (indexPath.section == 0) {
        model = self.categroyModel.allUnEditableCategoryModels[indexPath.row];
    } else if (indexPath.section == 1) {
        model = self.categroyModel.allEditableCategoryModels[indexPath.row];
    }
    self.currentCategroyModel = model;
    
    if (self.parentVC) {
        self.parentVC.editingEntityModel.categoryModel = self.currentCategroyModel;
    }
    
    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        EntityCategoryModel *model = self.categroyModel.allEditableCategoryModels[indexPath.row];
        if (![model deleteInDatabase]) {
            NSLog(@"EntityCategoryModel在数据库中删除不成功");
        } else {
            [self reloadTableViewDataSourceAfterReloadTableView:NO];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        [self performSegueWithIdentifier:@"AddCategorySegue" sender:self];
    }   
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        //第一个cell是“默认”，它的编辑动作是“新增”
        return UITableViewCellEditingStyleInsert;
    } else if (indexPath.section == 1) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
