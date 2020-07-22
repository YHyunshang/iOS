//
//  YLQRCodeObtain.h
//  Supplier
//
//  Created by Yangli on 2020/6/8.
//  Copyright © 2020 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLQRCodePreview;

NS_ASSUME_NONNULL_BEGIN

@interface YLQRCodeObtain : NSObject

- (instancetype)initWithPreviewView:(YLQRCodePreview *)previewView completion:(void(^)(void))completion;

- (void)startScanningWithCallback:(void(^)(NSString *))callback autoStop:(BOOL)autoStop;

- (void)startScanningWithCallback:(void(^)(NSString *))callback;

- (void)stopScanning;

- (void)presentPhotoLibraryWithRooter:(UIViewController *)rooter callback:(void(^)(NSString *))callback;

@end

NS_ASSUME_NONNULL_END
