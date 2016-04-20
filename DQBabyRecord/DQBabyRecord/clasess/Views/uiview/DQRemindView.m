//
//  DQRemindView.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQRemindView.h"

@interface DQRemindView ()
@property (weak, nonatomic) IBOutlet UIView *centerView;

@end

@implementation DQRemindView


-(void)layoutSubviews{
    self.centerView.layer.cornerRadius = 5;
    self.centerView.layer.masksToBounds = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
