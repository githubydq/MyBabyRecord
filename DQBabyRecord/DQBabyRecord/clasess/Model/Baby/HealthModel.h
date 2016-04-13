//
//  HealthModel.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/19.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
//@"create table health(name text, height text, weight text, date text primary key)"
@interface HealthModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * height;
@property(nonatomic,copy)NSString * weight;
@property(nonatomic,copy)NSString * date;
@end
