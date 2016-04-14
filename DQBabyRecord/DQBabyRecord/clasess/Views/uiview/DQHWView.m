//
//  DQHWView.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/13.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQHWView.h"
#import "HealthModel.h"

@implementation DQHWView

/**返回时间的rect*/
-(CGRect)getDate:(NSInteger)i{
    static NSString * str = @"1990年0月0ri";
    CGRect rect = [str boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{[UIFont systemFontOfSize:14]:NSFontAttributeName,[UIColor blackColor]:NSForegroundColorAttributeName} context:nil];
    return CGRectMake(10, 50*(i+1) - rect.size.height/2.0, 90, rect.size.height);
}
/**返回点的rect*/
-(CGRect)getPoint:(NSInteger)i{
    return CGRectMake(10+90+10, 50*(i+1) - 8/2.0, 8, 8);
}
/**返回身高体重的rect*/
-(CGRect)getHW:(NSInteger)i{
    static NSString * str = @"175cm 60kg";
    CGRect rect = [str boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{[UIFont systemFontOfSize:16]:NSFontAttributeName,[UIColor blackColor]:NSForegroundColorAttributeName} context:nil];
    return CGRectMake(10+90+10+8+20, 50*(i+1) - rect.size.height/2.0, 200, rect.size.height);
}

- (void)drawRect:(CGRect)rect {
    
    NSInteger number = [Singleton shareInstance].healthModelArray.count;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画直线
    CGRect line = [self getPoint:0];
    CGRect last = [self getPoint:number-1];
    CGContextMoveToPoint(ctx, line.origin.x+line.size.width/2.0, line.origin.y + line.size.height/2.0);
    CGContextAddLineToPoint(ctx, last.origin.x+last.size.width/2.0, last.origin.y + last.size.height/2.0);
    [[UIColor grayColor]set];
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);
    
    for (int i = 0 ; i < number ; i++) {
        HealthModel * model = [Singleton shareInstance].healthModelArray[i];
        //画时间
        NSString * date = [TimeHelper getNowTimeWithTime:model.date];
        NSDictionary * dict = @{[UIFont systemFontOfSize:14]:NSFontAttributeName,[UIColor blackColor]:NSForegroundColorAttributeName};
        [date drawInRect:[self getDate:i] withAttributes:dict];
        //画点
        CGContextAddEllipseInRect(ctx, [self getPoint:i]);
        [[UIColor blueColor]set];
        CGContextFillPath(ctx);
        //画身高体重
        NSString * hw = [NSString stringWithFormat:@"%@cm  %@kg",model.height,model.weight];
        NSDictionary * hwdict = @{[UIFont systemFontOfSize:16]:NSFontAttributeName,[UIColor blackColor]:NSForegroundColorAttributeName};
        [hw drawInRect:[self getHW:i] withAttributes:hwdict];
    }
}

@end
