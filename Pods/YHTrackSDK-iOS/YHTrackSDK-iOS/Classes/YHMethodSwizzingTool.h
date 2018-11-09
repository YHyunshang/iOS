//
//  YHMethodSwizzingTool.h
//  YHTrackSDK
//
//  Created by Yangli on 2018/9/12.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHMethodSwizzingTool : NSObject

+ (void)swizzingForClass:(Class)cls originalSel:(SEL)originalSelector swizzingSel:(SEL)swizzingSelector;

+ (NSDictionary *)getConfig;


@end
