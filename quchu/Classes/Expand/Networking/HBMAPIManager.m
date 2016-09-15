//
//  HBMAPIManager.m
//  quchu
//
//  Created by 黄斌民 on 16/9/1.
//  Copyright © 2016年 Bin. All rights reserved.
//

#import "HBMAPIManager.h"
#import "HBMNetInterface.h"

#import "AFNetworking.h"

@interface HBMAPIManager ()

@property (nonatomic, strong) AFHTTPSessionManager *afManager;

@end

@implementation HBMAPIManager

+ (instancetype)manager
{
    return [[self alloc] init];
}

- (void)requestForCityListSuccess:(SuccessHandler)success failure:(FailureHandler)failure
{
    [self get:CITY_LIST_URL parameters:nil success:^(id resultObject) {
        
        success(resultObject);
        
    } failure:^(id msg) {
        
        failure(msg);
    }];
}

- (void)requestForMySceneListWithParams:(NSDictionary *)params success:(SuccessHandler)success failure:(FailureHandler)failure
{
    [self get:MY_SCENE_LIST_URL parameters:params success:^(id resultObject) {
        
        success(resultObject);
        
    } failure:^(id msg) {
        
        failure(msg);
    }];
}

- (void)requestForAllSceneListWithParams:(NSDictionary *)params success:(SuccessHandler)success failure:(FailureHandler)failure
{
    [self get:ALL_SCENE_LIST_URL parameters:params success:^(id resultObject) {
        
        success(resultObject);
        
    } failure:^(id msg) {
        
        failure(msg);
    }];
}

#pragma mark - private method

- (void)get:(NSString *)urlString parameters:(NSDictionary *)params success:(void(^)(id resultObject))success failure:(void(^)(id msg))failure
{
    [self.afManager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject[@"result"])
        {
            id data = responseObject[@"data"];
            success(data);
        }
        else
        {
            id msg = responseObject[@"msg"];
            failure(msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(@"网络开小差，请稍后再试!");
    }];
}

- (void)post:(NSString *)urlString parameters:(NSDictionary *)params success:(void(^)(id resultObject))success failure:(void(^)(id msg))failure
{
    [self.afManager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject[@"result"])
        {
            id data = responseObject[@"data"];
            success(data);
        }
        else
        {
            id msg = responseObject[@"msg"];
            failure(msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(@"网络开小差，请稍后再试!");
    }];
}

#pragma mark - getter and setter

- (AFHTTPSessionManager *)afManager
{
    if (!_afManager) {
//        NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//        NSString *versionString = [NSString stringWithFormat:@"iPhone_V%@", version];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"d45926b925d15eff9bcdc1eb482d63cd7bcd1987" forHTTPHeaderField:@"quchu-token"];
        [manager.requestSerializer setValue:@"Android_V1.5.0" forHTTPHeaderField:@"quchuVersion"];
        _afManager = manager;
    }
    return _afManager;
}

@end
