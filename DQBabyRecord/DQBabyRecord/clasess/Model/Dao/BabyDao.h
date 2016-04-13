//
//  BabyDao.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/18.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BabyModel;

@interface BabyDao : NSObject

+(BOOL)save:(BabyModel *)baby;
+(BOOL)deleteAtId:(NSInteger)index;
+(BOOL)updateMajor:(BabyModel *)baby;
+(BabyModel *)findByName:(NSString *)name;
+(NSMutableArray *)findAll;

@end
