//
//  MyCaseDao.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/3.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyCaseModel;

@interface MyCaseDao : NSObject
+(BOOL)save:(MyCaseModel *)Case;
+(BOOL)deleteAtDate:(NSString*)date;
+(BOOL)updateMyCase:(MyCaseModel *)model;
+(NSMutableArray *)findByName:(NSString *)name;
@end
