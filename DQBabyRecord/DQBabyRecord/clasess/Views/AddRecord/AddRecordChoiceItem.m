//
//  AddRecordChoiceItem.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/4.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddRecordChoiceItem.h"

@interface AddRecordChoiceItem ()
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

@end

@implementation AddRecordChoiceItem

+(instancetype)addRecordChoiceItem{
    return [[[NSBundle mainBundle] loadNibNamed:@"AddRecordChoiceItem" owner:nil options:nil] firstObject];
}

//-(instancetype)init{
//    
//}

//-(void)awakeFromNib{
//    [super awakeFromNib];
//    
//}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addRecordChoiceItemClick)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    self.itemLabel.text = _dataArray.firstObject;
    
    self.itemLabel.backgroundColor = [UIColor blueColor];
//    NSLog(@"----%@",self.itemLabel);
}

-(void)addRecordChoiceItemClick{
    self.block(self.dataArray[1]);
}

@end
