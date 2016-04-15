//
//  HospitalMapKitViewController.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/9.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLocation;
@class HospitalModel;
@interface HospitalMapKitViewController : UIViewController
@property(nonatomic,strong)CLLocation * userLocaton;/**<用户位置*/
@property(nonatomic,strong)CLLocation * otherLocation;/**<其他位置信息*/
@property(nonatomic,strong)HospitalModel * model;
@end
