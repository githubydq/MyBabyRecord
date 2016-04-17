//
//  AddBabyView.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/30.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddBabyView.h"

@interface AddBabyView ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *first;
@property (weak, nonatomic) IBOutlet UIImageView *second;
@property (weak, nonatomic) IBOutlet UIImageView *third;

@property(nonatomic,strong)UIPickerView * sexPicker;

@end

@implementation AddBabyView

-(void)awakeFromNib{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddBabyViewTapClick)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    
    [self setSexKeyboard];
    [self setBirthdayKeyboard];
}

#pragma mark -
#pragma mark set keyboard style
-(void)setSexKeyboard{
    self.sexPicker = [[UIPickerView alloc] init];
    self.sexPicker.dataSource = self;
    self.sexPicker.delegate = self;
    self.sex.text = @"男";
    self.sex.inputView = self.sexPicker;
}

-(void)setBirthdayKeyboard{
    UIDatePicker * picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString * dateString = @"1990-1-1";
    NSDate * date = [format dateFromString:dateString];
    picker.date = date;
    [picker addTarget:self action:@selector(AddBabyViewDatePicker:) forControlEvents:UIControlEventValueChanged];
    self.birthday.inputView = picker;
}

#pragma mark pickerview delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([pickerView isEqual:self.sexPicker]) {
        return row==0 ? @"男":@"女";
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.sex.text = row==0 ? @"男":@"女";
}

#pragma mark datepicker target
-(void)AddBabyViewDatePicker:(UIDatePicker*)picker{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [format stringFromDate:picker.date];
    self.birthday.text = timeStr;
}

#pragma mark -
#pragma mark tap gesture
-(void)AddBabyViewTapClick{
    if ([self.name isFirstResponder]) {
        [self.name resignFirstResponder];
    }
    if ([self.sex isFirstResponder]) {
        [self.sex resignFirstResponder];
    }
    if ([self.birthday isFirstResponder]) {
        [self.birthday resignFirstResponder];
    }
}

#pragma mark -
#pragma mark complete click
- (IBAction)complete:(id)sender {
    __block AddBabyView * blockSelf = self;
    if ([self infoCorrect]) {
        [blockSelf.delegate addBabyView:blockSelf CompleteAndName:blockSelf.name.text Sex:blockSelf.sex.text Birthday:blockSelf.birthday.text];
    }
}

#pragma mark -
#pragma mark judge
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

#pragma mark -
#pragma mark begin edit
- (IBAction)nameValueChange:(id)sender {
    [self.first setHidden:YES];
}

- (IBAction)sexValueChange:(id)sender {
    [self.second setHidden:YES];
}

- (IBAction)birthdayValueChange:(id)sender {
    [self.third setHidden:YES];
}

#pragma mark -
#pragma mark cancel
- (IBAction)cancel:(id)sender {
    [self removeFromSuperview];
}

@end
