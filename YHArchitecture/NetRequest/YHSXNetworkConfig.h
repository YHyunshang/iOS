//
//  YHSXNetworkConfig.h
//  YHArchitecture
//
//  Created by Yangli on 2018/11/12.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YHNetworkTools/YHNetConfig.h>



NS_ASSUME_NONNULL_BEGIN

@interface YHSXNetworkConfig : NSObject <YHNetConfig>

+ (instancetype)sharedConfiguration;

@end

NS_ASSUME_NONNULL_END
