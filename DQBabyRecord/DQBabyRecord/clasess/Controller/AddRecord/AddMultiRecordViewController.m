//
//  AddMultiRecordViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/5.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddMultiRecordViewController.h"

@interface AddMultiRecordViewController ()
@property(nonatomic,strong)NSArray * itemArray;/**<选项按钮*/
@property(nonatomic,strong)NSArray * itemVCNameArray;/**<选项推送VC*/

@property(nonatomic,assign)CGFloat width;
@end

@implementation AddMultiRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showItem];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 初始化
-(void)initUI{
    for (int i = 0 ; i < self.itemArray.count; i++) {
        NSInteger col = i%3;
        UIView * v = self.itemArray[i];
        v.frame = CGRectMake(self.width/2.0 + (self.width*3.0/2.0)*col, SCREEN_HEIGHT, self.width, self.width*3/2.0);
        [self.view addSubview:v];
    }
}

-(void)loadData{
    self.width = SCREEN_WIDTH/5.0;
    self.itemArray = @[
                       [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] objectAtIndex:1],
                       [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] objectAtIndex:2],
                       [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] objectAtIndex:3],
                       [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] objectAtIndex:4]];
    
    self.itemVCNameArray = @[@"AddImageRecordViewController"
                            ,@"AddFirstViewController"
                            ,@"AddHWViewController"
                            ,@"AddCaseViewController"];
}


#pragma mark 设置退出
-(void)quit{
    [self hideItem];
}

#pragma mark 点击事件
- (IBAction)closeClick:(UIButton *)sender {
    [self quit];
}

- (IBAction)backClick:(UITapGestureRecognizer *)sender {
    NSLog(@"back");
}
- (IBAction)View1Click:(UITapGestureRecognizer *)sender {
    UIViewController * vc = [[NSClassFromString(self.itemVCNameArray[0]) alloc] init];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:vc animated:NO];
}
- (IBAction)View2Click:(UITapGestureRecognizer *)sender {
    UIViewController * vc = [[NSClassFromString(self.itemVCNameArray[1]) alloc] init];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:vc animated:NO];
}
- (IBAction)View3Click:(UITapGestureRecognizer *)sender {
    UIViewController * vc = [[NSClassFromString(self.itemVCNameArray[2]) alloc] init];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:vc animated:NO];
}
- (IBAction)View4Click:(UITapGestureRecognizer *)sender {
    UIViewController * vc = [[NSClassFromString(self.itemVCNameArray[3]) alloc] init];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:vc animated:NO];
}


#pragma mark 显示隐藏item
-(void)showItem{
    for (int i = 0 ; i < self.itemArray.count ; i++) {
        NSInteger row = i/3;
        UIView * v = self.itemArray[i];
        [UIView animateWithDuration:0.2+0.03*i animations:^{
            v.transform = CGAffineTransformMakeTranslation(0, -(SCREEN_HEIGHT*2/3.0 - row*(self.width*3/2.0+30)));
        }];
//        NSLog(@"%@",v);
    }
}

-(void)hideItem{
    for (int i = 0 ; i < self.itemArray.count ; i++) {
        UIView * v = self.itemArray[i];
        [UIView animateWithDuration:0.3-0.04*i animations:^{
            v.transform = CGAffineTransformMakeTranslation(0, 0);
        }completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }
}

@end
