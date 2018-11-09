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

#define PhotoAlertTag 666
#define LocationAlertTag 667
#define MCPAlertTag 668

@interface YHPermissionManager ()<UIAlertViewDelegate>

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
    NSString *path = @"Privacy&path=CAMERA"; //路径
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请打开摄像头" message:@"请在设置中允许程序在运行时获取摄像头权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = PhotoAlertTag;
        [alert show];
        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请打开摄像头" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//
//        [alert addAction:[UIAlertAction actionWithTitle:@"请在设置中允许程序在运行时获取摄像头权限" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }]];
//
//        [self presentViewController:alert animated:YES completion:nil];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"请在设置中允许程序在运行时获取定位权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = LocationAlertTag;
        [alert show];
        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络选择" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//
//        [alert addAction:[UIAlertAction actionWithTitle:@"生产" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self enterApp];
//        }]];
//
//        [self presentViewController:alert animated:YES completion:^{
//
//        }];
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取麦克风权限失败" message:@"请在设置中允许程序获取麦克风权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            alert.tag = MCPAlertTag;
            [alert show];
            
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络选择" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//
//            [alert addAction:[UIAlertAction actionWithTitle:@"生产" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [self enterApp];
//            }]];
//
//            [self presentViewController:alert animated:YES completion:^{
//
//            }];
        }
    }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == PhotoAlertTag) {
        if (buttonIndex == 1) {
            [self goToSettingCameraAuthorization];
        }
    }
    if (alertView.tag == LocationAlertTag) {
        if (buttonIndex == 1) {
            [self goToAppAuthorizationListView];
        }
    }
    if (alertView.tag == MCPAlertTag) {
        if (buttonIndex == 1) {
            [self goToAppAuthorizationListView];
        }
    }
}


@end
