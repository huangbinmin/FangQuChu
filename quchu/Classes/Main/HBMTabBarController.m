//
//  HBMTabBarController.m
//  quchu
//
//  Created by 黄斌民 on 16/8/31.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import "HBMTabBarController.h"
#import "HBMRecommendViewController.h"
#import "HBMFindViewController.h"
#import "HBMMyViewController.h"

@interface HBMTabBarController ()

@end

@implementation HBMTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildViewControllers];
}

- (void)setupChildViewControllers
{
    HBMRecommendViewController *recommendVC = [[HBMRecommendViewController alloc] init];
    [self setupChildViewController:recommendVC title:@"趣推荐" image:@"ic_qutuijian0" selectedImage:@"ic_qutuijian"];
    
    HBMFindViewController *findVC = [[HBMFindViewController alloc] init];
    [self setupChildViewController:findVC title:@"趣发现" image:@"ic_qufaxian0" selectedImage:@"ic_qufaxian"];
    
    HBMMyViewController *myVC = [[HBMMyViewController alloc] init];
    [self setupChildViewController:myVC title:@"我的" image:@"ic_wode0" selectedImage:@"ic_wode"];
}

- (void)setupChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:nav];
}



@end
