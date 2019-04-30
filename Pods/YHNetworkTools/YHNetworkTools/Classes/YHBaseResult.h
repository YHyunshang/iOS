//
//  YHBaseResult.h
//  YHNetClient_Example
//
//  Created by Yangli on 2019/4/1.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import <YLJsonLib/YLJastor.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHBaseResult : YLJastor

+ (BOOL)handleResult:(id)result;

@end

NS_ASSUME_NONNULL_END
