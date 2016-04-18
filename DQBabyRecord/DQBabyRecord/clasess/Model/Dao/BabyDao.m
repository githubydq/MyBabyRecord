//
//  BabyDao.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/18.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "BabyDao.h"
#import "FMDBHelper.h"
#import <FMDB/FMDatabase.h>
#import "BabyModel.h"

//@"create table baby(id integer primary key autoincrement, name text, sex text, birthday text, image text);"

@implementation BabyDao

//增
+(BOOL)save:(BabyModel *)baby{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if ([db open]) {
        BOOL isSuccess = [db executeUpdate:@"insert into baby(name, sex, birthday, image) values (?,?,?,?)", baby.name, baby.sex, baby.birthday, baby.image];
        [db close];
        return isSuccess;
    }else{
        return NO;
    }
}

//因为sql语句是字符串，所以非NSString类型要转类型

//删
+(BOOL)deleteAtId:(NSInteger)index{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if ([db open]) {
        BOOL isSuccess = [db executeUpdate:@"delete from baby where id = ?",[NSString stringWithFormat:@"%ld",index]];
        [db close];
        return isSuccess;
    }else
        return NO;
}

//将int类型的转换成NSNumber类型的
//改
+(BOOL)updateMajor:(BabyModel *)baby{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if (![db open]) {
        return NO;
    }else{
        BOOL isSuccess = [db executeUpdate:@"update baby set name=?, sex=?, birthday=?, image=? where id = ?", baby.name, baby.sex, baby.birthday, baby.image, [NSString stringWithFormat:@"%ld",baby.babyid]];
        NSLog(@"%ld",baby.babyid);
        [db close];
        return isSuccess;
    }
}

//查
+(BabyModel *)findById:(NSInteger)babyid{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if (![db open]) {
        return nil;
    }else{
        BabyModel * baby = nil;
        FMResultSet * rs = [db executeQuery:@"SELECT * FROM baby WHERE id = ?", babyid];
        while (rs.next) {
            baby = [[BabyModel alloc]init];
            baby.babyid = [rs intForColumnIndex:0];
            baby.name = [rs stringForColumnIndex:1];
            baby.sex = [rs stringForColumnIndex:2];
            baby.birthday = [rs stringForColumnIndex:3];
            baby.image = [rs stringForColumnIndex:4];
        }
        [db close];
        return baby;
    }
}

+(BabyModel *)findByName:(NSString *)name{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if (![db open]) {
        return nil;
    }else{
        BabyModel * baby = nil;
        FMResultSet * rs = [db executeQuery:@"select * from baby where name = ?", name];
        while (rs.next) {
            baby = [[BabyModel alloc]init];
            baby.babyid = [rs intForColumnIndex:0];
            baby.name = [rs stringForColumnIndex:1];
            baby.sex = [rs stringForColumnIndex:2];
            baby.birthday = [rs stringForColumnIndex:3];
            baby.image = [rs stringForColumnIndex:4];
        }
        [db close];
        return baby;
    }
}

+(NSMutableArray *)findAll{
    FMDatabase * db = [FMDBHelper getCurrentFMDB];
    if ([db open]) {
        FMResultSet * rs = [db executeQuery:@"select * from baby"];
        NSMutableArray * babys = [[NSMutableArray alloc] init];
        while (rs.next) {
            BabyModel * baby = [[BabyModel alloc]init];
            baby.babyid = [rs intForColumnIndex:0];
            baby.name = [rs stringForColumnIndex:1];
            baby.sex = [rs stringForColumnIndex:2];
            baby.birthday = [rs stringForColumnIndex:3];
            baby.image = [rs stringForColumnIndex:4];
            [babys addObject:baby];
        }
        [db close];
        return babys;
    }else{
        return nil;
    }
}


@end
