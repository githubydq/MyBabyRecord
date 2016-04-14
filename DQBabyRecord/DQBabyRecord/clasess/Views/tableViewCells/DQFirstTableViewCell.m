//
//  DQFirstTableViewCell.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/13.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQFirstTableViewCell.h"
#import "FirstModel.h"
@interface DQFirstTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation DQFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(FirstModel *)model{
    self.title.text = model.title;
    self.detail.text = model.detail;
    self.date.text = [TimeHelper getNowTimeWithTime:model.date];
}

@end
