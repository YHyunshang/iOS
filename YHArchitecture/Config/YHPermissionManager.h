//
//  YHPermissionManager.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/26.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHPermissionManager : NSObject

/**
 *  权限管理类
 *
 *  @return 权限管理实例
 */
+ (instancetype)shareInstance;

/**
 *  检测是否有相机权限
 *
 *  @return YES 有权限
 */
- (BOOL)checkCameraAuthorization;

/**
 *  检测是否有定位权限
 *
 *  @return YES 有权限
 */
- (BOOL)checkLocationPermission;

/**
 *  跳转设置摄像头权限
 */
- (void)goToSettingCameraAuthorization;

/**
 *  跳转到app权限列表界面
 */
- (void)goToAppAuthorizationListView;

/**
 *  验证是否有相机权限，并且showAlert
 *
 *  @param ret <#ret description#>
 */
- (void)verifyCanPhoto:(void(^)(BOOL canPhoto))ret;

/**
 *  验证是否有定位权限，并且showAlert
 *
 *  @param ret <#ret description#>
 */
- (void)verifyCanLocation:(void(^)(BOOL canLocation))ret;

/**
 *  验证麦克风开启权限
 *
 *  @param ret <#ret description#>
 */
- (void)verifyCanMCP:(void(^)(BOOL canMCP))ret;

@end

NS_ASSUME_NONNULL_END
