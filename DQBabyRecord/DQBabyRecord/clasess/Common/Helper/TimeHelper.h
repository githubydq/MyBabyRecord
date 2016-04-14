//
//  TimeHelper.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeHelper : NSObject
/**获取当前时间*/
+(NSString*)getNowTime;
/**获取年月日时间*/
+(NSString*)getNowTimeWithTime:(NSString*)time;
/**获取年龄*/
+(NSString*)getNowAge:(NSString*)date;
@end
