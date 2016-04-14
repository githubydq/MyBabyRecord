//
//  LeftDrawerViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/6.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "LeftDrawerViewController.h"
#import <MMDrawerController.h>
#import <UIViewController+MMDrawerController.h>
#import "MainViewController.h"
#import "BabyModel.h"
#import "BabyDao.h"

#import "LeftDrawerSetViewController.h"
#import "LeftDrawerRemindViewController.h"
#import "BabyInfoViewController.h"

@interface LeftDrawerViewController ()<BabyInfoDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex_age;

@property(nonatomic,strong)BabyModel * model;

@end

@implementation LeftDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark 初始化数据
-(void)loadData{
    self.model = [BabyDao findByName:[[NSUserDefaults standardUserDefaults]objectForKey:NOW_BABY]];
    self.name.text = self.model.name;
    self.sex_age.text = [NSString stringWithFormat:@"%@  %@",self.model.sex,[TimeHelper getNowAge:self.model.birthday]];
}

#pragma mark 点击事件
//推送界面
-(void)pushVC:(UIViewController*)vc animated:(BOOL)animated{
    MainViewController * tabbar = (MainViewController*)self.mm_drawerController.centerViewController;
    BaseNavigationController * baseNav = (BaseNavigationController*)tabbar.selectedViewController;
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    baseNav.viewControllers.firstObject.hidesBottomBarWhenPushed = YES;
    baseNav.viewControllers.firstObject.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [baseNav.viewControllers.firstObject.navigationController pushViewController:vc animated:animated];
    baseNav.viewControllers.firstObject.hidesBottomBarWhenPushed = NO;
}

#pragma mark -
#pragma mark 宝贝信息修改
- (IBAction)MyBabyClick:(id)sender {
    BabyInfoViewController * babyinfo = [[BabyInfoViewController alloc] init];
    babyinfo.delegate = self;
    babyinfo.model = self.model;
    [self pushVC:babyinfo animated:NO];
}
-(void)saveModel:(BabyModel *)model{
    [BabyDao updateMajor:model];
    self.icon.image = [ImageHelper getImageWithName:model.image];
    self.name.text = model.name;
    self.sex_age.text = [NSString stringWithFormat:@"%@  %@",model.sex,[TimeHelper getNowAge:model.birthday]];
}

#pragma mark -
#pragma mark 设置
- (IBAction)MySetClick:(id)sender {
    LeftDrawerSetViewController * vc = [[LeftDrawerSetViewController alloc] init];
    vc.view.backgroundColor = BACK_COLOR;
    [self pushVC:vc animated:YES];
}
- (IBAction)remindClick:(id)sender {
    LeftDrawerRemindViewController * vc = [[LeftDrawerRemindViewController alloc] init];
    vc.view.backgroundColor = BACK_COLOR;
    [self pushVC:vc animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
