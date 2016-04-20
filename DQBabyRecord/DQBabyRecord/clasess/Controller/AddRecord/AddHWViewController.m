//
//  AddHWViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/5.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddHWViewController.h"
#import "HealthDao.h"
#import "HealthModel.h"

@interface AddHWViewController ()
@property (weak, nonatomic) IBOutlet UITextField *height;
@property (weak, nonatomic) IBOutlet UITextField *weight;


@property(nonatomic,strong)HealthModel * model;
@end

@implementation AddHWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
    // Do any additional setup after loading the view from its nib.
    [self initNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.height resignFirstResponder];
    [self.weight resignFirstResponder];
}

#pragma mark 初始化

-(void)initNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(addHWLeftClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(addHWRightClick)];
}

-(void)addHWLeftClick{
    UIViewController * vc = self.navigationController.viewControllers.firstObject;
    [vc removeFromParentViewController];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addHWRightClick{
    if (![self isIncludeEmpty]) {
        self.model = [[HealthModel alloc] init];
        self.model.name = [[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY];
        self.model.date = [TimeHelper getNowTime];
        self.model.height = self.height.text;
        self.model.weight = self.weight.text;
        [HealthDao save:self.model];
        [[Singleton shareInstance].healthModelArray insertObject:self.model atIndex:0];
        [self addHWLeftClick];
    }else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"请将记录填完整，不然宝贝会不开心的" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


#pragma mark -
#pragma mark 逻辑判断
-(BOOL)isIncludeEmpty{
    BOOL judge = NO;
    if (self.height.text.length <= 0) {
        judge = YES;
    }
    if (self.weight.text.length <= 0) {
        judge = YES;
    }
    return judge;
}
@end
