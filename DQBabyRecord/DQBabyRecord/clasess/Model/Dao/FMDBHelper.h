//
//  FMDBHelper.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/18.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;
@interface FMDBHelper : NSObject

+(FMDatabase*)getCurrentFMDB;

@end
