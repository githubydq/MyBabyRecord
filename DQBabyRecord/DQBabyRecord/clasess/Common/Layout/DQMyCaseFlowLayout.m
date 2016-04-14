//
//  DQMyCaseFlowLayout.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/4/14.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQMyCaseFlowLayout.h"
#import "MyCaseModel.h"

@interface DQMyCaseFlowLayout ()
@property (nonatomic, strong) NSMutableArray *attrsArray/**<cell的属性*/;
@end

@implementation DQMyCaseFlowLayout
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}


//-(CGSize)collectionViewContentSize{
//    return CGSizeMake(0, 100);
//}

-(void)prepareLayout{
    [super prepareLayout];
    
    // 计算所有cell的布局属性
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**返回cell的属性*/
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat x = 10;
    CGFloat y = 10 + (100+10)*indexPath.row;
    CGFloat width = SCREEN_WIDTH-20;
    MyCaseModel * model = [Singleton shareInstance].caseModelArray[indexPath.row];
    NSString * str = model.detail;
    CGFloat height = [str getNavTitleHeight:14]+28+10;
    
    // cell的frame
    attrs.frame = CGRectMake(x, y, width, height);
    
    return attrs;
}
@end
