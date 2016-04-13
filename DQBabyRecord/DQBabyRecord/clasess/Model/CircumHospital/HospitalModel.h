//
//  HospitalModel.h
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/9.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HospitalModel : NSObject
@property(nonatomic,assign)NSInteger ID;/**<id*/
@property(nonatomic,copy)NSString * name;/**<名字*/
@property(nonatomic,copy)NSString * address;/**<位置*/
@property(nonatomic,assign)CGFloat x;/**<*/
@property(nonatomic,assign)CGFloat y;/**<*/
@property(nonatomic,assign)NSInteger area;/**<城市*/
@property(nonatomic,copy)NSString * mtype;/**<医保类型*/
@property(nonatomic,copy)NSString * level;/**<医院等级*/
@end
/**
 
 {
 address = "\U5854\U57ce\U5e02";
 area = 361;
 count = 94;
 fax = "";
 fcount = 0;
 gobus = "<p> </p>";
 id = 23248;
 img = "/hospital/080616/51a87d7c2c85f68e7324d61c950c3e57.jpg";
 level = "\U5176\U4ed6";
 mail = "";
 mtype = "\U5c45\U6c11\U533b\U4fdd";
 name = "\U5854\U57ce\U5e02\U809b\U80a0\U4e13\U79d1\U533b\U9662";
 nature = "";
 rcount = 0;
 tel = "0901-6225859";
 url = "";
 x = "82.98399999999999";
 y = "46.7463";
 zipcode = 834700;
 }
 */