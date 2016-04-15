//
//  DQShowImageViewController.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQShowImageViewController.h"
#import "RecordModel.h"

@interface DQShowImageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;


@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)NSMutableArray * heightArray;
@end

@implementation DQShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    NSArray * modelArray = [Singleton shareInstance].recordModelArray;
    self.imageArray = [[NSMutableArray alloc]init];
    self.heightArray = [[NSMutableArray alloc]init];
    for (RecordModel * model in modelArray) {
        UIImage * image = [ImageHelper getImageWithName:model.image];
        CGFloat height = SCREEN_WIDTH/[ImageHelper getScaleWithName:model.image];
        NSLog(@"11%@",image);
        [self.imageArray addObject:image];
        [self.heightArray addObject:@(height)];
    }
}


@end
