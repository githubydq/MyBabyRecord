//
//  AddRecordChoiceItem.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/4.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddRecordChoiceItemBlock)(NSString * vcName);
@interface AddRecordChoiceItem : UIView
@property(nonatomic,copy)NSArray * dataArray;
@property(nonatomic,copy)AddRecordChoiceItemBlock block;

+(instancetype)addRecordChoiceItem;
@end
