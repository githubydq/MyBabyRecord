//
//  DQHWCollectionViewCell.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/14.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQHWCollectionViewCell.h"
#import "HealthModel.h"
@interface DQHWCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *weight;

@end

@implementation DQHWCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(HealthModel *)model{
    self.height.text = [NSString stringWithFormat:@"%@cm",model.height];
    self.weight.text = [NSString stringWithFormat:@"%@kg",model.weight];
}

@end
