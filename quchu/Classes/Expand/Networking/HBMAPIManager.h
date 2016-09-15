//
//  HBMAPIManager.h
//  quchu
//
//  Created by 黄斌民 on 16/9/1.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessHandler)(id resultObject);
typedef void(^FailureHandler)(id msg);

@interface HBMAPIManager : NSObject

+ (instancetype)manager;

/**
 *  请求城市列表数据
 */
- (void)requestForCityListSuccess:(SuccessHandler)success failure:(FailureHandler)failure;

/**
 *  请求常用场景列表数据
 *
 *  @param params 请求参数：cityId pageNo
 */
- (void)requestForMySceneListWithParams:(NSDictionary *)params success:(SuccessHandler)success failure:(FailureHandler)failure;

/**
 *  请求场景工坊列表数据
 *
 *  @param params 请求参数：cityId pageNo
 */
- (void)requestForAllSceneListWithParams:(NSDictionary *)params success:(SuccessHandler)success failure:(FailureHandler)failure;

@end
