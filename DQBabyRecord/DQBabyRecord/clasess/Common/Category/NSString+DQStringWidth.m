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

-(CGFloat)getStringHeightWithFont:(NSInteger)fontSize Width:(CGFloat)width{
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size.height ;
}

@end
