//
//  YHNetworkClient.h
//  YHNetClient_Example
//
//  Created by Yangli on 2019/4/1.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "YHNetConfig.h"


@interface YHNetworkClient : AFHTTPSessionManager

/// 初始化请求
/// @param configuration 网络配置
- (instancetype)initWithConfiguration:(id<YHNetConfig>)configuration;

/// POST
/// @param URLString url字符串
/// @param parameters params
/// @param success 成功回调
/// @param failure 失败回调
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/// GET
/// @param URLString url字符串
/// @param parameters params
/// @param success 成功回调
/// @param failure 失败回调
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/// DELETE
/// @param URLString url字符串
/// @param parameters params
/// @param success 成功回调
/// @param failure 失败回调
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/// PUT
/// @param URLString url字符串
/// @param parameters params
/// @param success 成功回调
/// @param failure 失败回调
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/// 上传文件
/// @param URLString url字符串
/// @param parameters params
/// @param block 上传文件处理block
/// @param uploadProgress 上传进度回调
/// @param success 成功回调
/// @param failure 失败回调
- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                        progress:(void (^)(NSProgress *))uploadProgress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 下载文件

 @param downloadURL 下载路径
 @param filePath 存储文件路径
 @param fileName 文件名称（含后缀）
 @param parameters 参数
 @param uploadProgress 下载进度
 @param destination 成功回调
 @param faliure 失败回调
 @return downLoadTask
 */
- (NSURLSessionDownloadTask *)DOWNLOAD:(NSString *)downloadURL
                              filePath:(NSString *)filePath
                              fileName:(NSString *)fileName
                            parameters:(id)parameters
                              progress:(void (^)(NSProgress *))uploadProgress
                               success:(void (^)(NSURL *targetPath, NSURLResponse * _Nonnull response))destination
                               failure:(void(^)(NSError *error))faliure;
@end

