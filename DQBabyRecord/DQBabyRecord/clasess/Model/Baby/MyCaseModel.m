//
//  MyCaseModel.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/3.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "MyCaseModel.h"

@implementation MyCaseModel

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@",self.name,self.date,self.detail];
}

@end
