//
//  AddCaseViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/5.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddCaseViewController.h"
#import "MyCaseModel.h"
#import "MyCaseDao.h"

@interface AddCaseViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeHold;

@property(nonatomic,strong)MyCaseModel * model;
@property(nonatomic,copy)NSString * dateString;

@end

@implementation AddCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
    [self loadData];
    [self initNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}

#pragma mark 初始化

-(void)initNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(addCaseLeftClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(addCaseRightClick)];
}

#pragma mark -
#pragma mark 点击事件

-(void)addCaseLeftClick{
    UIViewController * vc = self.navigationController.viewControllers.firstObject;
    [vc removeFromParentViewController];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addCaseRightClick{
    self.model = [[MyCaseModel alloc] init];
    self.model.name = [[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY];
    self.model.date = [TimeHelper getNowTime];
    self.model.detail = self.textView.text;
    [MyCaseDao save:self.model];
    [[Singleton shareInstance].caseModelArray insertObject:self.model atIndex:0];
    [self addCaseLeftClick];
}

#pragma mark 加载数据
-(void)loadData{
    self.textView.text = nil;
    self.placeHold.text = @"宝宝生病了，赶紧记下来了";
    self.dateString = [TimeHelper getNowTime];
    self.date.text = [TimeHelper getNowTimeWithTime:self.dateString];
}

#pragma mark -
#pragma mark 文本视图代理
-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@""] || !textView.text) {
        self.placeHold.alpha = 0.5;
    }else{
        self.placeHold.alpha = 0.0;
    }
}

@end
