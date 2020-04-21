//
//  UIViewController+YHModalStyle.m
//  YHArchitecture
//
//  Created by Yangli on 2019/10/10.
//  Copyright © 2019 yonghui. All rights reserved.
//

#import "UIViewController+YHModalStyle.h"
#import <objc/runtime.h>

static const char *YH_automaticallySetModalPresentationStyleKey;

@implementation UIViewController (YHModalStyle)


+ (void)load
{
    Method originAddObserverMethod = class_getInstanceMethod(self, @selector(presentViewController:animated:completion:));
    Method swizzledAddObserverMethod = class_getInstanceMethod(self, @selector(YH_presentViewController:animated:completion:));
    method_exchangeImplementations(originAddObserverMethod, swizzledAddObserverMethod);
}

- (void)setYH_automaticallySetModalPresentationStyle:(BOOL)YH_automaticallySetModalPresentationStyle
{
    objc_setAssociatedObject(self, YH_automaticallySetModalPresentationStyleKey, @(YH_automaticallySetModalPresentationStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)LL_automaticallySetModalPresentationStyle
{
    id obj = objc_getAssociatedObject(self, YH_automaticallySetModalPresentationStyleKey);
    if (obj) {
        return [obj boolValue];
    }
    return [self.class YH_automaticallySetModalPresentationStyle];
}

+ (BOOL)YH_automaticallySetModalPresentationStyle
{
    if ([self isKindOfClass:[UIImagePickerController class]] || [self isKindOfClass:[UIAlertController class]]) {
        return NO;
    }
    return YES;
}

- (void)YH_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    if (@available(iOS 13.0, *)) {
        if (viewControllerToPresent.LL_automaticallySetModalPresentationStyle) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self YH_presentViewController:viewControllerToPresent animated:flag completion:completion];
    } else {
        // Fallback on earlier versions
        [self YH_presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
}



@end
