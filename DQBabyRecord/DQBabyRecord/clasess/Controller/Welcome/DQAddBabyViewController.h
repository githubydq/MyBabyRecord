//
//  DQAddBabyViewController.h
//  DQBabyRecord
//
//  Created by youdingquan on 16/5/9.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQAddBabyViewController : UIViewController
@property(nonatomic,assign)BOOL isWelcome;
@property(nonatomic,copy)void (^block)(BOOL isAddBaby);
@end
