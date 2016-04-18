//
//  DQFirstCollectionViewCell.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/14.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQFirstCollectionViewCell.h"
#import "FirstModel.h"

@interface DQFirstCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation DQFirstCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(FirstModel *)model{
    _model = model;
    self.title.text = model.title;
    self.detail.text = model.detail;
    self.date.text = [TimeHelper getNowTimeWithTime:model.date];
}

@end
