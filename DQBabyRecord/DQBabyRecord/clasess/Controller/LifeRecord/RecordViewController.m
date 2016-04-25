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
#import "DQFirstCollectionViewCell.h"
#import "DQHWCollectionViewCell.h"
#import "DQCaseCollectionViewCell.h"

#import "RecordModel.h"
#import "RecordDao.h"
#import "DQShowImageViewController.h"

#import "FirstModel.h"
#import "FirstDao.h"
#import "DQShowFirstViewController.h"

#import "HealthModel.h"
#import "HealthDao.h"

#import "MyCaseModel.h"
#import "MyCaseDao.h"
#import "AddCaseViewController.h"


@interface RecordViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSArray * topListArray;

@property(nonatomic,strong)UILabel * headLabel;/**<头label*/
@property(nonatomic,strong)UIImageView * headImage;/**<头image*/

@property (weak, nonatomic) IBOutlet UICollectionView *myColletion;
@property(nonatomic,strong)WaterflowLayout * water;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,assign)NSInteger deleteIndex;
@end


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
    [self loadData];
    [self.myColletion reloadData];
}

#pragma mark -
#pragma mark 懒加载
-(NSInteger)selectedIndex{
    if (!_selectedIndex) {
        _selectedIndex =0;
    }
    return _selectedIndex;
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
    self.water = [[WaterflowLayout alloc] init];
    self.water.index = self.selectedIndex;
    [self.myColletion setCollectionViewLayout:self.water animated:NO];
    self.myColletion.backgroundColor = BACK_COLOR;
    self.myColletion.delegate = self;
    self.myColletion.dataSource = self;
    [self.myColletion registerNib:[UINib nibWithNibName:@"RecordCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify1];
    [self.myColletion registerNib:[UINib nibWithNibName:@"DQFirstCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify2];
    [self.myColletion registerNib:[UINib nibWithNibName:@"DQHWCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify3];
    [self.myColletion registerNib:[UINib nibWithNibName:@"DQCaseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identify4];
    
    [self addHeadView:self.topListArray[0]];
    [self setColletionView];
}

/**设置colletionView*/
-(void)setColletionView{
    self.water.index = self.selectedIndex;
    [self.myColletion reloadData];
}

/**添加头视图*/
-(void)addHeadView:(NSString*)title{
    CGFloat width = [title getNavTitleWidth:18];
    CGFloat imgWidth = 20;
    
    UIButton * head = [UIButton buttonWithType:UIButtonTypeCustom];
    head.bounds = CGRectMake(0, 0, width+imgWidth, 34);
    [head addTarget:self action:@selector(recordHeadClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 34)];
    self.headLabel.text = title;
    [head addSubview:self.headLabel];
    
    self.headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down40x40"]];
    self.headImage.frame = CGRectMake(width+10, 10, imgWidth-5*2, 14);
    [head addSubview:self.headImage];
    
    self.navigationItem.titleView=head;
}


#pragma mark -
#pragma mark 头视图点击
-(void)recordHeadClick{
    [self.headImage setImage:[UIImage imageNamed:@"up40x40"]];
    [self recordAddChoiceIten];
}

-(void)recordAddChoiceIten{
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recordHeadTapClick:)];
    [v addGestureRecognizer:tap];
    //添加选择
    UIScrollView * sv = [[UIScrollView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2.0, 64, 100, 160)];
    sv.contentOffset = CGPointZero;
    sv.contentSize = CGSizeMake(100, 40*self.topListArray.count);
    sv.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
    for (int i = 0 ; i < self.topListArray.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 40*i, 100, 40);
        [btn setTitle:self.topListArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(recordItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [sv addSubview:btn];
    }
    [v addSubview:sv];
    
    [[UIApplication sharedApplication].keyWindow addSubview:v];
}
/**新加视图点击*/
-(void)recordHeadTapClick:(UITapGestureRecognizer *)tap{
    UIView * v = tap.view;
    [v removeFromSuperview];
    [self.headImage setImage:[UIImage imageNamed:@"down40x40"]];
}
/**选项点击*/
-(void)recordItemClick:(UIButton*)btn{
    self.selectedIndex = [self.topListArray indexOfObject:btn.titleLabel.text];
    
    UIView * v = [UIApplication sharedApplication].keyWindow.subviews.lastObject;
    [v removeFromSuperview];
    
    [self addHeadView:btn.titleLabel.text];
    
    [self setColletionView];
}

#pragma mark -
#pragma mark collection delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.selectedIndex == 0) {
        return [Singleton shareInstance].recordModelArray.count;
    }else if(self.selectedIndex == 1){
        return [Singleton shareInstance].firstModelArray.count;
    }else if (self.selectedIndex == 2){
        return [Singleton shareInstance].healthModelArray.count;
    }else if (self.selectedIndex == 3){
        return [Singleton shareInstance].caseModelArray.count;
    }
    return 0;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedIndex == 0) {
        RecordCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify1 forIndexPath:indexPath];
        cell.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
        cell.model = [Singleton shareInstance].recordModelArray[indexPath.row];
        [self addLongPressAtCell:cell];
        return cell;
    }else if(self.selectedIndex == 1){
        DQFirstCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify2 forIndexPath:indexPath];
        cell.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
        cell.model = [Singleton shareInstance].firstModelArray[indexPath.row];
        [self addLongPressAtCell:cell];
        return cell;
    }else if (self.selectedIndex == 2){
        DQHWCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify3 forIndexPath:indexPath];
        cell.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
        cell.model = [Singleton shareInstance].healthModelArray[indexPath.row];
        [self addLongPressAtCell:cell];
        return cell;
    }else if (self.selectedIndex == 3){
        DQCaseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify4 forIndexPath:indexPath];
        cell.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
        cell.model = [Singleton shareInstance].caseModelArray[indexPath.row];
        [self addLongPressAtCell:cell];
        return cell;
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    if (self.selectedIndex == 0) {
        DQShowImageViewController * showimage = [[DQShowImageViewController alloc] init];
        showimage.index = indexPath.row;
        NSLog(@"------%ld",showimage.index);
        [self.navigationController pushViewController:showimage animated:NO];
    }else if(self.selectedIndex == 1){
        DQShowFirstViewController * showfirst = [[DQShowFirstViewController alloc] init];
        showfirst.index = indexPath.row;
        [self.navigationController pushViewController:showfirst animated:NO];
    }else if (self.selectedIndex == 2){
        
    }else if (self.selectedIndex == 3){
        MyCaseModel * model = [Singleton shareInstance].caseModelArray[indexPath.row];
        AddCaseViewController * addCase = [[AddCaseViewController alloc] init];
        addCase.isEditing = YES;
        [addCase setValue:model forKey:@"model"];
        [self.navigationController pushViewController:addCase animated:NO];
    }
    self.hidesBottomBarWhenPushed = NO;
    
}

#pragma mark -
#pragma mark add UILongPressGestureRecognizer
-(void)addLongPressAtCell:(UICollectionViewCell*)cell{
    UILongPressGestureRecognizer * longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(recordLongPress:)];
    longpress.minimumPressDuration = 1.0;
    cell.userInteractionEnabled = YES;
    [cell addGestureRecognizer:longpress];
}

-(void)recordLongPress:(UILongPressGestureRecognizer*)longpress{
    if (longpress.state == UIGestureRecognizerStateBegan) {
        if (self.selectedIndex == 0) {
            RecordCollectionViewCell * cell = (RecordCollectionViewCell*)longpress.view;
            self.deleteIndex = [self.myColletion indexPathForCell:cell].row;
        }else if(self.selectedIndex == 1){
            DQFirstCollectionViewCell * cell = (DQFirstCollectionViewCell*)longpress.view;
            self.deleteIndex = [self.myColletion indexPathForCell:cell].row;
        }else if (self.selectedIndex == 2){
            DQHWCollectionViewCell * cell = (DQHWCollectionViewCell*)longpress.view;
            self.deleteIndex = [self.myColletion indexPathForCell:cell].row;
        }else if (self.selectedIndex == 3){
            DQCaseCollectionViewCell * cell = (DQCaseCollectionViewCell*)longpress.view;
            self.deleteIndex = [self.myColletion indexPathForCell:cell].row;
        }
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除该记录！！！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self deleteRecord];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)deleteRecord{
    if (self.selectedIndex == 0) {
        RecordModel * model = [Singleton shareInstance].recordModelArray[self.deleteIndex];
        [RecordDao deleteAtDate:model.date];
        [[Singleton shareInstance].recordModelArray removeObjectAtIndex:self.deleteIndex];
    }else if(self.selectedIndex == 1){
        FirstModel * model = [Singleton shareInstance].firstModelArray[self.deleteIndex];
        [FirstDao deleteAtDate:model.date];
        [[Singleton shareInstance].firstModelArray removeObjectAtIndex:self.deleteIndex];
    }else if (self.selectedIndex == 2){
        HealthModel * model = [Singleton shareInstance].healthModelArray[self.deleteIndex];
        [HealthDao deleteAtDate:model.date];
        [[Singleton shareInstance].healthModelArray removeObjectAtIndex:self.deleteIndex];
    }else if (self.selectedIndex == 3){
        MyCaseModel * model = [Singleton shareInstance].caseModelArray[self.deleteIndex];
        [MyCaseDao deleteAtDate:model.date];
        [[Singleton shareInstance].caseModelArray removeObjectAtIndex:self.deleteIndex];
    }
    [self.myColletion deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.deleteIndex inSection:0]]];
    [self.myColletion reloadData];
}
@end
