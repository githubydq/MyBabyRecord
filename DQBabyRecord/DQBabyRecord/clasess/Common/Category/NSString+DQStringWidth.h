//
//  NSString+DQStringWidth.h
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/14.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DQStringWidth)
/**获取导航栏标题的宽度*/
-(CGFloat)getNavTitleWidth:(NSInteger)fontSize;
-(CGFloat)getStringHeightWithFont:(NSInteger)fontSize Width:(CGFloat)width;
@end
