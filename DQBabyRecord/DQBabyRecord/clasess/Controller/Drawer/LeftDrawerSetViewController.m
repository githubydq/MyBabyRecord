//
//  LeftDrawerSetViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/10.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "LeftDrawerSetViewController.h"
#import "DQManageBabyViewController.h"

@interface LeftDrawerSetViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property(nonatomic,strong)NSArray * listArray;
@end

@implementation LeftDrawerSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 初始化uI
-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"设置";
}


#pragma mark -
#pragma mark 初始化数据
-(void)loadData{
    self.listArray = @[@[@"管理宝贝"],@[@"关于"]];
}

#pragma mark -
#pragma mark 表格代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listArray[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"setcell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DQManageBabyViewController * manage = [[DQManageBabyViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:manage animated:NO];
        }
    }
}
@end
