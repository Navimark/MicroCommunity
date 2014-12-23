//
//  AddCategoryViewController.m
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/23.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import "AddCategoryViewController.h"
#import "EntityCategoryModel.h"
#import "UIViewController+TopBarMessage.h"

@interface AddCategoryViewController ()

@property (nonatomic , weak) IBOutlet UITextField *categoryTextFiled;

@end

@implementation AddCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)userInputCategory
{
    NSString *category = [self.categoryTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return category;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.view endEditing:YES]) {
        NSLog(@"不能关闭键盘");
    }
}

- (IBAction)rightBarButtonItemSaveAction:(id)sender
{
    NSString *userInputCategory = [self userInputCategory];
    if (userInputCategory.length == 0) {
        [self showTopMessage:@"请输入类别"];
        return;
    }
    if ([EntityCategoryModel fetchOneCategoryWithCategoryName:userInputCategory]) {
        //说明数据库中已经存在过用户输入的类别
        [self showTopMessage:@"您输入的类别已存在！"];
    } else {
        
        EntityCategoryModel *insertModel = [[EntityCategoryModel alloc] init];
        insertModel.categoryName = userInputCategory;
        insertModel.isEditable = YES;
        if ([insertModel insertIntoDatabase]) {
            [self showTopMessage:@"您成功增添了一个类别！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                    //
                }];
            });
        }
    }
}

- (IBAction)leftBarButtonItemCancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
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
