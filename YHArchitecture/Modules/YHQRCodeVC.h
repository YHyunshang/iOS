//
//  YHQRCodeVC.h
//  YHArchitecture
//
//  Created by Yangli on 2020/7/22.
//  Copyright © 2020 永辉. All rights reserved.
//

#import "YHBaseViewController.h"

typedef void(^YHQRScanResultBlock)(id result);

NS_ASSUME_NONNULL_BEGIN

@interface YHQRCodeVC : YHBaseViewController

/** <#Description#> */
@property (nonatomic, copy) YHQRScanResultBlock scanResultBlock;


@end

NS_ASSUME_NONNULL_END
