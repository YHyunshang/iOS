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
[HUD hideAnimated:YES];\
NSString *jsonStr;\
if (responseObject) {\
jsonStr = [(NSDictionary *)responseObject yy_modelToJSONString];\
YH_Log(@"jsonStr = %@",jsonStr);\
}\
requestBack(YES, responseObject, jsonStr, parameters, nil);\
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {\
[HUD hideAnimated:YES];\
YH_Log(@"\n请求失败************************\n%@",error);\
requestBack(NO, nil, nil, parameters, [error localizedDescription]);\
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
    return YHNETWORK_REQUEST_MACRO(POST, [self hudFromView:view]);
    return [super POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSString *jsonStr = [(NSDictionary *)responseObject yy_modelToJSONString];
            YH_Log(@"jsonStr = %@",jsonStr);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       inView:(UIView *)view
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack)requestBack
{
    return YHNETWORK_REQUEST_MACRO(GET, [self hudFromView:view]);
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                          inView:(UIView *)view
                      parameters:(id)parameters
                     requestBack:(YHClientRequestBack)requestBack
{
    return YHNETWORK_REQUEST_MACRO(DELETE, [self hudFromView:view]);
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                       inView:(UIView *)view
                   parameters:(id)parameters
                  requestBack:(YHClientRequestBack)requestBack
{
    return YHNETWORK_REQUEST_MACRO(PUT, [self hudFromView:view]);
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
                     requestBack(YES, responseObject, nil, parameters, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [hud hideAnimated:YES];
        YH_Log(@"\n请求失败************************\n%@",error);
        requestBack(NO, nil, nil, parameters, [error localizedDescription]);
    }];
}

@end
