//
//  CircumHospitalTableViewCell.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/9.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HospitalModel;
@class CLLocation;
@interface CircumHospitalTableViewCell : UITableViewCell
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)CLLocation * userLocation;
@property(nonatomic,strong)HospitalModel * model;
@end
