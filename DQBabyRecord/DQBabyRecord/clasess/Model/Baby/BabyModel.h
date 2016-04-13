//
//  BabyModel.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/18.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BabyModel : NSObject
@property(nonatomic,assign)NSInteger babyid;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * birthday;
@property(nonatomic,copy)NSString * image;
@end
