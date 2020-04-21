//
//  YHToast.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YHToastImageType)
{
    YHToastImageTypeError = 0,
    YHToastImageTypeSuccess
};

NS_ASSUME_NONNULL_BEGIN

@interface YHToast : UIView

+ (void)showViewWithText:(NSString *)text imageType:(YHToastImageType)imageType hideDelay:(NSTimeInterval)hideDelay;

+ (void)showViewWithText:(NSString *)text imageType:(YHToastImageType)imageType;

@end

NS_ASSUME_NONNULL_END
