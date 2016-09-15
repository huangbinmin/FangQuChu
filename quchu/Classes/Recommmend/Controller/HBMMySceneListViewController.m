//
//  HBMMySceneListViewController.m
//  quchu
//
//  Created by 黄斌民 on 16/9/14.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import "HBMMySceneListViewController.h"

#import "HBMSceneCell.h"

#import "HBMScene.h"

#import "HBMAPIManager.h"
#import "HBMMySceneViewLayout.h"

#import "YYModel.h"

@interface HBMMySceneListViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) NSArray *mySceces;
@property (nonatomic, strong) NSString *sceneCount;

@end

static NSString * const kReuseIdentifier = @"cell";

@implementation HBMMySceneListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomLabel];
    [self layoutPageSubview];
    
    [self requestMySceneListData];
}

- (void)layoutPageSubview
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
}

#pragma mark - request handle

- (void)requestMySceneListData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cityId"] = @1;
    params[@"pageNo"] = @1;
    
    [[HBMAPIManager manager] requestForMySceneListWithParams:params success:^(id resultObject) {
        
        self.mySceces = [NSArray yy_modelArrayWithClass:[HBMScene class] json:resultObject[@"result"]];
        [self.collectionView reloadData];
        
        self.sceneCount = resultObject[@"resultCount"];
        
    } failure:^(id msg) {
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mySceces.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HBMSceneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    cell.myScene = self.mySceces[indexPath.item];
    
    return cell;
}

#pragma mark - getter and setter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        HBMMySceneViewLayout *layout = [[HBMMySceneViewLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor lightGrayColor];
        collectionView.decelerationRate = 0.1;
        
        [collectionView registerNib:[UINib nibWithNibName:@"HBMSceneCell" bundle:nil] forCellWithReuseIdentifier:kReuseIdentifier];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor lightGrayColor];
        _bottomLabel = label;
    }
    return _bottomLabel;
}

@end
