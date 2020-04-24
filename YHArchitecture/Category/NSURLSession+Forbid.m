//
//  NSURLSession+Forbid.m
//  YHAssistant
//
//  Created by Yangli on 2019/7/15.
//  Copyright © 2019 yonghui. All rights reserved.
//

#import "NSURLSession+Forbid.h"
#import <objc/runtime.h>

void swizzing(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@implementation NSURLSession (Forbid)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSURLSession class];
        swizzing(class, @selector(sessionWithConfiguration:), @selector(yl_sessionWithConfiguration:));
        
        swizzing(class, @selector(sessionWithConfiguration:delegate:delegateQueue:),
                 @selector(yl_sessionWithConfiguration:delegate:delegateQueue:));
    });
}

+ (NSURLSession *)yl_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
                                     delegate:(nullable id<NSURLSessionDelegate>)delegate
                                delegateQueue:(nullable NSOperationQueue *)queue
{
    if (!configuration){
        configuration = [[NSURLSessionConfiguration alloc] init];
    }
    configuration.connectionProxyDictionary = @{};
    return [self yl_sessionWithConfiguration:configuration delegate:delegate delegateQueue:queue];
}

+ (NSURLSession *)yl_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (configuration){
        configuration.connectionProxyDictionary = @{};
    }
    return [self yl_sessionWithConfiguration:configuration];
}


@end
