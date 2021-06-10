//
//  YLQRCodePreview.h
//  Supplier
//
//  Created by Yangli on 2020/6/8.
//  Copyright © 2020 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YLQRCodePreview;

/** <#Description#> */
@protocol YLQRCodePreviewDelegate <NSObject>

//遵守协议必须实现的方法
@required

//遵守协议 实现不实现方法都可以
@optional
- (void)codeScanningView:(YLQRCodePreview *)scanningView didClickedTouchSwitch:(UIButton *)switchButton;

@end

@interface YLQRCodePreview : UIView

@property (nonatomic, assign, readonly) CGRect rectFrame;
@property (nonatomic, weak) id<YLQRCodePreviewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame rectColor:(UIColor *)rectColor tip:(NSString *)tip;
- (instancetype)initWithFrame:(CGRect)frame rectColor:(UIColor *)rectColor tip:(NSString *)tip;
- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame tip:(NSString *)tip;
- (void)setTip:(NSString *)detail;
- (void)startScanning;
- (void)stopScanning;
- (void)startIndicating;
- (void)stopIndicating;
- (void)showTorchSwitch;
- (void)hideTorchSwitch;


@end

NS_ASSUME_NONNULL_END
