//
//  RecordModel.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/19.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
//@"create table record(name text, detail text, date text primary key, image text)"
@interface RecordModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * detail;
@property(nonatomic,copy)NSString * date;
@property(nonatomic,copy)NSString * image;
@end
