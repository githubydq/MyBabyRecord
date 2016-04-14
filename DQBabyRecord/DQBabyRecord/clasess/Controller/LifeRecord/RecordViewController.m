//
//  RecordViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/12.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "RecordViewController.h"
#import "WaterflowLayout.h"

#import "RecordCollectionViewCell.h"
#import "DQFirstTableViewCell.h"
#import "DQMyCaseTableViewCell.h"
#import "RecordModel.h"
#import "RecordDao.h"
#import "FirstModel.h"
#import "FirstDao.h"
#import "DQShowFirstViewController.h"

#import "HealthModel.h"
#import "HealthDao.h"
#import "DQHWView.h"

#import "MyCaseModel.h"
#import "MyCaseDao.h"


@interface RecordViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UIScrollView *scroll;
@property (strong, nonatomic)UIScrollView *topScroll;

@property(nonatomic,strong)NSArray * topListArray;/**<顶部列表*/
@property(nonatomic,strong)NSArray * topViewArray;/**<顶部控件*/
@property(nonatomic,assign)NSInteger selectedTopView;


@property (strong, nonatomic)UICollectionView * view1;/**<图片*/

@property (strong, nonatomic)UITableView * view2;/**<第一次*/

@property (strong, nonatomic)UIScrollView * view3;/**<身高体重*/
@property(strong,nonatomic)DQHWView * hw;

@property (strong, nonatomic)UITableView * view4;/**<病例*/

@end

static CGFloat const topScrollHeight = 30;

static NSString * const identify1 = @"recordview1cell";
static NSString * const identify2 = @"recordview2cell";
static NSString * const identify3 = @"recordview3cell";
static NSString * const identify4 = @"recordview4cell";

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"内存警告");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addScrollObsever];
    NSLog(@"出来了，哈哈");
    [self.view1 reloadData];
    [self.view2 reloadData];
    self.hw.frame = CGRectMake(0, 0, SCREEN_WIDTH, (50+50*[Singleton shareInstance].healthModelArray.count));
    [self.hw setNeedsDisplay];
    [self.view4 reloadData];
}

-(void)dealloc{
    [self removeScrollObserver];
}

#pragma mark -
#pragma mark 懒加载
-(void)setSelectedTopView:(NSInteger)selectedTopView{
    static BOOL isFirst = YES;
    if (isFirst) {
        UILabel * front = self.topViewArray[0];
        front.textColor = [UIColor redColor];
        front.font = [UIFont systemFontOfSize:17];
        isFirst = NO;
    }else if(_selectedTopView != selectedTopView){
        UILabel * front = self.topViewArray[selectedTopView];
        [UIView animateWithDuration:1 animations:^{
            front.textColor = [UIColor redColor];
            front.font = [UIFont systemFontOfSize:17];
        }];
        UILabel * current = self.topViewArray[_selectedTopView];
        [UIView animateWithDuration:1 animations:^{
            current.textColor = [UIColor blackColor];
            current.font = [UIFont systemFontOfSize:14];
        }];
    }
    _selectedTopView = selectedTopView;
}

#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    self.topListArray = @[@"图片",@"第一次",@"身高体重",@"病例"];
    
    [Singleton shareInstance].recordModelArray = [RecordDao findByName:[[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY]];
    [Singleton shareInstance].firstModelArray = [FirstDao findByName:[[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY]];
    [Singleton shareInstance].healthModelArray = [HealthDao findByName:[[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY]];
    [Singleton shareInstance].caseModelArray = [MyCaseDao findByName:[[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY]];
}

#pragma mark -
#pragma mark 初始化UI
-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = [[NSUserDefaults standardUserDefaults]objectForKey:NOW_BABY];
    [self configTopScroll];
    [self configScroll];
    [self configView1];
    [self configView2];
    [self configView3];
    [self configView4];
}

/**初始化顶部scroll*/
-(void)configTopScroll{
    static CGFloat width = 70;
    NSMutableArray * array = [NSMutableArray new];
    self.topScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, topScrollHeight)];
    for (int i = 0 ; i < self.topListArray.count ; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(width*i, 0, width, topScrollHeight)];
        label.text = self.topListArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self.topScroll addSubview:label];
        [array addObject:label];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recordTopScrollViewClick:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
    }
    self.topViewArray = array;
    self.selectedTopView = 0;
    self.topScroll.contentSize = CGSizeMake(width*self.topListArray.count, topScrollHeight);
    self.topScroll.contentOffset = CGPointZero;
    self.topScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topScroll];
}
-(void)recordTopScrollViewClick:(UITapGestureRecognizer*)tap{
    UILabel * label = (UILabel*)tap.view;
    NSInteger index = [self.topListArray indexOfObject:label.text];
    self.selectedTopView = index;
    self.scroll.contentOffset = CGPointMake(SCREEN_WIDTH*index, 0);
}

#pragma mark scrollView
/**初始化scroll*/
-(void)configScroll{
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+topScrollHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64-topScrollHeight-40)];
    self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH*self.topListArray.count, SCREEN_HEIGHT-64-topScrollHeight-40);
    self.scroll.contentOffset = CGPointZero;
    self.scroll.pagingEnabled = YES;
    [self.view addSubview:self.scroll];
    [self.view sendSubviewToBack:self.scroll];
}
//添加监听
-(void)addScrollObsever{
    [self.scroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
//移除监听
-(void)removeScrollObserver{
    [self.scroll removeObserver:self forKeyPath:@"contentOffset" context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([object isEqual:self.scroll]) {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            NSNumber * number = [change objectForKey:@"new"];
            CGPoint point = [number CGPointValue];
            self.selectedTopView = point.x/SCREEN_WIDTH;
        }
    }
}

#pragma mark -
#pragma mark 初始化第一个视图－图片
/**初始化第一个视图*/
-(void)configView1{
    WaterflowLayout * layout = [[WaterflowLayout alloc] init];
    self.view1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:layout];
    self.view1.delegate = self;
    self.view1.dataSource = self;
    [self.view1 registerNib:[UINib nibWithNibName:@"RecordCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify1];
    self.view1.backgroundColor = BACK_COLOR;
    [self.scroll addSubview:self.view1];
}

#pragma mark collection delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [Singleton shareInstance].recordModelArray.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RecordCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify1 forIndexPath:indexPath];
    [cell setData:[Singleton shareInstance].recordModelArray[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark -
#pragma mark 初始化第二个视图－第一次
-(void)configView2{
    self.view2 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*1, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.view2.delegate = self;
    self.view2.dataSource = self;
    self.view2.tableFooterView = [[UIView alloc] init];
    [self.view2 registerNib:[UINib nibWithNibName:@"DQFirstTableViewCell" bundle:nil] forCellReuseIdentifier:identify2];
    self.view2.backgroundColor = BACK_COLOR;
    [self.scroll addSubview:self.view2];
}

#pragma mark -
#pragma mark 初始化第三个视图－身高体重
-(void)configView3{
    self.view3 = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-topScrollHeight-40)];
    self.view3.contentOffset = CGPointZero;
    self.view3.contentSize = CGSizeMake(SCREEN_WIDTH, ((50+50*[Singleton shareInstance].healthModelArray.count) > SCREEN_HEIGHT-64-topScrollHeight)?(50+50*[Singleton shareInstance].healthModelArray.count):SCREEN_HEIGHT-64-topScrollHeight-40);
    DQHWView * hw = [[DQHWView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (50+50*[Singleton shareInstance].healthModelArray.count))];
    hw.backgroundColor = [UIColor clearColor];
    [self.view3 addSubview:hw];
    self.hw = hw;
    [self.scroll addSubview:self.view3];
    
}

#pragma mark -
#pragma mark 初始化第四个视图－病例
-(void)configView4{
    self.view4 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.view4.delegate = self;
    self.view4.dataSource = self;
    self.view4.tableFooterView = [[UIView alloc] init];
    [self.view4 registerNib:[UINib nibWithNibName:@"DQMyCaseTableViewCell" bundle:nil] forCellReuseIdentifier:identify4];
    self.view4.backgroundColor = BACK_COLOR;
    [self.scroll addSubview:self.view4];
}


#pragma mark -
#pragma mark 表格代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.view2]) {
        return [Singleton shareInstance].firstModelArray.count;
    }else if ([tableView isEqual:self.view4]){
        return [Singleton shareInstance].caseModelArray.count;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.view2]) {
//        NSLog(@"class:%@",tableView.class);
        DQFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify2 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [Singleton shareInstance].firstModelArray[indexPath.row];
        return cell;
    }else if ([tableView isEqual:self.view4]){
        DQMyCaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify4 forIndexPath:indexPath];
        cell.model = [Singleton shareInstance].caseModelArray[indexPath.row];
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.view2]) {
        NSString * string = [[Singleton shareInstance].firstModelArray[indexPath.row] detail];
        CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil];
        return 55+((rect.size.height < 45.0)?rect.size.height:45);
    }else if ([tableView isEqual:self.view4]){
        NSString * string = [[Singleton shareInstance].caseModelArray[indexPath.row] detail];
        CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil];
        return 20 + 10 + rect.size.height;
    }
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.view2]) {
        DQShowFirstViewController * showVC = [[DQShowFirstViewController alloc] init];
        showVC.index = indexPath.row;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:showVC animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }
}


@end
