//
//  CircumHospitalTableViewCell.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/9.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "CircumHospitalTableViewCell.h"
#import "HospitalModel.h"

#import <MapKit/MKUserLocation.h>

@interface CircumHospitalTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *xy;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *adress;

@end

@implementation CircumHospitalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HospitalModel *)model{
    self.name.text = [NSString stringWithFormat:@"%ld.%@",self.index,model.name];
    self.level.text = model.level;
    self.adress.text = model.address;
    CLLocation * location = [[CLLocation alloc] initWithLatitude:model.y longitude:model.x];
    NSInteger meter = [location distanceFromLocation:self.userLocation];
    if (meter/1000 > 0) {
        self.xy.text = [NSString stringWithFormat:@"%ldkm",meter/1000];
    }else{
        self.xy.text = [NSString stringWithFormat:@"%ldm",meter];
    }
}

@end
