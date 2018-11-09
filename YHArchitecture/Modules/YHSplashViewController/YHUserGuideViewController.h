//
//  YHUserGuideViewController.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHUserGuideViewController : YHBaseViewController
@property(copy,nonatomic) void(^finishAndBack)(void);

@end

NS_ASSUME_NONNULL_END
