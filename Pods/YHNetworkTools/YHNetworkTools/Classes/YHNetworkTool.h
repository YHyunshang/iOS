//
//  YHNetworkTool.h
//  YHNetClient_Example
//
//  Created by Yangli on 2019/4/1.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import "YHNetworkClient.h"

//NS_ASSUME_NONNULL_BEGIN

typedef void(^YHClientRequestBack)(BOOL requestSuccess, id _Nullable response, NSString *_Nullable responseJson, NSDictionary *_Nullable requestDic, NSString *_Nullable errorMessage);

@interface YHNetworkTool : YHNetworkClient

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                        inView:(UIView *)view
                    parameters:(id)parameters
                   requestBack:(YHClientRequestBack _Nullable )requestBack;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       inView:(UIView *)view
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack _Nullable )requestBack;

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                          inView:(UIView *)view
                      parameters:(id)parameters
                     requestBack:(YHClientRequestBack _Nullable )requestBack;

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                       inView:(UIView *)view
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack _Nullable )requestBack;

- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString
                          inView:(UIView *)view
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                        progress:(void (^)(NSProgress *))uploadProgress
                     requestBack:(YHClientRequestBack _Nullable )requestBack;

@end

//NS_ASSUME_NONNULL_END
