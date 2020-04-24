//
//  YHNetworkTool.m
//  YHNetClient_Example
//
//  Created by Yangli on 2019/4/1.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import "YHNetworkTool.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YLJsonLib/YLJastor.h>

#ifdef DEBUG
#define YH_Log(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define YH_Log(format, ...)
#endif

#define YHNETWORK_REQUEST_MACRO(METHOD,HUD) \
[super METHOD:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id responseObject) { \
NSString *jsonStr;\
NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;\
NSString *loginToken = [r allHeaderFields][@"login-token"];\
requestBack(YES, loginToken, responseObject, jsonStr, parameters, nil);\
[HUD hideAnimated:YES];\
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {\
requestBack(NO, nil, nil, nil, parameters, [error localizedDescription]);\
[HUD hideAnimated:YES];\
}]

@implementation YHNetworkTool

- (MBProgressHUD *)hudFromView:(UIView *)view
{
    MBProgressHUD *hud = nil;;
    if (view) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor clearColor];
    }
    return hud;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                        inView:(UIView *)view
                    parameters:(id)parameters
                   requestBack:(YHClientRequestBack)requestBack
{
    MBProgressHUD *hud = [self hudFromView:view];
    return YHNETWORK_REQUEST_MACRO(POST, hud);
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       inView:(UIView *)view
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack)requestBack
{
    MBProgressHUD *hud = [self hudFromView:view];
    return YHNETWORK_REQUEST_MACRO(GET, hud);
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                          inView:(UIView *)view
                      parameters:(id)parameters
                     requestBack:(YHClientRequestBack)requestBack
{
    MBProgressHUD *hud = [self hudFromView:view];
    return YHNETWORK_REQUEST_MACRO(DELETE, hud);
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                       inView:(UIView *)view
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack)requestBack
{
    MBProgressHUD *hud = [self hudFromView:view];
    return YHNETWORK_REQUEST_MACRO(PUT, hud);
}

- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString
                          inView:(UIView *)view
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                        progress:(void (^)(NSProgress *))uploadProgress
                     requestBack:(YHClientRequestBack)requestBack
{
    MBProgressHUD *hud = [self hudFromView:view];
    return [super UPLOAD:URLString
              parameters:parameters
constructingBodyWithBlock:block
                progress:uploadProgress
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     [hud hideAnimated:YES];
                     if (responseObject) {
                         NSString *jsonStr = [(NSDictionary *)responseObject yy_modelToJSONString];
                         YH_Log(@"jsonStr = %@",jsonStr);
                     }
                     requestBack(YES,nil, responseObject, nil, parameters, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [hud hideAnimated:YES];
        requestBack(NO, nil ,nil, nil, parameters, [error localizedDescription]);
    }];
}

- (NSURLSessionDownloadTask *)DOWNLOAD:(NSString *)URLString
                                inView:(UIView *)view
                              filePath:(NSString *)filePath
                              fileName:(NSString *)fileName
                            parameters:(id)parameters
                              progress:(void (^)(NSProgress *))downloadProgress
                           requestBack:(YHDownloadRequestBack)requestBack
{
    MBProgressHUD *hud = [self hudFromView:view];
    
    return [super DOWNLOAD:URLString filePath:filePath fileName:fileName parameters:parameters progress:downloadProgress success:^(NSURL *targetPath, NSURLResponse * _Nonnull response) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
        requestBack(YES, targetPath, response, nil);
    } failure:^(NSError *error) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
        requestBack(NO, nil, nil, error);
    }];
}

+ (NSData *)imageToData:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat size = 50;
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size) {
        maxQuality = maxQuality - 0.1f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length/1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

@end
