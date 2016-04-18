//
//  BabyInfoViewController.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/12.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BabyModel;

@protocol BabyInfoDelegate <NSObject>

@required
/**保存修改数据并刷新*/
-(void)saveModel:(BabyModel*)model;

@end

@interface BabyInfoViewController : UIViewController
@property(nonatomic,strong)BabyModel * model;
@property(nonatomic,weak)id <BabyInfoDelegate> delegate;
@end
