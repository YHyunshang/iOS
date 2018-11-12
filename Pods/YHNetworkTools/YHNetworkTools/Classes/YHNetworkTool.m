//
//  YHNetworkTool.m
//  YHNetworkTool
//
//  Created by Yangli on 2018/10/25.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHNetworkTool.h"

@implementation YHNetworkTool

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters requestBack:(YHClientRequestBack)requestBack
{
    return [super POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        requestBack(YES, responseObject, nil, parameters, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestBack(NO, nil, nil, parameters,[error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters requestBack:(YHClientRequestBack)requestBack
{
    return [super GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        requestBack(YES, responseObject, nil, parameters, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestBack(NO, nil, nil, parameters, [error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters requestBack:(YHClientRequestBack)requestBack
{
    return [super DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        requestBack(YES, responseObject, nil, parameters, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestBack(NO, nil, nil, parameters, [error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters requestBack:(YHClientRequestBack)requestBack
{
    return [super DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        requestBack(YES, responseObject, nil, parameters, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestBack(NO, nil, nil, parameters, [error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block progress:(void (^)(NSProgress *))uploadProgress requestBack:(YHClientRequestBack)requestBack
{
    return [super UPLOAD:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask *task, id responseObject) {
        requestBack(YES, responseObject, nil, parameters, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestBack(NO, nil, nil, parameters, [error.userInfo objectForKey:@"NSLocalizedDescription"]);
    }];
}

@end
