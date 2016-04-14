//
//  AddBabyBaseView.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/30.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnBlock)(CGPoint point,NSString * string);

@interface AddBabyBaseView : UIView
@property(nonatomic,assign)BOOL isLastView;
@property(nonatomic,copy)btnBlock myBtnBlock;
@property(nonatomic,copy)NSString * title;

-(void)addInput:(NSInteger)index;
@end
