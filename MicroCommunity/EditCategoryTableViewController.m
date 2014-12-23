//
//  EditCategoryTableViewController.m
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import "EditCategoryTableViewController.h"
#import "EntityCategoryModel.h"

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
    __weak __typeof(self)weakSelf = self;
    [self.categroyModel fetchAllCategoriesWithCompletionHandler:^(NSArray *allCategories) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (allCategories.count != 0) {
            dispatch_async(dispatch_get_main_queue(), ^(){
                [strongSelf.tableView reloadData];
            });
        }
    }];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.categroyModel.allCategoryModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditCategoryTableViewCellKey" forIndexPath:indexPath];
    EntityCategoryModel *model = self.categroyModel.allCategoryModels[indexPath.row];
    cell.textLabel.text = model.categoryName;
    cell.indentationLevel = 2;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleInsert;
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
