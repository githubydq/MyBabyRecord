//
//  DQShowFirstImageViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/13.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQShowFirstImageViewController.h"
#import "FirstModel.h"
@interface DQShowFirstImageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property(nonatomic,strong)FirstModel * model;
@property(nonatomic,strong)NSMutableArray * imageArray;
@end

@implementation DQShowFirstImageViewController

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addKVO];
}
-(void)dealloc{
    [self removeKVO];
}

#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    self.model = [Singleton shareInstance].firstModelArray[self.index];
    self.imageArray = [NSMutableArray new];
    for (int i = 0 ; i < self.model.image.length/14; i++) {
        NSString * image = [self.model.image substringWithRange:NSMakeRange(14*i, 14)];
        UIImage * img = [ImageHelper getImageWithName:image];
        [self.imageArray addObject:img];
    }
}

#pragma mark -
#pragma mark 初始化UI
-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = [NSString stringWithFormat:@"%d/%ld",(self.imageArray.count > 0)?1:0,self.imageArray.count];
    
    self.scroll.contentOffset = CGPointZero;
    self.scroll.backgroundColor = [UIColor blackColor];
    self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH*self.imageArray.count, SCREEN_HEIGHT-64);
    self.scroll.pagingEnabled = YES;
    
    for (int i = 0 ; i < self.imageArray.count; i++) {
        UIImage * image = self.imageArray[i];
        UIImageView * imageView = [[UIImageView alloc] init];
        CGFloat heigt = image.size.height/image.size.width*SCREEN_WIDTH;
        imageView.frame = CGRectMake(SCREEN_WIDTH*i, (SCREEN_HEIGHT-64-heigt)/2.0, SCREEN_WIDTH, heigt);
        imageView.image = image;
        [self.scroll addSubview:imageView];
    }
}

#pragma mark -
#pragma mark KVO
-(void)addKVO{
    [self.scroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)removeKVO{
    [self.scroll removeObserver:self forKeyPath:@"contentOffset"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([object isEqual:self.scroll]) {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            NSNumber * number = change[@"new"];
            NSInteger index = [number CGSizeValue].width/SCREEN_WIDTH;
            self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",index+1,self.imageArray.count];
        }
    }
}

@end
