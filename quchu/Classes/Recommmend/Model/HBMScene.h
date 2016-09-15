//
//  HBMScene.h
//  quchu
//
//  Created by 黄斌民 on 16/9/14.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBMScene : NSObject

//"en": "Deep Sleep",
//"height": "690",
//"intro": "我还是个宝宝，不知道什么叫乖乖听话",
//"rgb": "937e6a",
//"sceneContent": "不是熊孩子难带，而是你带他去错了地方，get到新技能了吗？",
//"sceneCover": "http://7xo7f0.com1.z0.glb.clouddn.com/scene/code_003.png_15",
//"sceneId": 3,
//"sceneName": "制服熊孩子",
//"sceneTitle": ["美食", "住宿", "娱乐"],
//"width": "602"

@property (nonatomic, copy) NSString *en;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *rgb;
@property (nonatomic, copy) NSString *sceneContent;
@property (nonatomic, copy) NSString *sceneCover;
@property (nonatomic, copy) NSString *sceneId;
@property (nonatomic, copy) NSString *sceneName;
@property (nonatomic, strong) NSArray *sceneTitle;
@property (nonatomic, copy) NSString *width;

@end
