//
//  YHWeakProxy.h
//  YHArchitecture
//
//  Created by Yangli on 2020/4/26.
//  Copyright © 2020 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHWeakProxy : NSProxy
/** target */
@property (nonatomic, weak, readonly) id target;

+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
