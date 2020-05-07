//
//  YHWeakProxy.m
//  YHArchitecture
//
//  Created by Yangli on 2020/4/26.
//  Copyright © 2020 永辉. All rights reserved.
//

#import "YHWeakProxy.h"
#import <objc/message.h>

@implementation YHWeakProxy

- (instancetype)initWithTarget:(id)target
{
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target
{
    return [[self alloc] initWithTarget:target];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *sinature = [self.target methodSignatureForSelector:sel];
    if (sinature == nil) {
        NSString *info = [NSString stringWithFormat:@"%@ 方法找不到",NSStringFromSelector(sel)];
        [NSException exceptionWithName:@"方法调用异常" reason:info userInfo:nil];
    }
    return sinature;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.target respondsToSelector:aSelector];
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    return [_target isMemberOfClass:aClass];
}

- (BOOL)isEqual:(id)object
{
    return [_target isEqual:object];
}

- (NSUInteger)hash
{
    return [_target hash];
}

- (Class)superclass
{
    return [_target superclass];
}

- (Class)class
{
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass
{
    return [_target isKindOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy
{
    return YES;
}

- (NSString *)description
{
    return [_target description];
}

- (NSString *)debugDescription
{
    return [_target debugDescription];
}

@end
