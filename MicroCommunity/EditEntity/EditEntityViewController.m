//
//  EditEntityViewController.m
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import "EditEntityViewController.h"
#import "GCPlaceholderTextView.h"

@interface EditEntityViewController ()

@property (nonatomic , weak) IBOutlet UIButton *categoryNameButton;
@property (nonatomic , weak) IBOutlet GCPlaceholderTextView *contentTextView;

@end

@implementation EditEntityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)awakeFromNib
{
    self.categoryNameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.categoryNameButton.titleLabel.minimumScaleFactor = 0.5;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.editingEntityModel.contentText) {
        [self.categoryNameButton setTitle:self.editingEntityModel.contentText forState:UIControlStateNormal];
        [self.categoryNameButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    } else {
        [self.categoryNameButton setTitle:@"请选择类别" forState:UIControlStateNormal];
        [self.categoryNameButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveInfoEntityAction:(id)sender
{
    
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
