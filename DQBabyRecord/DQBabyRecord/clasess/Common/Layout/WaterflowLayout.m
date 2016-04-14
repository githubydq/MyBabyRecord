//
//  WaterflowLayout.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/3/20.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "WaterflowLayout.h"
#import "RecordModel.h"

#define JPCollectionW self.collectionView.frame.size.width
static const CGFloat JPDefaultRowMargin = 10;
static const CGFloat JPDefaultColumnMargin = 10;
static const UIEdgeInsets JPDefaultInsets = {10, 10, 10, 10};
static const int JPDefaultColumsCount = 2;

@interface WaterflowLayout()
@property (nonatomic, strong) NSMutableArray *columnMaxYs;/**<每列最大y值*/
@property (nonatomic, strong) NSMutableArray *attrsArray/**<cell的属性*/;
@end

@implementation WaterflowLayout

#pragma mark - 懒加载
- (NSMutableArray *)columnMaxYs
{
    if (!_columnMaxYs) {
        _columnMaxYs = [[NSMutableArray alloc] init];
    }
    return _columnMaxYs;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

#pragma mark - 实现内部的方法

- (CGSize)collectionViewContentSize
{
    // 找出最长那一列的最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    for (NSUInteger i = 1; i < self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最大值
        if (destMaxY < columnMaxY) {
            destMaxY = columnMaxY;
        }
    }
    return CGSizeMake(0, destMaxY + JPDefaultInsets.bottom);
}

/**初始化*/
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 重置每一列的最大Y值
    [self.columnMaxYs removeAllObjects];
    for (NSUInteger i = 0; i < JPDefaultColumsCount; i++){
        [self.columnMaxYs addObject:@(JPDefaultInsets.top)];
    }
         
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

    // 水平方向上的总间距
    CGFloat xMargin = JPDefaultInsets.left + JPDefaultInsets.right + (JPDefaultColumsCount - 1) * JPDefaultColumnMargin;
    // cell的宽度
    CGFloat w = (JPCollectionW - xMargin) / JPDefaultColumsCount;
    
//--------------------------------
    // cell的高度
//    RecordModel * model = [Singleton shareInstance].recordModelArray[indexPath.row];
//    CGFloat h = w/[ImageHelper getScaleWithName:model.date];
    CGFloat h = 50 + arc4random_uniform(150);
    
    // 找出最短那一列的 列号 和 最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    NSUInteger destColumn = 0;
    for (NSUInteger i = 1; i<self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
            
        // 找出数组中的最小值
        if (destMaxY > columnMaxY) {
            destMaxY = columnMaxY;
            destColumn = i;
        }
    }
        
    // cell的x值
    CGFloat x = JPDefaultInsets.left + destColumn * (w + JPDefaultColumnMargin);
    // cell的y值
    CGFloat y = destMaxY + JPDefaultRowMargin;
    // cell的frame
    attrs.frame = CGRectMake(x, y, w, h);
        
    // 更新数组中的最大Y值
    self.columnMaxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
        
    return attrs;
}

@end
