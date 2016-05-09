//
//  DQAddBabyViewController.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/5/9.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQAddBabyViewController.h"
#import "AppDelegate.h"

#import "BabyDao.h"
#import "BabyModel.h"

@interface DQAddBabyViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *myTitle;

@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *sexTextF;

@property (weak, nonatomic) IBOutlet UITextField *birthTextF;

@property (weak, nonatomic) IBOutlet UIButton *welcomeBtn;


@property(nonatomic,strong)UIPickerView * sexPicker;
@end

@implementation DQAddBabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark config UI
-(void)configUI{
    if (!self.isWelcome) {
        self.welcomeBtn.hidden = YES;
        self.view.backgroundColor = BACK_COLOR;
        self.myTitle.hidden = YES;
        
        [self configNav];
    }

    [self setSexKeyboard];
    [self setBirthdayKeyboard];
}

#pragma mark -
#pragma mark configNav
-(void)configNav{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addBabyRightClick)];
}
-(void)addBabyRightClick{
    if ([self infoCorrect]) {
        BabyModel * model = [[BabyModel alloc] init];
        model.name = self.nameTextF.text;
        model.sex = self.sexTextF.text;
        model.birthday = self.birthTextF.text;
        [BabyDao save:model];
        [[NSUserDefaults standardUserDefaults] setObject:model.name forKey:NOW_BABY];
        
        self.block(YES);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark set keyboard style
-(void)setSexKeyboard{
    self.sexPicker = [[UIPickerView alloc] init];
    self.sexPicker.dataSource = self;
    self.sexPicker.delegate = self;
    self.sexTextF.inputView = self.sexPicker;
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
    self.birthTextF.inputView = picker;
}

#pragma mark pickerview delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 3;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([pickerView isEqual:self.sexPicker]) {
        switch (row) {
            case 0:
                return @"";
                break;
            case 1:
                return @"男";
                break;
            case 2:
                return @"女";
                break;
            default:
                break;
        }
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString * sexStr = nil;
    switch (row) {
        case 1:
            sexStr = @"男";
            break;
        case 2:
            sexStr = @"女";
            break;
        default:
            break;
    }
    self.sexTextF.text = sexStr;
}

#pragma mark datepicker target
-(void)AddBabyViewDatePicker:(UIDatePicker*)picker{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [format stringFromDate:picker.date];
    self.birthTextF.text = timeStr;
}

#pragma mark -
#pragma mark judge
-(BOOL)infoCorrect{
    BOOL isOK = YES;
    if (self.nameTextF.text.length <= 0) {
        isOK = NO;
    }
    if (self.sexTextF.text.length <= 0) {
        isOK = NO;
    }
    if (self.birthTextF.text.length <= 0) {
        isOK = NO;
    }
    return isOK;
}

#pragma mark -
#pragma mark btnClick

- (IBAction)welcomeClick:(id)sender {
    if ([self infoCorrect]) {
        
        BabyModel * model = [[BabyModel alloc] init];
        model.name = self.nameTextF.text;
        model.sex = self.sexTextF.text;
        model.birthday = self.birthTextF.text;
        [BabyDao save:model];
        [[NSUserDefaults standardUserDefaults] setObject:model.name forKey:NOW_BABY];
        
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] intoDrawer];
    }
}

#pragma mark -
#pragma mark tap Click
- (IBAction)backClick:(UITapGestureRecognizer *)sender {
    if ([self.nameTextF isFirstResponder]) {
        [self.nameTextF resignFirstResponder];
    }
    if ([self.sexTextF isFirstResponder]) {
        [self.sexTextF resignFirstResponder];
    }
    if ([self.birthTextF isFirstResponder]) {
        [self.birthTextF resignFirstResponder];
    }
}


@end
