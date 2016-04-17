//
//  AddBabyView.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/30.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddBabyView;
@protocol AddBabyViewDelegate <NSObject>

@required
-(void)addBabyView:(AddBabyView *)view CompleteAndName:(NSString*)name Sex:(NSString*)sex Birthday:(NSString*)birthday;

@end

@interface AddBabyView : UIView
@property(nonatomic,assign)id <AddBabyViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@end
