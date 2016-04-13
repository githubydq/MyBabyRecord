//
//  FMDBHelper.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/18.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "FMDBHelper.h"
#import <FMDB/FMDatabase.h>

@implementation FMDBHelper

+(FMDatabase *)getCurrentFMDB{
    static FMDatabase * db = nil;
    if (!db) {
        NSString * path = [NSString stringWithFormat:@"%@/Documents/mybabyrecord.db",NSHomeDirectory()];
        NSLog(@"==%@",path);
        NSFileManager * file = [NSFileManager defaultManager];
        db = [FMDatabase databaseWithPath:path];
        if (![file fileExistsAtPath:path]) {
            if ([db open]) {
                NSString * createBabySql = @"create table baby(id integer primary key autoincrement, name text, sex text, birthday text, image text);";
                NSString * createRecordSql = @"create table record(name text, detail text, date text primary key, image text)";
                NSString * createFirstSql = @"create table first(name text,date text primary key, title text, detail text, image text)";
                NSString * createHealthSql = @"create table health(name text, height text, weight text, date text primary key)";
                NSString * createCaseSql = @"create table mycase(name text, date text primary key, detail text)";
                [db executeStatements:createBabySql];
                [db executeStatements:createRecordSql];
                [db executeStatements:createFirstSql];
                [db executeStatements:createHealthSql];
                [db executeStatements:createCaseSql];
                [db close];
            }
        }
        //创建图片文件夹
        NSError * error = nil;
        NSString * imgPath = [NSString stringWithFormat:@"%@/Documents/image",NSHomeDirectory()];
        [file createDirectoryAtPath:imgPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    return db;
}

@end
