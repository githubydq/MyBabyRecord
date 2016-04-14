//
//  MultiSelectButton.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/3.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "MultiSelectButton.h"
#import "SquareRadioButton.h"

@interface MultiSelectButton ()
@property(nonatomic,strong)NSMutableArray * btnArray;
@end

@implementation MultiSelectButton

-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray new];
    }
    return _btnArray;
}



-(void)setChoiceItems:(NSArray *)choiceItems{
    _choiceItems = choiceItems;
    
    CGFloat numbers = choiceItems.count;
    CGFloat itemWidth = self.frame.size.width/numbers;
    CGFloat height = self.frame.size.height;
    
    for (int i = 0 ; i < choiceItems.count; i++) {
        SquareRadioButton * btn = [SquareRadioButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(itemWidth*i, 0, itemWidth/3.0, height);
        btn.backgroundColor = [UIColor orangeColor];
        [btn addTarget:self action:@selector(multiRadioClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.isChoiced = NO;
        btn.index = i;
        [self addSubview:btn];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth*i+itemWidth/3.0, 0, itemWidth*2.0/3.0, height)];
        label.text = choiceItems[i];
        label.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        
        [self.btnArray addObject:btn];
    }
}

/**多选按钮点击*/
-(void)multiRadioClick:(SquareRadioButton*)btn{
    if (!btn.isChoiced) {
        for (int i = 0; i < self.btnArray.count; i++) {
            SquareRadioButton * button = self.btnArray[i];
            if (i == btn.index) {
                button.isChoiced = YES;
            }else{
                button.isChoiced = NO;
            }
            [button setNeedsDisplay];
        }
        
    }
    self.block(self.choiceItems[btn.index]);
}

@end
