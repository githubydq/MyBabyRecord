//
//  Singleton.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
@property(nonatomic,strong)NSArray * LifeRecordArray;/**<生活记录列表*/
@property(nonatomic,strong)NSArray * LifeRecordVCArray;/**<生活记录VC列表*/
@property(nonatomic,strong)NSMutableArray * recordModelArray;/**<图片记录数组*/
@property(nonatomic,strong)NSMutableArray * healthModelArray;/**<健康记录数组*/
@property(nonatomic,strong)NSMutableArray * firstModelArray;/**<第一次记录数组*/
@property(nonatomic,strong)NSMutableArray * caseModelArray;/**<病例记录数组*/
+(instancetype)shareInstance;
@end
