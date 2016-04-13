//
//  RemindModel.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/10.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindModel : NSObject <NSCoding>
@property(nonatomic,copy)NSString * title;/**<标题*/
@property(nonatomic,copy)NSString * date;/**<时间*/
@property(nonatomic,copy)NSString * detail;/**<详细内容*/
@end
