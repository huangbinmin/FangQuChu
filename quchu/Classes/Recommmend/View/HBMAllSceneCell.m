//
//  HBMAllSceneCell.m
//  quchu
//
//  Created by 黄斌民 on 16/9/15.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import "HBMAllSceneCell.h"

#import "HBMScene.h"

#import "UIImageView+WebCache.h"

@interface HBMAllSceneCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *sceneNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *title1Label;
@property (weak, nonatomic) IBOutlet UILabel *title2Label;
@property (weak, nonatomic) IBOutlet UILabel *title3Label;

@property (nonatomic, strong) NSArray *labels;

@end

@implementation HBMAllSceneCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _labels = @[_title1Label, _title2Label, _title3Label];
}

- (void)setAllScene:(HBMScene *)scene
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:scene.sceneCover]];
    _sceneNameLabel.text = scene.sceneName;
    [self setupTitles:scene.sceneTitle];
}

- (void)setupTitles:(NSArray<NSString *> *)titles
{
    [_labels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = @"";
    }];
    
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = _labels[idx];
        label.text = obj;
    }];
}

@end
