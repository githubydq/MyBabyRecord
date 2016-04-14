//
//  NSString+DQStringWidth.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/14.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "NSString+DQStringWidth.h"

@implementation NSString (DQStringWidth)
-(CGFloat)getNavTitleWidth:(NSInteger)fontSize{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 34) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size.width ;
}

-(CGFloat)getNavTitleHeight:(NSInteger)fontSize{
    return [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size.height ;
}

@end
