//
//  MainViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/17.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "MainViewController.h"
#import "RecordViewController.h"
#import "MoreViewController.h"

#import "AddBabyView.h"

#import "AddMultiRecordViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate>
{
    NSArray * _VCNameArray;
    NSArray * _TabbarTitle;
    NSMutableArray * _VCArray;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self setTabbar];
    [self configAddVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configBaby];
}

#pragma mark -
#pragma mark 添加宝贝

/** 是否至少有一个宝贝 */
-(void)configBaby{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * baby = [user objectForKey:NOW_BABY];
    if (!baby) {
        NSLog(@"no baby");
        AddBabyView * v = [[AddBabyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        v.block = ^(NSString * name){
            
        };
        v.backgroundColor = [UIColor blackColor];
        [[UIApplication sharedApplication].keyWindow addSubview:v];
    }
}

#pragma mark -
#pragma mark 初始化UI

-(void)configUI{
    self.delegate = self;
    self.tabBar.tintColor = [UIColor orangeColor];
    //tabbarItem
    _VCNameArray = @[@"RecordViewController",@"",@"MoreViewController"];
    _TabbarTitle = @[@"生活记录",@"",@"更多"];
    //标签控制器
    _VCArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < _VCNameArray.count ; i++) {
        UIViewController * vc = [[NSClassFromString(_VCNameArray[i]) alloc]init];
        [_VCArray addObject:[[BaseNavigationController alloc] initWithRootViewController:vc]];
    }
}


#pragma mark -
#pragma mark 添加记录界面
//设置添加界面按钮
-(void)configAddVC{
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake((self.tabBar.frame.size.width-40)/2.0, 5, 40, 40);
    [addBtn setImage:[UIImage imageNamed:@"addrecord40x40"] forState:UIControlStateNormal];
    addBtn.userInteractionEnabled = NO;
    [self.tabBar addSubview:addBtn];
}

-(void)addRecordClick{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY]) {
        AddMultiRecordViewController * addMultiRecord = [[AddMultiRecordViewController alloc] init];
        BaseNavigationController * baseNav = [[BaseNavigationController alloc] initWithRootViewController:addMultiRecord];
        [self presentViewController:baseNav animated:NO completion:nil];
        
    }
}

#pragma mark -
#pragma mark 设置tabbar

/** 设置标签 */
-(void)setTabbar{
    [self setViewControllers:_VCArray];
    NSArray * imgArr = @[@"home30x30",@"",@"mine30x30"];
    NSArray * arr = self.viewControllers;
    for (int i = 0 ; i < arr.count ; i++) {
        UIViewController * viewController = arr[i];
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:_TabbarTitle[i] image:[UIImage imageNamed:imgArr[i]] selectedImage:nil];
        [viewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    self.selectedIndex = 0;
}



#pragma mark -
#pragma mark 数据请求

#pragma mark -
#pragma mark 代理

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    BaseNavigationController * baseNav = (BaseNavigationController*)viewController;
    if (!NSStringFromClass(baseNav.viewControllers.firstObject.class)) {
        [self addRecordClick];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark -
#pragma mark 业务逻辑

#pragma mark -
#pragma mark 通知注册和销毁


@end
