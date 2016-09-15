//
//  HBMMySceneViewLayout.m
//  quchu
//
//  Created by 黄斌民 on 16/9/14.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import "HBMMySceneViewLayout.h"

@implementation HBMMySceneViewLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    CGFloat itemWidth = SCREEN_W - 50 * 2;
    CGFloat itemHeight = itemWidth * 1.3;
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.minimumLineSpacing = 20;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(50, 50, 50, 50);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // cell的中心点x 和 collectionView最中心点的x值 的间距
        CGFloat delta = ABS(attrs.center.x - centerX);
        
        // 根据间距值 计算 cell的缩放比例
        CGFloat scale = 1 - (delta / self.collectionView.frame.size.width) * 0.1;
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    // 修改原有的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

@end
