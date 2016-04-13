//
//  MyCaseModel.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/3.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
//@"create table mycase(name text, date text primary key, detail text)"
@interface MyCaseModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * date;
@property(nonatomic,copy)NSString * detail;
@end
