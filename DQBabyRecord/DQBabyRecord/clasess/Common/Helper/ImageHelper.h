//
//  ImageHelper.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/26.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@interface ImageHelper : NSObject
/**保存图片*/
+(void)saveImage:(UIImage*)image withName:(NSString *)date;
/**读取图片，缩放*/
+(UIImage *)getImageWithName:(NSString*)date;
/**返回图片宽高比*/
+(float)getScaleWithName:(NSString*)date;
/**保存宝贝icon*/
+(void)saveIconImag:(UIImage *)image withName:(NSString *)name;
@end
