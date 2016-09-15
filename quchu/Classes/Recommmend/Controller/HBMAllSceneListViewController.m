//
//  HBMAllSceneListViewController.m
//  quchu
//
//  Created by 黄斌民 on 16/9/15.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import "HBMAllSceneListViewController.h"

#import "HBMAllSceneCell.h"
#import "HBMCollectionHeaderView.h"

#import "HBMScene.h"

#import "YYModel.h"

#import "HBMAllSceneViewLayout.h"
#import "HBMAPIManager.h"

@interface HBMAllSceneListViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *allScenes;
@property (nonatomic, assign) CGFloat lastContentOffsetY;
@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, assign) BOOL isFirstTime;

@end

static NSString * const kReuseIdentifier = @"cell";
static NSString * const kHeaderReuseIdentifier = @"headerView";

@implementation HBMAllSceneListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lastContentOffsetY = 0;
    _isAnimation = YES;
    _isFirstTime = YES;
    
    [self.view addSubview:self.collectionView];
    [self layoutPageSubview];
    
    [self requestAllSceneListData];
}

- (void)layoutPageSubview
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - request handle

- (void)requestAllSceneListData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cityId"] = @1;
    params[@"pageNo"] = @1;
    
    [[HBMAPIManager manager] requestForAllSceneListWithParams:params success:^(id resultObject) {
        
        self.allScenes = [NSArray yy_modelArrayWithClass:[HBMScene class] json:resultObject[@"result"]];
        [self.collectionView reloadData];
        
    } failure:^(id msg) {
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allScenes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HBMAllSceneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    cell.allScene = self.allScenes[indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HBMCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseIdentifier forIndexPath:indexPath];
        reusableView = headerView;
    }
    return reusableView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isAnimation) {
        return;
    }
    
    cell.transform = CGAffineTransformMakeTranslation(0, 50);
    [UIView animateWithDuration:(0.5+0.1*(indexPath.item%2)) animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    // 这方法会调用2次，用isFirstTime记录，保证动画只发生一次
    if (!_isAnimation || !_isFirstTime) {
        return;
    }
    _isFirstTime = NO;
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        view.transform = CGAffineTransformMakeTranslation(0, 50);
        [UIView animateWithDuration:0.5 animations:^{
            view.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _isAnimation = _lastContentOffsetY < scrollView.contentOffset.y;
    _lastContentOffsetY = scrollView.contentOffset.y;
}

#pragma mark - getter and setter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        HBMAllSceneViewLayout *layout = [[HBMAllSceneViewLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor lightGrayColor];
        
        [collectionView registerNib:[UINib nibWithNibName:@"HBMAllSceneCell" bundle:nil] forCellWithReuseIdentifier:kReuseIdentifier];
        [collectionView registerNib:[UINib nibWithNibName:@"HBMCollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseIdentifier];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end
