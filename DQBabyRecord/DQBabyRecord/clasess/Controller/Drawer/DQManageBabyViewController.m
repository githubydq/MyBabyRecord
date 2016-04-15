//
//  DQManageBabyViewController.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQManageBabyViewController.h"
#import "AddBabyView.h"
#import "BabyDao.h"
#import "BabyModel.h"
#import "RecordDao.h"
#import "FirstDao.h"
#import "HealthDao.h"
#import "MyCaseDao.h"

@interface DQManageBabyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@property(nonatomic,strong)NSMutableArray * modelArray;
@end

@implementation DQManageBabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self configUI];
//    self.myTable.editing = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark 初始化UI
-(void)configUI{
    self.navigationItem.title = @"管理宝贝";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加宝贝" style:UIBarButtonItemStylePlain target:self action:@selector(manageBabyRightClick)];
}
-(void)manageBabyRightClick{
    AddBabyView * v = [[AddBabyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    __block DQManageBabyViewController * blockSelf =self;
    v.block = ^(){
        NSLog(@"2342");
        [blockSelf loadData];
        [blockSelf.myTable reloadData];
    };
    v.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:v];
}

#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    self.modelArray = [BabyDao findAll];
}

#pragma mark -
#pragma mark 表格代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"managebabycell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BabyModel * model = self.modelArray[indexPath.row];
    cell.textLabel.text = model.name;
    if ([model.name isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY]]) {
        cell.detailTextLabel.text = @"当前宝贝";
    }else{
        cell.detailTextLabel.text = nil;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:NOW_BABY];
        [self deleteBabyAtModel:self.modelArray[indexPath.row]];
        [self.modelArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BabyModel * model = self.modelArray[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:model.name forKey:NOW_BABY];
    [tableView reloadData];
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"点击切换当前宝贝";
}

#pragma mark -
#pragma mark delete
-(void)deleteBabyAtModel:(BabyModel*)model{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:NOW_BABY];
    [BabyDao deleteAtId:model.babyid];
    [RecordDao deleteAtName:model.name];
    [FirstDao deleteAtName:model.name];
    [HealthDao deleteAtName:model.name];
    [MyCaseDao deleteAtName:model.name];
    [[Singleton shareInstance].recordModelArray removeAllObjects];
    [[Singleton shareInstance].firstModelArray removeAllObjects];
    [[Singleton shareInstance].healthModelArray removeAllObjects];
    [[Singleton shareInstance].caseModelArray removeAllObjects];
}

@end
