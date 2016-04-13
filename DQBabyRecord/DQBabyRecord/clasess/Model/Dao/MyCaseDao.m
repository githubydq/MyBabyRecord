//
//  MyCaseDao.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/3.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "MyCaseDao.h"
#import <FMDB/FMDatabase.h>
#import "FMDBHelper.h"
#import "MyCaseModel.h"

//@"create table mycase(name text, date text primary key, detail text)"

@implementation MyCaseDao
//增
+(BOOL)save:(MyCaseModel *)myCase{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if ([db open]) {
        BOOL isSuccess = [db executeUpdate:@"insert into mycase(name, date, detail) values (?,?,?)", myCase.name, myCase.date, myCase.detail];
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
        BOOL isSuccess = [db executeUpdate:@"delete from mycase where date = ?",date];
        [db close];
        return isSuccess;
    }else
        return NO;
}

//将int类型的转换成NSNumber类型的
//改
+(BOOL)updateMyCase:(MyCaseModel *)model{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if (![db open]) {
        return NO;
    }else{
        BOOL isSuccess = [db executeUpdate:@"update mycase set name = ?, date=?, detail=? where date = ?", model.name, model.date, model.detail, model.date];
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
        FMResultSet * rs = [db executeQuery:@"select * from mycase where name = ?", name];
        NSMutableArray * mycases = [[NSMutableArray alloc] init];
        while (rs.next) {
            MyCaseModel * myCase = [[MyCaseModel alloc]init];
            myCase.name = [rs stringForColumnIndex:0];
            myCase.date = [rs stringForColumnIndex:1];
            myCase.detail = [rs stringForColumnIndex:2];
            [mycases insertObject:myCase atIndex:0];
        }
        [db close];
        return mycases;
    }
}
@end
