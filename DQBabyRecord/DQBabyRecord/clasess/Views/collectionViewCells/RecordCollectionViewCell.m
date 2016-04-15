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
    NSString * year = [model.date substringWithRange:NSMakeRange(0, 4)];
    NSString * mouth = [model.date substringWithRange:NSMakeRange(4, 2)];
    NSString * day = [model.date substringWithRange:NSMakeRange(6, 2)];
    self.date.text = [NSString stringWithFormat:@"%@/%@/%@",year,mouth,day];
    
//    self.Image.image = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage * image = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",SMALL_IMG_PATH,model.image]];
        UIGraphicsBeginImageContext(self.bounds.size);
        [image drawInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.Image.image = image;
        });
    });
}

@end
