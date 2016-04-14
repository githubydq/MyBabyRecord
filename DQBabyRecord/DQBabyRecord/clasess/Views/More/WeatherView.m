//
//  WeatherView.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/12.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "WeatherView.h"

@interface WeatherView ()
@end

@implementation WeatherView

- (void)drawRect:(CGRect)rect
{
    if (self.HightArray && self.LowArray) {
        //数据
        CGFloat HWidth = 60;//水平间隔
        CGFloat VWidth = 24;//水平间隔
        
        CGFloat XNum = 8;
        CGFloat YNum = 12;
        
        CGFloat x = 50;
        CGFloat y = 100;
        
        // 1.获取上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //最高温，最低温
        for (int i = 0 ; i < 2 ; i++) {
            CGContextMoveToPoint(ctx, x, y-40*(i+1));
            CGContextAddLineToPoint(ctx, x+100, y-40*(i+1));
            CGContextSetLineWidth(ctx, 2);
            [i==0 ? [UIColor redColor] : [UIColor blueColor] set];
            CGContextStrokePath(ctx);
        }
        for (int i = 0 ; i < 2 ; i++) {
            NSString * date = i == 0 ? @"最高温" : @"最低温";
            NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
            [date drawInRect:CGRectMake(x+110, y-40*(i+1) - 8, 60, 16) withAttributes:dict];
        }
        
        //线框
        CGContextMoveToPoint(ctx, x, y);//起点
        CGContextAddLineToPoint(ctx, x, y + VWidth*YNum);//中心点
        CGContextAddLineToPoint(ctx, x + HWidth*XNum, y + VWidth*YNum);//结束点
        [[UIColor blackColor]set];
        CGContextSetLineWidth(ctx, 2);
        CGContextStrokePath(ctx);
        
        //天数
        NSDateFormatter * format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"MM/dd";
        NSDate * date = [NSDate date];
        for (int i = 1 ; i < XNum; i++) {
            NSDate * nowDate = [date dateByAddingTimeInterval:60.0*60.0*24.0*(i-1)];
            NSString * date = [format stringFromDate:nowDate];
            NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
            [date drawInRect:CGRectMake(x + HWidth*i - 50/2, y + VWidth*YNum +10, 50, 20) withAttributes:dict];
        }
        
        //温度列表
        for (int i = 0 ; i < YNum; i++) {
            NSString * date = [NSString stringWithFormat:@"%" "3d度",(-10 + i*5)];
            NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
            [date drawInRect:CGRectMake(x-40, y + VWidth*YNum - VWidth*i - 8, 40, 16) withAttributes:dict];
        }
        
        //温度点
        for (int i = 0 ; i < self.HightArray.count ; i++) {
            CGPoint point = CGPointMake(x + HWidth*(i+1), y + VWidth*(YNum-2) - VWidth/5.0*[self.HightArray[i] floatValue]);
            CGContextAddEllipseInRect(ctx, CGRectMake(point.x-3/2.0, point.y-3/2.0, 3, 3));
            CGContextFillPath(ctx);
        }
        for (int i = 0 ; i < self.LowArray.count ; i++) {
            CGPoint point = CGPointMake(x + HWidth*(i+1), y + VWidth*(YNum-2) - VWidth/5.0*[self.LowArray[i] floatValue]);
            CGContextAddEllipseInRect(ctx, CGRectMake(point.x-3/2.0, point.y-3/2.0, 3, 3));
            CGContextFillPath(ctx);
        }
        
        //温度走势
        for (int i = 0 ; i < self.HightArray.count ; i++) {
            CGPoint point = CGPointMake(x + HWidth*(i+1), y + VWidth*(YNum-2) - VWidth/5.0*[self.HightArray[i] floatValue]);
            if (i == 0) {
                CGContextMoveToPoint(ctx, point.x, point.y);
            }else{
                CGContextAddLineToPoint(ctx, point.x, point.y);
            }
        }
        [[UIColor redColor]set];
        CGContextSetLineWidth(ctx, 1);
        CGContextSetLineJoin(ctx, kCGLineJoinRound);
        CGContextStrokePath(ctx);
        for (int i = 0 ; i < self.LowArray.count ; i++) {
            CGPoint point = CGPointMake(x + HWidth*(i+1), y + VWidth*(YNum-2) - VWidth/5.0*[self.LowArray[i] floatValue]);
            if (i == 0) {
                CGContextMoveToPoint(ctx, point.x, point.y);
            }else{
                CGContextAddLineToPoint(ctx, point.x, point.y);
            }
        }
        [[UIColor blueColor]set];
        CGContextSetLineWidth(ctx, 1);
        CGContextSetLineJoin(ctx, kCGLineJoinRound);
        CGContextStrokePath(ctx);
    }
}

@end
