//
//  NSDictionary+YHLog.m
//  YHArchitecture
//
//  Created by Yangli on 2020/2/4.
//  Copyright © 2020 永辉. All rights reserved.
//

#import "NSDictionary+YHLog.h"
#import <objc/runtime.h>

@implementation NSDictionary (YHLog)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sp_swizzleSelector([self class], @selector(descriptionWithLocale:indent:), @selector(sp_descriptionWithLocale:indent:));
    });
}

- (NSString *)sp_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self stringByReplaceUnicode:[self sp_descriptionWithLocale:locale indent:level]];
}

- (NSString *)stringByReplaceUnicode:(NSString *)unicodeString
{
    if (!unicodeString) {
        return @"";
    }
    NSMutableString *convertedString = [unicodeString mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    return convertedString;
}

static inline void sp_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(theClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(theClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
