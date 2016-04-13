//
//  RecordDao.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RecordModel;
@interface RecordDao : NSObject
+(BOOL)save:(RecordModel *)baby;
+(BOOL)deleteAtDate:(NSString*)date;
+(BOOL)updateRecord:(RecordModel *)model;
+(NSMutableArray *)findByName:(NSString *)name;
@end
