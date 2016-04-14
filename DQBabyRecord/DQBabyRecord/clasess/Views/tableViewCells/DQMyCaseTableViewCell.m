//
//  DQMyCaseTableViewCell.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/13.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQMyCaseTableViewCell.h"
#import "MyCaseModel.h"

@interface DQMyCaseTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation DQMyCaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MyCaseModel *)model{
    self.detail.text = [NSString stringWithFormat:@"    %@",model.detail];
    self.date.text = [TimeHelper getNowTimeWithTime:model.date];
}

@end
