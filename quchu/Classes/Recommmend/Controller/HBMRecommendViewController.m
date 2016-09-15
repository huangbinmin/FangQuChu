//
//  HBMRecommendViewController.m
//  quchu
//
//  Created by 黄斌民 on 16/8/31.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import "HBMRecommendViewController.h"
#import "HBMMySceneListViewController.h"
#import "HBMAllSceneListViewController.h"

#import "HBMAPIManager.h"

@interface HBMRecommendViewController ()

@property (nonatomic, strong) UIButton *mySceneButton;
@property (nonatomic, strong) UIButton *allSceneButton;

@property (nonatomic, strong) UIView *mySceneView;
@property (nonatomic, strong) UIView *allSceneView;

//@property (nonatomic, strong) NSArray *citys;

@end

@implementation HBMRecommendViewController

#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    [self requestForCityListData];
    
    self.navigationItem.title = @"趣处";
    
    [self.view addSubview:self.mySceneButton];
    [self.view addSubview:self.allSceneButton];
    [self layoutPageSubviews];
    
    [self addSceneView:self.mySceneView];
}

- (void)layoutPageSubviews
{
    [self.mySceneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.size.equalTo(self.allSceneButton);
        make.left.top.equalTo(self.view);
        make.right.equalTo(self.allSceneButton.mas_left);
    }];
    
    [self.allSceneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.equalTo(self.mySceneButton);
        make.left.equalTo(self.mySceneButton.mas_right);
        make.right.equalTo(self.view);
    }];
}

#pragma mark - request handle

//- (void)requestForCityListData
//{
//    [[HBMAPIManager manager] requestForCityListSuccess:^(id resultObject) {
//        
//        NSString *defaultCid = resultObject[@"default"][@"cid"];
//        [[NSUserDefaults standardUserDefaults] setObject:defaultCid forKey:@"defaultCid"];
//        
//        self.citys = resultObject[@"page"][@"result"];
//        
//    } failure:^(id msg) {
//        
//    }];
//}

#pragma mark - event response

- (void)mySceneButtonDidClick:(UIButton *)button
{
    if (button.isSelected) {
        return;
    }
    
    self.mySceneButton.selected = YES;
    self.allSceneButton.selected = NO;
    [self.allSceneView removeFromSuperview];
    [self addSceneView:self.mySceneView];
    self.mySceneView.transform = CGAffineTransformMakeTranslation(SCREEN_W, 0);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.mySceneView.transform = CGAffineTransformIdentity;
    }];
}

- (void)allSceneButtonDidClick:(UIButton *)button
{
    if (button.isSelected) {
        return;
    }
    
    self.mySceneButton.selected = NO;
    self.allSceneButton.selected = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.mySceneView.transform = CGAffineTransformMakeTranslation(SCREEN_W, 0);
    } completion:^(BOOL finished) {
        [self.mySceneView removeFromSuperview];
        [self addSceneView:self.allSceneView];
    }];
}

#pragma mark - private method

- (void)addSceneView:(UIView *)sceneView
{
    [self.view addSubview:sceneView];
    [sceneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.mySceneButton.mas_bottom);
    }];
}

#pragma mark - setter and getter

- (UIButton *)mySceneButton
{
    if (!_mySceneButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor whiteColor];
        button.tintColor = [UIColor blackColor];
        button.selected = YES;
        [button setTitle:@"常用场景" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(mySceneButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        _mySceneButton = button;
    }
    return _mySceneButton;
}

- (UIButton *)allSceneButton
{
    if (!_allSceneButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor whiteColor];
        button.tintColor = [UIColor blackColor];
        [button setTitle:@"场景工坊" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allSceneButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        _allSceneButton = button;
    }
    return _allSceneButton;
}

- (UIView *)mySceneView
{
    if (!_mySceneView) {
        HBMMySceneListViewController *vc = [[HBMMySceneListViewController alloc] init];
        [self addChildViewController:vc];
        _mySceneView = vc.view;
    }
    return _mySceneView;
}

- (UIView *)allSceneView
{
    if (!_allSceneView) {
        HBMAllSceneListViewController *vc = [[HBMAllSceneListViewController alloc] init];
        [self addChildViewController:vc];
        _allSceneView = vc.view;
    }
    return _allSceneView;
}

//- (NSArray *)citys
//{
//    if (!_citys) {
//        NSArray *array = [NSArray array];
//        _citys = array;
//    }
//    return _citys;
//}

@end
