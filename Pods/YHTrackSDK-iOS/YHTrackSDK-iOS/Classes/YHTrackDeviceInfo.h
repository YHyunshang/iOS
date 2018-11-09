//
//  YHDeviceInfo.h
//  YHTrackSDK
//
//  Created by Yangli on 2018/9/12.
//  Copyright © 2018年 永辉. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CurDeviceInfo [YHTrackDeviceInfo sharedInstance]

@interface YHTrackDeviceInfo : NSObject

/* 当前设备 */
@property (nonatomic, strong) UIDevice *device;
/* 设备名 */
@property (nonatomic, strong) NSString *name;
/* 系统名 */
@property (nonatomic, strong) NSString *systemName;
/* 系统版本号 */
@property (nonatomic, strong) NSString *phoneVersion;
/* 设备品牌 */
@property (nonatomic, strong) NSString *brand;
/* 设备型号 */
@property (nonatomic, strong) NSString *model;
/* 设备唯一标示符 */
@property (nonatomic, strong) NSString *identifier;
/* 屏幕宽度 */
@property (nonatomic, assign) CGFloat width;
/* 设备高度 */
@property (nonatomic, assign) CGFloat height;
/* 运营商 */
@property (nonatomic, strong) NSString *carrierName;
/* 当前网络类型 */
@property (nonatomic, strong) NSString *connectType;
/* 信号强弱 */
@property (nonatomic, assign) int signalLevel;
/* 当前电池状态 */
@property (nonatomic, strong) NSString *batteryState;
/* 电池电量 */
@property (nonatomic, strong) NSString *batteryLevel;


/**
 初始化

 @return <#return value description#>
 */
+ (instancetype)sharedInstance;

/**
 使设备震动
 */
- (void)deviceShake;

@end
