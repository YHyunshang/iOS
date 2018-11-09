//
//  YHNetworkTool.h
//  YHNetworkTool
//
//  Created by Yangli on 2018/10/25.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHNetworkClient.h"

typedef void(^YHClientRequestBack)(BOOL requestSuccess, id _Nullable response, NSString* _Nullable responseJson, NSDictionary * _Nullable requestDic);


@interface YHNetworkTool : YHNetworkClient

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                   requestBack:(YHClientRequestBack _Nullable )requestBack;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack _Nullable )requestBack;

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                     requestBack:(YHClientRequestBack _Nullable )requestBack;

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack _Nullable )requestBack;

- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                        progress:(void (^)(NSProgress *))uploadProgress
                     requestBack:(YHClientRequestBack _Nullable )requestBack;

@end

