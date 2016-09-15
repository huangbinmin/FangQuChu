//
//  HBMAllSceneViewLayout.m
//  quchu
//
//  Created by 黄斌民 on 16/9/15.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import "HBMAllSceneViewLayout.h"

static const CGFloat margin = 20.0f;

@implementation HBMAllSceneViewLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    CGFloat itemWidth = (SCREEN_W - margin * 3) * 0.5f;
    CGFloat itemHeight = itemWidth * 1.3f;
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.minimumLineSpacing = margin;
    self.minimumInteritemSpacing = margin;
    self.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    self.headerReferenceSize = CGSizeMake(SCREEN_W, 100);
}

@end
