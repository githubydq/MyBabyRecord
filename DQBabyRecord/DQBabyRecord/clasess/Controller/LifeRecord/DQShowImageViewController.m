//
//  DQShowImageViewController.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQShowImageViewController.h"
#import "RecordModel.h"

@interface DQShowImageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property(nonatomic,strong)UILabel * detailLabel;


@property(nonatomic,strong)NSMutableArray * imageArray;


@property(nonatomic,strong)UIImageView * firstImage;
@property(nonatomic,strong)UIImageView * secondImage;
@property(nonatomic,strong)UIImageView * thirdImage;
@end

@implementation DQShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self configScroll];
    [self configDetail];
    [self configShowImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.detailLabel removeFromSuperview];
}

#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    NSArray * modelArray = [Singleton shareInstance].recordModelArray;
//    NSLog(@"----------*%ld",modelArray.count);
    self.imageArray = [[NSMutableArray alloc]init];
    for (RecordModel * model in modelArray) {
        NSString * imagePath = [NSString stringWithFormat:@"%@/%@",IMG_PATH,model.image];
        [self.imageArray addObject:imagePath];
    }
}

#pragma mark -
#pragma mark 初始化详情
-(void)configDetail{
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100)];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    [self.detailLabel setTextColor:[UIColor blackColor]];
    self.detailLabel.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self.detailLabel];
    [self setDetailText:self.index];
}

-(void)setDetailText:(NSInteger)index{
    RecordModel * model = [Singleton shareInstance].recordModelArray[index];
    self.detailLabel.text = model.detail;
}

#pragma mark -
#pragma mark 初始化scroll
-(void)configScroll{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.pagingEnabled = YES;
    NSInteger number = self.imageArray.count;
    self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH*(number > 3 ? 3 : number), SCREEN_HEIGHT);
    if (self.imageArray.count >= 1) {
        self.firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.scroll addSubview:self.firstImage];
        self.firstImage.contentMode = UIViewContentModeScaleAspectFit;
        self.firstImage.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageTapClick)];
        [self.firstImage addGestureRecognizer:tap];
    }
    if (self.imageArray.count >= 2) {
        self.secondImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.scroll addSubview:self.secondImage];
        self.secondImage.contentMode = UIViewContentModeScaleAspectFit;
        self.secondImage.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageTapClick)];
        [self.secondImage addGestureRecognizer:tap];
    }
    if (self.imageArray.count >= 3) {
        self.thirdImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.scroll addSubview:self.thirdImage];
        self.thirdImage.contentMode = UIViewContentModeScaleAspectFit;
        self.thirdImage.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageTapClick)];
        [self.thirdImage addGestureRecognizer:tap];
    }
    self.scroll.contentOffset = CGPointMake((number >= 3 ? SCREEN_WIDTH : 0), 0);
}

-(void)showImageTapClick{
    NSLog(@"tap");
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:NO];
    self.scroll.backgroundColor = self.navigationController.navigationBarHidden ? [UIColor blackColor]:[UIColor whiteColor];
    [self.detailLabel setHidden:self.navigationController.navigationBarHidden];
}

#pragma mark -
#pragma mark 设置图片
-(void)configShowImage{
    if (self.imageArray.count == 1) {
        self.firstImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[0]];
    }else if (self.imageArray.count == 2){
        self.firstImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[0]];
        self.secondImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[1]];
    }else{
        if (self.index == 0) {
            self.secondImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[1]];
            self.firstImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[0]];
            self.scroll.contentOffset = CGPointMake(0, 0);
        }else if (self.index == self.imageArray.count-1){
            self.secondImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[self.index-1]];
            self.thirdImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[self.index]];
            self.scroll.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
        }else{
            self.secondImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[self.index]];
            self.firstImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[self.index-1]];
            self.thirdImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[self.index+1]];
            self.scroll.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        }
    }
    self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",self.index+1,self.imageArray.count];
}

-(void)setShowImage:(NSInteger)index{
    if (self.index != 0 && self.index != self.imageArray.count-1) {
        self.secondImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[self.index]];
        self.firstImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[self.index-1]];
        self.thirdImage.image = [[UIImage alloc] initWithContentsOfFile:self.imageArray[self.index+1]];
        self.scroll.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }
    self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",self.index+1,self.imageArray.count];
    [self setDetailText:self.index];
}


#pragma mark -
#pragma mark scroll代理

//滚动视图结束滑动时，只执行一次
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"end");
    NSInteger index = (NSInteger)scrollView.contentOffset.x/(NSInteger)SCREEN_WIDTH;
    if (index == 0) {
        if (self.index > 0) {
            self.index -= 1;
        }
    }else if (index == 2){
        if (self.index < self.imageArray.count-1) {
            self.index += 1;
        }
    }else if (index == 1){
        if (self.index < index && self.index == 0) {
            self.index += 1;
        }else if (self.index > index && self.index == self.imageArray.count-1){
            self.index -= 1;
        }
    }
    [self setShowImage:self.index];
}
@end
