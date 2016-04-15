//
//  RecordDao.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "RecordDao.h"
#import "RecordModel.h"
#import "FMDBHelper.h"
#import <FMDB/FMDatabase.h>
//@"create table record(name text, detail text, date text primary key, image text)"

@implementation RecordDao
//增
+(BOOL)save:(RecordModel *)record{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if ([db open]) {
        BOOL isSuccess = [db executeUpdate:@"insert into record(name, detail, date, image) values (?,?,?,?)", record.name, record.detail, record.date, record.image];
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
        BOOL isSuccess = [db executeUpdate:@"delete from record where date = ?",date];
        [db close];
        return isSuccess;
    }else
        return NO;
}
+(BOOL)deleteAtName:(NSString*)name{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if ([db open]) {
        BOOL isSuccess = [db executeUpdate:@"delete from record where name = ?",name];
        [db close];
        return isSuccess;
    }else
        return NO;
}

//将int类型的转换成NSNumber类型的
//改
//改
+(BOOL)updateRecord:(RecordModel *)model{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if (![db open]) {
        return NO;
    }else{
        BOOL isSuccess = [db executeUpdate:@"update record set name = ?, detail=?, date=?, image=? where date = ?", model.name, model.detail, model.date, model.image, model.date];
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
        FMResultSet * rs = [db executeQuery:@"select * from record where name = ?", name];
        NSMutableArray * babys = [[NSMutableArray alloc] init];
        while (rs.next) {
            RecordModel * record = [[RecordModel alloc]init];
            record.name = [rs stringForColumnIndex:0];
            record.detail = [rs stringForColumnIndex:1];
            record.date = [rs stringForColumnIndex:2];
            record.image = [rs stringForColumnIndex:3];
            [babys insertObject:record atIndex:0];
        }
        [db close];
        return babys;
    }
}

@end
