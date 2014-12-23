//
//  ContentTableViewCell.m
//  MicroCommunity
//
//  Created by IOS－001 on 14/12/22.
//  Copyright (c) 2014年 E-Techco Information Technologies Co., LTD. All rights reserved.
//

#import "ContentTableViewCell.h"

@interface ContentTableViewCell ()

@property (nonatomic , weak) IBOutlet UILabel *contentLabel;
@property (nonatomic , weak) IBOutlet UILabel *copTimesLabel;
@property (nonatomic , weak) IBOutlet UILabel *lastestCopyTimeStampLabel;
@property (nonatomic , weak) IBOutlet UILabel *categoryLabel;


@end

@implementation ContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setInfoModel:(InfoEntityModel *)infoModel
{
    if (_infoModel != infoModel) {
        _infoModel = infoModel;
        self.contentLabel.text = _infoModel.contentText;
        self.copTimesLabel.text = _infoModel.copiedTimes;
        self.lastestCopyTimeStampLabel.text = _infoModel.lastestCopyTimeStamp;
        self.categoryLabel.text = _infoModel.categoryModel.categoryName;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)copyButtonAction:(id)sender
{
    
}

@end
