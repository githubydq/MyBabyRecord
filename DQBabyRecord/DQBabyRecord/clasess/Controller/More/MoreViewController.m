//
//  MoreViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/8.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "MoreViewController.h"
#import "CircumHospitalViewController.h"
#import "WeatherViewController.h"



@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@property(nonatomic,strong)NSArray * listArray;/**<列表*/

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark 懒加载
-(NSArray *)listArray{
    if (!_listArray) {
        _listArray = [NSArray new];
    }
    return _listArray;
}

#pragma mark -
#pragma mark 初始化UI
-(void)initUI{
    self.navigationItem.title = @"生活";
}

#pragma mark -
#pragma mark 数据加载
-(void)loadData{
    self.listArray = @[@[@"周边医院"],@[@"天气"]];
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
    static NSString * identify = @"morecell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CircumHospitalViewController * circum = [[CircumHospitalViewController alloc] init];
            [self pushVC:circum];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self pushVC:[[WeatherViewController alloc] init]];
        }
    }
}


#pragma mark -
#pragma mark 跳转下一界面
-(void)pushVC:(UIViewController*)vc{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
    self.hidesBottomBarWhenPushed = NO;
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
