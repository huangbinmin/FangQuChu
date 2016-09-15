//
//  HBMNetInterface.h
//  quchu
//
//  Created by 黄斌民 on 16/8/31.
//  Copyright © 2016年 Bin. All rights reserved.
//

#ifndef HBMNetInterface_h
#define HBMNetInterface_h

#define HBMNetInterface(url) [NSString stringWithFormat:@"http://www.quchu.co/app-main-service/%@", url]

// 城市列表
#define CITY_LIST_URL      HBMNetInterface(@"place/getCityList")

// 常用场景列表
#define MY_SCENE_LIST_URL  HBMNetInterface(@"scene/getMySceneList")

// 场景工坊列表
#define ALL_SCENE_LIST_URL HBMNetInterface(@"scene/getAllSceneList")



#endif /* HBMNetInterface_h */
