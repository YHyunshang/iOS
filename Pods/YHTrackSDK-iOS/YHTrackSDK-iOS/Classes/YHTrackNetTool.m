//
//  YHTrackNetTool.m
//  YHTrackSDK
//
//  Created by Yangli on 2018/9/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHTrackNetTool.h"
#import <UIKit/UIKit.h>
#import "YHTrackDeviceInfo.h"
#import "YHTrackManager.h"
#import "YHTrackLocation.h"


@implementation YHTrackNetTool

+ (void)uploadTrackInfoWithParams:(NSDictionary *)params
{
    if (CurYHTrackMangager.isEnable == NO) {
        return ;
    }
    
    NSString *url = @"http://api.ys.yonghui.cn/t_page.gif";
    if (CurYHTrackMangager.isDebug) {
        url = @"http://api.test.ys.yonghui.cn/t_page.gif";
    }
    NSDictionary *paramters = [YHTrackNetTool jointTrackDataFromParams:params];
    
    // 1.创建一个网络路径
    
    NSURL *requestUrl = [YHTrackNetTool connectWithAuthorizeUrl:url andParams:paramters];
    // 2.创建一个网络请求
    NSURLRequest *request =[NSURLRequest requestWithURL:requestUrl];
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4.根据会话对象，创建一个Task任务：
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            if (CurYHTrackMangager.isDebug) {
                YHTrackLog(@"上传埋点信息成功");
            }
            return ;
        }
        YHTrackLog(@"埋点信息出错 = %@",error);
    }];
    
    [sessionDataTask resume];
}

/**
 字典拼接

 @param params <#params description#>
 @return <#return value description#>
 */
+ (NSDictionary *)jointTrackDataFromParams:(NSDictionary *)params
{
    //当前时间戳
    NSString *createTime = [NSString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970]*1000)];
    NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithDictionary:@{@"appType":@"iOS",@"brand":CurDeviceInfo.brand,@"model":CurDeviceInfo.model,@"systemVersion":CurDeviceInfo.phoneVersion,@"rom":@"iOS",@"cpu":@"iOS",@"pid":YHTrackSetEmptyIfNil(CurYHTrackMangager.productId),@"createTime":YHTrackSetEmptyIfNil(createTime)}];
    if (params) {
        [paramters addEntriesFromDictionary:params];
    }
    return paramters;
}

/**
 字典转字符串

 @param dict <#dict description#>
 @return <#return value description#>
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

/**
 url拼接

 @param baseUrl <#baseUrl description#>
 @param params <#params description#>
 @return <#return value description#>
 */
+ (NSURL *)connectWithAuthorizeUrl:(NSString *)baseUrl andParams:(NSDictionary *)params
{
    NSString *path = @"";
    
    if (params == nil) {
        return [NSURL URLWithString:baseUrl];
    }else{
        NSMutableArray *keyValues = [[NSMutableArray alloc]init];
        for (NSString *key in params.keyEnumerator) {
            NSString *keyAndValue = [NSString stringWithFormat:@"%@=%@",key,YHTrackSetEmptyIfNil(params[key])];
            if ([params[key] isKindOfClass:[NSDictionary class]]) {
                NSString *t_value = [[YHTrackNetTool convertToJsonData:params[key]] stringByRemovingPercentEncoding];
                keyAndValue = [NSString stringWithFormat:@"%@=%@",key,YHTrackSetEmptyIfNil(t_value)];
                
            }
            [keyValues addObject:keyAndValue];
        }
        
        path = [keyValues componentsJoinedByString:@"&"];
        NSLog(@"%@",path);
        
        path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
    path = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"?%@",path]];
    if (CurYHTrackMangager.isDebug) {
        YHTrackLog(@"url 地址==== %@",[NSURL URLWithString:path]);
    }
    
    return [NSURL URLWithString:path];
}

@end
