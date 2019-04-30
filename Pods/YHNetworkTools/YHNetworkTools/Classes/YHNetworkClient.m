//
//  YHNetworkClient.m
//  YHNetClient_Example
//
//  Created by Yangli on 2019/4/1.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import "YHNetworkClient.h"

#define YHHTTP_REQUEST_MACRO(METHOD) \
[super METHOD:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, id responseObject) { \
if (success){\
success(task, responseObject);\
}\
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {\
if (failure){\
failure(task, error);\
}\
}]

#define YHHTTP_REQUEST_MACRO_2(METHOD) \
[super METHOD:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id responseObject) { \
if (success){\
success(task, responseObject);\
}\
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {\
if (failure){\
failure(task, error);\
}\
}]

@interface YHNetworkClient ()

@property (weak, nonatomic) id<YHNetConfig>configuration;

@end

@implementation YHNetworkClient

- (instancetype)initWithConfiguration:(id<YHNetConfig>)configuration
{
    self = [super initWithBaseURL:nil];
    if (self) {
        self.configuration = configuration;
        //设置请求和响应
        [self requestAndResponseParameterSet];
        //设置超时时间
        self.requestSerializer.timeoutInterval = [configuration requestTimeOut];
    }
    return self;
}

#pragma mark ============================    config header    ============================
- (void)requestAndResponseParameterSet
{
    NSInteger requestEncoding = [self.configuration requestParameterEncoding];
    if (requestEncoding > 0) {
        AFHTTPRequestSerializer *requestSerializer;
        switch (requestEncoding) {
            case 1:
                requestSerializer = [AFJSONRequestSerializer serializer];
                break;
            case 2:
                requestSerializer = [AFPropertyListRequestSerializer serializer];
                break;
                
            default:
                requestSerializer = [AFHTTPRequestSerializer serializer];
                break;
        }
        self.requestSerializer = requestSerializer;
    }
    
    NSInteger responseEncoding = [self.configuration responseParameterEncoding];
    if (responseEncoding > 0) {
        AFHTTPResponseSerializer *responseSerializer;
        switch (responseEncoding) {
            case 1:
                responseSerializer = [AFHTTPResponseSerializer serializer];
                break;
            case 2:
                responseSerializer = [AFXMLParserResponseSerializer serializer];
                break;
            case 3:
                responseSerializer = [AFPropertyListResponseSerializer serializer];
                break;
            case 4:
                responseSerializer = [AFImageResponseSerializer serializer];
                break;
            case 5:
                responseSerializer = [AFCompoundResponseSerializer serializer];
                break;
            default:
                responseSerializer = [AFJSONResponseSerializer serializer];
                break;
        }
        self.responseSerializer = responseSerializer;
    }
    
    self.responseSerializer.acceptableContentTypes = [self.configuration responseAcceptableContentTypes];
}

- (void)requestHearderSet
{
    NSDictionary *dict = [self.configuration customRequestHeader];
    if (dict) {
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self requestHearderSet];
    NSURLSessionDataTask *dataTask = YHHTTP_REQUEST_MACRO(POST);
    return dataTask;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self requestHearderSet];
    NSURLSessionDataTask *dataTask = YHHTTP_REQUEST_MACRO(GET);
    return dataTask;
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self requestHearderSet];
    NSURLSessionDataTask *dataTask = YHHTTP_REQUEST_MACRO_2(DELETE);
    return dataTask;
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self requestHearderSet];
    NSURLSessionDataTask *dataTask = YHHTTP_REQUEST_MACRO_2(PUT);
    return dataTask;
}

- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                        progress:(void (^)(NSProgress *))uploadProgress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self requestHearderSet];
    NSURLSessionDataTask *dataTask = [super POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    return dataTask;
}


@end
