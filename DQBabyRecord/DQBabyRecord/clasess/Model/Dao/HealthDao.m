//
//  HealthDao.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "HealthDao.h"
#import "HealthModel.h"
#import <FMDB/FMDatabase.h>
#import "FMDBHelper.h"

//@"create table health(name text, height text, weight text, date text primary key)"

@implementation HealthDao
//增
+(BOOL)save:(HealthModel *)health{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if ([db open]) {
        BOOL isSuccess = [db executeUpdate:@"insert into health(name, height, weight, date) values (?,?,?,?)", health.name, health.height, health.weight, health.date];
        [db close];
        return isSuccess;
    }else{
        return NO;
    }
}

//因为sql语句是字符串，所以非NSString类型要转类型

//删
+(BOOL)deleteAtDate:(NSString*)date{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if ([db open]) {
        BOOL isSuccess = [db executeUpdate:@"delete from health where date = ?",date];
        [db close];
        return isSuccess;
    }else
        return NO;
}

//将int类型的转换成NSNumber类型的
//改
+(BOOL)updateHealth:(HealthModel *)model{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if (![db open]) {
        return NO;
    }else{
        BOOL isSuccess = [db executeUpdate:@"update health set name = ?, height=?, weight=?, date=? where date = ?", model.name, model.height, model.weight, model.date, model.date];
        [db close];
        return isSuccess;
    }
}

//查
+(NSMutableArray *)findByName:(NSString *)name{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if (![db open]) {
        return nil;
    }else{
        FMResultSet * rs = [db executeQuery:@"select * from health where name = ?", name];
        NSMutableArray * healths = [[NSMutableArray alloc] init];
        while (rs.next) {
            HealthModel * health = [[HealthModel alloc]init];
            health.name = [rs stringForColumnIndex:0];
            health.height = [rs stringForColumnIndex:1];
            health.weight = [rs stringForColumnIndex:2];
            health.date = [rs stringForColumnIndex:3];
            [healths insertObject:health atIndex:0];
        }
        [db close];
        return healths;
    }
}


@end
