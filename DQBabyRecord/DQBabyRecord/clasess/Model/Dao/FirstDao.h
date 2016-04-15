//
//  FirstDao.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FirstModel;
@interface FirstDao : NSObject
+(BOOL)save:(FirstModel *)first;
+(BOOL)deleteAtDate:(NSString*)date;
+(BOOL)deleteAtName:(NSString*)name;
+(BOOL)updateFirst:(FirstModel *)model;
+(NSMutableArray *)findByName:(NSString *)name;
@end
