//
//  YHNetworkTool.h
//  YHNetClient_Example
//
//  Created by Yangli on 2019/4/1.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import "YHNetworkClient.h"

//NS_ASSUME_NONNULL_BEGIN
/*普通请求回调*/
typedef void(^YHClientRequestBack)(BOOL requestSuccess, NSString *loginToken, id _Nullable response, NSString *_Nullable responseJson, NSDictionary *_Nullable requestDic, NSString *_Nullable errorMessage);
/*下载文件请求回调*/
typedef void(^YHDownloadRequestBack)(BOOL requestSuccess, NSURL *targetPath, NSURLResponse * _Nonnull response, NSError *error);

@interface YHNetworkTool : YHNetworkClient

/// POST
/// @param URLString url
/// @param view hidView
/// @param parameters params
/// @param requestBack requestBack
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                        inView:(UIView *)view
                    parameters:(id)parameters
                   requestBack:(YHClientRequestBack _Nullable )requestBack;

/// GET
/// @param URLString url
/// @param view hidView
/// @param parameters params
/// @param requestBack requestBack
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       inView:(UIView *)view
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack _Nullable )requestBack;

/// DELETE
/// @param URLString url
/// @param view hidView
/// @param parameters params
/// @param requestBack requestBack
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                          inView:(UIView *)view
                      parameters:(id)parameters
                     requestBack:(YHClientRequestBack _Nullable )requestBack;

/// PUT请求
/// @param URLString url
/// @param view hidView
/// @param parameters params
/// @param requestBack requestBack
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                       inView:(UIView *)view
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack _Nullable )requestBack;

/**
 图片上传(数组)

 @param URLString 路径
 @param files 图片数组
 @param view loading所在视图
 @param parameters 参数
 @param uploadProgress 进度
 @param requestBack 回调
 @return requestBack
 */
- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString
                           files:(NSArray *)files
                          inView:(UIView *)view
                      parameters:(id)parameters
                        progress:(void (^)(NSProgress *))uploadProgress
                     requestBack:(YHClientRequestBack)requestBack;
/**
 下载文件

 @param URLString 请求路径
 @param view loading父视图
 @param filePath 下载保存路径
 @param fileName 保存文件名称（含后缀）
 @param parameters 请求参数
 @param downloadProgress 下载进度
 @param requestBack 请求回调
 @return downloadTask
 */
- (NSURLSessionDownloadTask *)DOWNLOAD:(NSString *)URLString
                                inView:(UIView *)view
                              filePath:(NSString *)filePath
                              fileName:(NSString *)fileName
                            parameters:(id)parameters
                              progress:(void (^)(NSProgress *))downloadProgress
                           requestBack:(YHDownloadRequestBack)requestBack;
@end

//NS_ASSUME_NONNULL_END
