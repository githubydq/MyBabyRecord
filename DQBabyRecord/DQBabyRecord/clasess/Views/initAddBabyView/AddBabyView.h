//
//  AddBabyView.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/30.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^babyBlock)(NSString * name);
@interface AddBabyView : UIView
@property(nonatomic,copy)babyBlock block;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@end
