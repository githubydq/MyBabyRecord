//
//  DQShowFirstViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/13.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQShowFirstViewController.h"
#import "DQShowFirstImageViewController.h"
#import "FirstModel.h"

@interface DQShowFirstViewController ()
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property(nonatomic,strong)FirstModel * model;
@end

@implementation DQShowFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self configNav];
    self.detail.text = self.model.detail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    self.model = [Singleton shareInstance].firstModelArray[self.index];
}

#pragma mark -
#pragma mark 初始化导航
-(void)configNav{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = self.model.title;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查看大图" style:UIBarButtonItemStylePlain target:self action:@selector(showFirstRightClick)];
}
-(void)showFirstRightClick{
    DQShowFirstImageViewController * imageVC = [[DQShowFirstImageViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    imageVC.index = self.index;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imageVC animated:NO];
}

@end
