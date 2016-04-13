//
//  FirstDao.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "FirstDao.h"
#import <FMDB/FMDatabase.h>
#import "FMDBHelper.h"
#import "FirstModel.h"

//@"create table first(name text,date text primary key, title text, detail text, image text)"

@implementation FirstDao
//增
+(BOOL)save:(FirstModel *)first{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if ([db open]) {
        BOOL isSuccess = [db executeUpdate:@"insert into first(name, date, title, detail, image) values (?,?,?,?,?)", first.name, first.date, first.title, first.detail, first.image];
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
        BOOL isSuccess = [db executeUpdate:@"delete from first where date = ?",date];
        [db close];
        return isSuccess;
    }else
        return NO;
}

//将int类型的转换成NSNumber类型的
//改
+(BOOL)updateFirst:(FirstModel *)model{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if (![db open]) {
        return NO;
    }else{
        BOOL isSuccess = [db executeUpdate:@"update first set name = ?, date=?, title=?, detail=?, image=? where date = ?", model.name, model.date, model.title, model.detail, model.image, model.date];
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
        FMResultSet * rs = [db executeQuery:@"select * from first where name = ?", name];
        NSMutableArray * firsts = [[NSMutableArray alloc] init];
        while (rs.next) {
            FirstModel * first = [[FirstModel alloc]init];
            first.name = [rs stringForColumnIndex:0];
            first.date = [rs stringForColumnIndex:1];
            first.title = [rs stringForColumnIndex:2];
            first.detail = [rs stringForColumnIndex:3];
            first.image = [rs stringForColumnIndex:4];
            [firsts insertObject:first atIndex:0];
        }
        [db close];
        return firsts;
    }
}

@end
