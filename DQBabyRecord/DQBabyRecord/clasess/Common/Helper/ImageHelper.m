//
//  ImageHelper.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/26.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "ImageHelper.h"
#import <UIKit/UIImage.h>

#define IMGPATH [NSString stringWithFormat:@"%@/Documents/image",NSHomeDirectory()]

@implementation ImageHelper

+(void)saveImage:(UIImage*)image withName:(NSString *)date{
    NSData * data = UIImageJPEGRepresentation(image, 1);
    [data writeToFile:[NSString stringWithFormat:@"%@/%@",IMGPATH,date] atomically:YES];
}
+(void)saveSmallImage:(UIImage*)image withName:(NSString *)date{
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    [data writeToFile:[NSString stringWithFormat:@"%@/%@",SMALL_IMG_PATH,date] atomically:YES];
}

+(UIImage *)getImageWithName:(NSString *)date{
    NSData * data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",IMGPATH,date]];
    UIImage * image = [UIImage imageWithData:data];
//    NSLog(@"%lf,%lf",image.size.height,image.size.width);
    return image;
}

+(float)getScaleWithName:(NSString *)date{
    NSData * data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",IMGPATH,date]];
    UIImage * image = [UIImage imageWithData:data];
    CGFloat f = image.size.width/image.size.height;
    return f;
}

+(void)saveIconImag:(UIImage *)image withName:(NSString *)name{
    NSData * data = UIImagePNGRepresentation(image);
    [data writeToFile:[NSString stringWithFormat:@"%@/%@",IMGPATH,name] atomically:YES];
}

@end
