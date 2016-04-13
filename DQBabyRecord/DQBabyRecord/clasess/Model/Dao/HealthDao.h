//
//  HealthDao.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HealthModel;
@interface HealthDao : NSObject
+(BOOL)save:(HealthModel *)health;
+(BOOL)deleteAtDate:(NSString*)date;
+(BOOL)updateHealth:(HealthModel *)model;
+(NSMutableArray *)findByName:(NSString *)name;
@end
