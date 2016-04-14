//
//  SquareRadioButton.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/3.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "SquareRadioButton.h"

@implementation SquareRadioButton

- (void)drawRect:(CGRect)rect {
    CGFloat widht = rect.size.width;
    CGFloat height = rect.size.height;
    
    
    //1.获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.拼接图形
    //画方形
    CGContextAddRect(ctx, rect);
    //设置宽度
    CGContextSetLineWidth(ctx, 5);
    //设置颜色
    [[UIColor grayColor]set];
    
    //3.渲染到View
    CGContextStrokePath(ctx);
    
    if (_isChoiced) {
        //2.绘图
        //2.1创建一条直线绘图的路径
        //注意：但凡通过Quartz2D中带有creat/copy/retain方法建出来的值都必须要释放
        CGMutablePathRef path=CGPathCreateMutable();
        //2.2把绘图信息添加到路径里
        CGPathMoveToPoint(path, NULL, widht/4, height/2.0);
        CGPathAddLineToPoint(path, NULL, widht/2.0, height-height/4);
        CGPathMoveToPoint(path, NULL, widht/2.0, height-height/4);
        CGPathAddLineToPoint(path, NULL, widht-widht/4, height/4);
        //2.3把路径添加到上下文中
        //把绘制直线的绘图信息保存到图形上下文中
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextAddPath(ctx, path);
        
        //3.渲染
        CGContextStrokePath(ctx);
    }
}

@end
