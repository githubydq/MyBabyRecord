//
//  RecordCollectionViewCell.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "RecordCollectionViewCell.h"
#import "RecordModel.h"

#import "TimeHelper.h"

@interface RecordCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *Image;
@property (strong, nonatomic) IBOutlet UILabel *date;

@end

@implementation RecordCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setData:(RecordModel *)model{
    self.date.text = [TimeHelper getNowTimeWithTime:model.date];
    
//    self.Image.image = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage * image = [ImageHelper getImageWithName:model.date];
        UIGraphicsBeginImageContext(self.bounds.size);
        [image drawInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.Image setImage:image];
        });
    });
}

@end
