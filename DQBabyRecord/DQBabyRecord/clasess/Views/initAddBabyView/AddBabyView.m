//
//  AddBabyView.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/30.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddBabyView.h"
#import "BabyModel.h"
#import "BabyDao.h"

@interface AddBabyView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *first;
@property (weak, nonatomic) IBOutlet UIImageView *second;
@property (weak, nonatomic) IBOutlet UIImageView *third;

@end

@implementation AddBabyView

-(void)awakeFromNib{
    NSLog(@"2123321");
}

- (IBAction)complete:(id)sender {
    BabyModel * model = [[BabyModel alloc] init];
    model.name = self.name.text;
    model.sex = self.sex.text;
    model.birthday = self.birthday.text;
    [self.name resignFirstResponder];
    [self.sex resignFirstResponder];
    [self.birthday resignFirstResponder];
    __block AddBabyView * blockSelf = self;
    if ([self infoCorrect]) {
        [BabyDao save:model];
        blockSelf.block(model.name);
        [blockSelf removeFromSuperview];
    }
}

-(BOOL)infoCorrect{
    BOOL isko = YES;
    if (self.name.text.length <= 0) {
        [self.first setHidden:NO];
        isko = NO;
    }
    if (self.sex.text.length <= 0) {
        [self.second setHidden:NO];
        isko = NO;
    }
    if (self.birthday.text.length <= 0) {
        [self.third setHidden:NO];
        isko = NO;
    }
    return isko;
}

- (IBAction)nameValueChange:(id)sender {
    [self.first setHidden:YES];
}

- (IBAction)sexValueChange:(id)sender {
    [self.second setHidden:YES];
}

- (IBAction)birthdayValueChange:(id)sender {
    [self.third setHidden:YES];
}

- (IBAction)tapClick:(id)sender {
    [self.name resignFirstResponder];
    [self.sex resignFirstResponder];
    [self.birthday resignFirstResponder];
}

@end
