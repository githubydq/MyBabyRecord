//
//  AddBabyView.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/30.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddBabyView.h"
#import "AddBabyBaseView.h"
#import "BabyModel.h"
#import "BabyDao.h"

@interface AddBabyView ()
@property(nonatomic,strong)UIScrollView * scroll;/**< 滚动视图 */
@property(nonatomic,assign)NSInteger viewNum;/**<视图个数*/
@property(nonatomic,strong)BabyModel * model;/**<宝贝*/
@end

@implementation AddBabyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self createScroll];
        [self addBaseView];
    }
    return self;
}

-(BabyModel *)model{
    if (!_model) {
        _model = [[BabyModel alloc] init];
    }
    return _model;
}

/** init data */
-(void)initData{
//    self.viewNum = 3;
}

/** create scrollview */
-(void)createScroll{
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH*self.viewNum, SCREEN_HEIGHT);
    self.scroll.bounces = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.scrollEnabled = NO;
    self.scroll.backgroundColor = [UIColor grayColor];
    [self addSubview:self.scroll];
}

/** 添加基本视图 */
-(void)addBaseView{
    NSArray * array = @[@"姓名",@"性别",@"生日",];
    self.viewNum = array.count;
    for (int i = 0 ; i < self.viewNum ; i++) {
        AddBabyBaseView * view = [[AddBabyBaseView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.isLastView = (i==self.viewNum-1) ? YES:NO;
        view.title = array[i];
        [view addInput:i];
        
        __block AddBabyView * blockSelf = self;
        view.myBtnBlock = ^(CGPoint point,NSString * string){
            NSInteger index = point.x/SCREEN_WIDTH;
            if (index == 0) {
                self.model.name = string;
            }else if (index == 1){
                self.model.sex = string;
            }else if (index == 2){
                self.model.birthday = string;
            }
            if (index < self.viewNum-1) {
                [blockSelf.scroll setContentOffset:CGPointMake(point.x + SCREEN_WIDTH, point.y) animated:YES];
            }else{
//                NSLog(@"%@,%@,%@",self.model.name,self.model.sex,self.model.birthday);
                [BabyDao save:self.model];
                [[NSUserDefaults standardUserDefaults] setObject:self.model.name forKey:NOW_BABY];
                self.model = nil;
                blockSelf.block();
                [UIView animateWithDuration:2 animations:^{
                    [blockSelf.scroll removeFromSuperview];
                    [blockSelf removeFromSuperview];
                }completion:^(BOOL finished) {
                }];
            }
        };
        [self.scroll addSubview:view];
    }
}

@end
