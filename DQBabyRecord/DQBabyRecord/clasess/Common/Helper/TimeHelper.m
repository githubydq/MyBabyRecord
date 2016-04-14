//
//  TimeHelper.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "TimeHelper.h"

@implementation TimeHelper

+(NSString *)getNowTime{
    NSDate * date = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyyMMddHHmmss";
    return [format stringFromDate:date];
}

+(NSString *)getNowTimeWithTime:(NSString *)time{
    NSString * year = [time substringWithRange:NSMakeRange(0, 4)];
    NSString * mouth = [time substringWithRange:NSMakeRange(4, 2)];
    NSString * day = [time substringWithRange:NSMakeRange(6, 2)];
    return [NSString stringWithFormat:@"%@年%@月%@日",year,mouth,day];
}

+(NSString *)getNowAge:(NSString *)date{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate * now = [NSDate date];
    NSDate * before = [format dateFromString:date];
    
    NSTimeInterval age = [now timeIntervalSinceDate:before];
    if (age <= 0) {
        age = -age;
    }
    long year = age/60/60/24/365;
    long day = age/60/60/24;
    if (year > 0) {
        return [NSString stringWithFormat:@"%ld岁",year];
    }else{
        return [NSString stringWithFormat:@"%ld天",day];
    }
}

@end
