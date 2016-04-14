//
//  RecordCollectionViewCell.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecordModel;
@interface RecordCollectionViewCell : UICollectionViewCell
-(void)setData:(RecordModel*)model;
@end
