//
//  YHPermissionManager.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/26.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHPermissionManager.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManager.h>
#import <AVFoundation/AVFoundation.h>


@interface YHPermissionManager ()

@end

@implementation YHPermissionManager

+ (instancetype)shareInstance
{
    YHShareInstanceWithClass(YHPermissionManager)
}

//检测是否有相机权限
- (BOOL)checkCameraAuthorization
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        return NO;
    } else {
        return YES;
    }
}
/** 检测定位权限 */
- (BOOL)checkLocationPermission
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        return YES;
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        return NO;
    }
    return NO;
}
//跳转设置摄像头权限
- (void)goToSettingCameraAuthorization
{
    NSString *path = @"prefs:root=Privacy&path=CAMERA"; //路径
    NSURL *url = [NSURL URLWithString:path];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}
//跳转到app权限列表界面
- (void)goToAppAuthorizationListView
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}
/** 验证是否有相机权限，并且showAlert */
- (void)verifyCanPhoto:(void (^)(BOOL))ret
{
    if ([self checkCameraAuthorization]) {
        if (ret) {
            ret(YES);
        }
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请允许访问相册" message:@"请在设置中允许程序在运行时访问相册权限" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            ;
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self goToAppAuthorizationListView];
        }]];
        [RootTabbarViewConTroller presentViewController:alert animated:YES completion:nil];
    }
}
/** 验证是否有定位权限，并且showAlert */
- (void)verifyCanLocation:(void (^)(BOOL))ret
{
    if ([self checkLocationPermission]) {
        if (ret) {
            ret(YES);
        }
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"定位失败" message:@"请在设置中允许程序在运行时获取定位权限" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            ;
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self goToAppAuthorizationListView];
        }]];
        [RootTabbarViewConTroller presentViewController:alert animated:YES completion:nil];
    }
}

- (void)verifyCanMCP:(void (^)(BOOL))ret
{
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            if (ret) {
                ret(YES);
            }
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"获取麦克风权限失败" message:@"请在设置中允许程序获取麦克风权限" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                ;
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self goToAppAuthorizationListView];
            }]];
            [RootTabbarViewConTroller presentViewController:alert animated:YES completion:nil];
        }
    }];
}


@end
