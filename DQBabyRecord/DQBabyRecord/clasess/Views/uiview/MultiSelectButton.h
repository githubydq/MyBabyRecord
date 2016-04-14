//
//  MultiSelectButton.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/3.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MultiBlock)(NSString * choiceItem);

@interface MultiSelectButton : UIView
@property(nonatomic,copy)MultiBlock block;
@property(nonatomic,strong)NSArray * choiceItems;
@end
