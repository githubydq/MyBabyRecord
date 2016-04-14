//
//  Singleton.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "Singleton.h"

static Singleton * _singleton = nil;

@implementation Singleton

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[super allocWithZone:NULL] init];
    });
    return _singleton;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [Singleton shareInstance];
}
-(instancetype)copyWithZone:(struct _NSZone *)zone
{
    return [Singleton shareInstance];
}

#pragma mark -
#pragma mark 图片记录数组

//懒加载

-(NSArray *)LifeRecordArray{
    if (!_LifeRecordArray) {
        _LifeRecordArray = @[@[@"图片记录",@"第一次"],@[@"身高",@"体重"],@[@"病例"]];
    }
    return _LifeRecordArray;
}

-(NSArray *)LifeRecordVCArray{
    if (!_LifeRecordVCArray) {
        _LifeRecordVCArray = @[@[@"ImageRecordViewController",@"FirstViewController"],@[@"HealthHWViewController",@"HealthHWViewController"],@[@"HealthCaseViewController"]];
    }
    return _LifeRecordVCArray;
}

-(NSMutableArray *)recordModelArray{
    if (!_recordModelArray) {
        _recordModelArray = [[NSMutableArray alloc] init];
    }
    return _recordModelArray;
}

-(NSMutableArray *)healthModelArray{
    if (!_healthModelArray) {
        _healthModelArray = [[NSMutableArray alloc] init];
    }
    return _healthModelArray;
}

-(NSMutableArray *)firstModelArray{
    if (!_firstModelArray) {
        _firstModelArray = [[NSMutableArray alloc] init];
    }
    return _firstModelArray;
}

-(NSMutableArray *)caseModelArray{
    if (!_caseModelArray) {
        _caseModelArray = [[NSMutableArray alloc] init];
    }
    return _caseModelArray;
}

#pragma mark -
#pragma mark 加载数据

#pragma mark -
#pragma mark 事件

#pragma mark -
#pragma mark 数据请求

#pragma mark -
#pragma mark 代理

#pragma mark -
#pragma mark 业务逻辑

#pragma mark -
#pragma mark 通知注册和销毁

@end
