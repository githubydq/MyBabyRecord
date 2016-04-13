//
//  RemindModel.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/10.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "RemindModel.h"

@implementation RemindModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.detail = [aDecoder decodeObjectForKey:@"detail"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.detail forKey:@"detail"];
}

@end
