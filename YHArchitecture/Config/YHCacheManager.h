//
//  YHCacheManager.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/26.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHCacheManager : NSObject

/**
 *  获取沙盒路径
 *
 *  @return <#return value description#>
 */
+ (NSString*)getCachesPath;

/**
 *  获取缓存大小
 *
 *  @return <#return value description#>
 */
+ (float)getCacheSize;

/**
 *  清理缓存
 *
 *
 */
+ (void)cleanCache:(void(^)(void))finish;

/**
 *  保存图片到沙盒 成功返回YES
 *
 *  @return <#return value description#>
 */
+ (BOOL)saveImage:(UIImage*)image name:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
