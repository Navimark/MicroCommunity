//
//  ViewController.m
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/20.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import "ViewController.h"
#import "ContentTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.title = @"微社区";
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.estimatedRowHeight = 136;
    self.tableView.rowHeight = 136;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentTableViewCellReuseKey" forIndexPath:indexPath];
//    cell.textLabel.text = @"fdsafdsafdsaf";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
