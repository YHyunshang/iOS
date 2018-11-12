//
//  YHSXNetworkConfig.m
//  YHArchitecture
//
//  Created by Yangli on 2018/11/12.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHSXNetworkConfig.h"

@implementation YHSXNetworkConfig

+ (instancetype)sharedConfiguration
{
    static YHSXNetworkConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YHSXNetworkConfig alloc] init];
    });
    
    return instance;
}

- (NSInteger)requestTimeOut
{
    return 30.f;
}

- (NSDictionary*)customRequestHeader
{
    return @{@"Content-Type":@"application/json",@"X-AUTH-TOKEN":@"",@"X-DEVICE":@"iOS",@"X-VERSION":@"1.64"};
}

- (NSSet *)responseAcceptableContentTypes
{
    return [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
}

- (NSInteger)requestParameterEncoding
{
    return 1;
}

- (NSInteger)responseParameterEncoding
{
    return 0;
}


@end
