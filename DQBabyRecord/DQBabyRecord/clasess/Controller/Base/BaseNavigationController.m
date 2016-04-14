//
//  BaseNavigationController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [self.navigationBar setTitleTextAttributes:attrs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
