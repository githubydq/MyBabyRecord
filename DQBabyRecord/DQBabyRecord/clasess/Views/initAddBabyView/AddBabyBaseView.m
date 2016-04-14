//
//  AddBabyBaseView.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/30.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddBabyBaseView.h"
#import "MultiSelectButton.h"

@interface AddBabyBaseView ()

@property(nonatomic,strong)UILabel * mytitle;
@property(nonatomic,strong)UITextField * ntextfield;/**<姓名输入*/
@property(nonatomic,copy)NSString * sexString;
@property(nonatomic,strong)UITextField * btextfield;/**<生日输入*/
@end

@implementation AddBabyBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBabyTapClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


//setter

-(void)setIsLastView:(BOOL)isLastView{
    _isLastView = isLastView;
    [self addBaseView:isLastView];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _mytitle.text = [NSString stringWithFormat:@"请输入%@",title];
}

//shoushi
-(void)addBabyTapClick:(UITapGestureRecognizer*)tap{
    NSLog(@"dianjishoushi");
    if (self.ntextfield.isFirstResponder) {
        [self.ntextfield resignFirstResponder];
    }
    if (self.btextfield.isFirstResponder) {
        [self.btextfield resignFirstResponder];
    }
}

//添加输入框
-(void)addInput:(NSInteger)index{
    switch (index) {
        case 0:
            [self addName];
            break;
        case 1:
            [self addSex];
            break;
        case 2:
            [self addBirthDay];
            break;
        case 3:
            
            break;
        default:
            break;
    }
}

//添加下一步按钮
-(void)addBaseView:(BOOL)islast{
    //title
    self.mytitle = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/6, SCREEN_WIDTH, 40)];
//    self.mytitle.text = @"请输入姓名";
    self.mytitle.font = [UIFont boldSystemFontOfSize:25];
    self.mytitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.mytitle];
    //next step
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT*5/6, 100, 40);
    [btn setTitle:(islast ? @"完成" : @"下一步") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [self addSubview:btn];
}

//添加姓名
-(void)addName{
    UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, (SCREEN_HEIGHT-40)/2, 200, 40)];
    textfield.textAlignment = NSTextAlignmentCenter;
    textfield.backgroundColor = [UIColor whiteColor];
    [self addSubview:textfield];
    self.ntextfield = textfield;
}
//添加性别
-(void)addSex{
    MultiSelectButton * multiSex = [[MultiSelectButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, (SCREEN_HEIGHT-40)/2, 200, 40)];
    multiSex.choiceItems = @[@"男",@"女"];
    multiSex.block = ^(NSString * item){
        NSLog(@"%@",item);
        self.sexString = item;
    };
    [self addSubview:multiSex];
}
//添加生日
-(void)addBirthDay{
    UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, (SCREEN_HEIGHT-40)/2, 200, 40)];
    textfield.textAlignment = NSTextAlignmentCenter;
    textfield.backgroundColor = [UIColor whiteColor];
    textfield.inputView = [self addDatePicker];
    [self addSubview:textfield];
    self.btextfield = textfield;
}

-(UIDatePicker*)addDatePicker{
    //1.创建时间选择器UIDatePicker
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    //2.设置时间选择器的模式
    picker.datePickerMode = UIDatePickerModeDate;
    
    //3.设置默认的时间
    //定义一个默认时间的字符串
    NSString *dateStr = @"1990-1-1";
    //创建日期格式转换器
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //设置日期格式
    [format setDateFormat:@"yyyy-MM-dd"];
    //设置时间区
    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    //将默认时间的字符串转换成NSDate时间类的对象
    NSDate *date = [format dateFromString:dateStr];
    
    //4.给时间选择器设置初始值
    picker.date = date;
    //5.给时间选择器添加target事件
    [picker addTarget:self action:@selector(birthdayChoose:) forControlEvents:UIControlEventValueChanged];
    return picker;
}

-(void)birthdayChoose:(UIDatePicker *)picker
{
    //创建时间转换器
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //设置时间的格式
    [format setDateFormat:@"yyyy-MM-dd"];
    //设置时间区
    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    //将时间转换成字符串格式
    NSString *timeStr = [format stringFromDate:picker.date];
    //将时间字符串显示在文本框中
    self.btextfield.text = timeStr;
}

//添加图片

-(void)btnClick:(UIButton*)button{
    NSInteger index = self.frame.origin.x/SCREEN_WIDTH;
    NSString * string = nil;
    if (index == 0) {
        string = self.ntextfield.text;
    }else if (index == 1){
        string = self.sexString;
    }else if (index == 2){
        string = self.btextfield.text;
    }
    self.myBtnBlock(self.frame.origin,string);
}

@end
