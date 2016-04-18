//
//  DQCaseCollectionViewCell.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/14.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQCaseCollectionViewCell.h"
#import "MyCaseModel.h"
@interface DQCaseCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation DQCaseCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(MyCaseModel *)model{
    _model = model;
    self.detail.text = model.detail;
    self.date.text = [TimeHelper getNowTimeWithTime:model.date];
}

@end
