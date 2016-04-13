//
//  HospitalModel.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/9.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "HospitalModel.h"

@implementation HospitalModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    self.ID = [[keyedValues objectForKey:@"id"] integerValue];
    self.name = [keyedValues objectForKey:@"name"];
    self.address = [keyedValues objectForKey:@"address"];
    self.x = [[keyedValues objectForKey:@"x"] floatValue];
    self.y = [[keyedValues objectForKey:@"y"] floatValue];
    self.area = [[keyedValues objectForKey:@"area"] integerValue];
    self.mtype = [keyedValues objectForKey:@"mtype"];
    self.level = [keyedValues objectForKey:@"level"];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@-%@",self.name,self.address];
}

@end
