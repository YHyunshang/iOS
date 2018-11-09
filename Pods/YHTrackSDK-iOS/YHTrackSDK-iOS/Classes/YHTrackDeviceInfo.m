//
//  YHDeviceInfo.m
//  YHTrackSDK
//
//  Created by Yangli on 2018/9/12.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHTrackDeviceInfo.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <dlfcn.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation YHTrackDeviceInfo

+ (instancetype)sharedInstance
{
    static YHTrackDeviceInfo *deviceInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceInfo = [[YHTrackDeviceInfo alloc] init];
        deviceInfo.device = [UIDevice currentDevice];
    });
    return deviceInfo;
}


/**
 手机名称

 @return <#return value description#>
 */
- (NSString *)name
{
    return [[YHTrackDeviceInfo sharedInstance].device name];
}

/**
 系统名

 @return <#return value description#>
 */
- (NSString *)systemName{
    return [[YHTrackDeviceInfo sharedInstance].device systemName];
}

/**
 系统版本号

 @return <#return value description#>
 */
- (NSString *)phoneVersion
{
    return [[YHTrackDeviceInfo sharedInstance].device systemVersion];
}


/**
 设备品牌

 @return <#return value description#>
 */
- (NSString *)brand
{
    return [[YHTrackDeviceInfo sharedInstance].device model];
}

/**
 设备型号

 @return <#return value description#>
 */
- (NSString *)model
{
    return [YHTrackDeviceInfo iphoneType];
}

/**
 设备唯一标示符

 @return <#return value description#>
 */
- (NSString *)identifier
{
    return [[[YHTrackDeviceInfo sharedInstance].device identifierForVendor] UUIDString];
}

/**
 屏幕宽度

 @return <#return value description#>
 */
- (CGFloat)width
{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGSize size = rect.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    return size.width * scale;
}

/**
 屏幕高度

 @return <#return value description#>
 */
- (CGFloat)height
{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGSize size = rect.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    return size.height * scale;
}

/**
 运营商名称

 @return <#return value description#>
 */
- (NSString *)carrierName
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    /* 运营商名称 */
    NSString *carrierName = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    return carrierName;
}

/**
 网络类型

 @return <#return value description#>
 */
- (NSString *)connectType
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    /* 当前网络类型 */
    NSString *connectType = [[NSString alloc] initWithFormat:@"%@",info.currentRadioAccessTechnology];
    return connectType;
}

/**
 信号强弱

 @return <#return value description#>
 */
- (int)signalLevel
{
    return [[YHTrackDeviceInfo sharedInstance] getSignalLevel];
}

/**
 电池状态

 @return <#return value description#>
 */
- (NSString *)batteryState
{
    return [[YHTrackDeviceInfo sharedInstance] getBatteryState];
}

/**
 电量

 @return <#return value description#>
 */
- (NSString *)batteryLevel
{
    return [[YHTrackDeviceInfo sharedInstance] getBatteryInfo];
}

/**
 设备型号

 @return <#return value description#>
 */
+ (NSString *)iphoneType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    //https://www.theiphonewiki.com/wiki/Models  iOS设备信息
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone_2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone_3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone_3GS";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone_4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone_4";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone_4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone_4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone_5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone_5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone_5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone_5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone_5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone_5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone_6P";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone_6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone_6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone_6sP";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone_SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone_7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone_7P";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone_8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone_8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone_8P";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone_8P";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone_X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone_X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone_XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone_XS";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone_XS_Max";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone_XS_Max";
    
    // iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad_1";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad_2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad_2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad_2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad_2";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad_3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad_3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad_3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad_4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad_4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad_4";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad_air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad_air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad_air";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad_air2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad_air2";
    if ([platform isEqualToString:@"iPad6,7"]) return @"iPad_pro_12";
    if ([platform isEqualToString:@"iPad6,8"]) return @"iPad_pro_12";
    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad_pro_9";
    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad_pro_9";
    if ([platform isEqualToString:@"iPad6,11"]) return @"iPad_5";
    if ([platform isEqualToString:@"iPad6,12"]) return @"iPad_5";
    if ([platform isEqualToString:@"iPad7,1"]) return @"iPad_pro2_12";
    if ([platform isEqualToString:@"iPad7,2"]) return @"iPad_pro2_12";
    if ([platform isEqualToString:@"iPad7,3"]) return @"iPad_pro2_10";
    if ([platform isEqualToString:@"iPad7,3"]) return @"iPad_pro2_10";
    if ([platform isEqualToString:@"iPad7,5"]) return @"iPad_6";
    if ([platform isEqualToString:@"iPad7,6"]) return @"iPad_6";
    
    return platform;
}

/**
 获取当前信号的强弱

 @return <#return value description#>
 */
- (int)getSignalLevel
{
    void *libHandle = dlopen("/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony",RTLD_LAZY);//获取库句柄
    int (*CTGetSignalStrength)(void); //定义一个与将要获取的函数匹配的函数指针
    CTGetSignalStrength = (int(*)(void))dlsym(libHandle,"CTGetSignalStrength"); //获取指定名称的函数
    
    if(CTGetSignalStrength == NULL)
    return -1;
    else{
        int level = CTGetSignalStrength();
        dlclose(libHandle); //切记关闭库
        return level;
    }
}

/**
 使设备震动
 */
- (void)deviceShake
{
    AudioServicesPlaySystemSound ( kSystemSoundID_Vibrate);
}

/**
 获取电池当前的状态，共有4种状态

 @return <#return value description#>
 */
- (NSString*)getBatteryState
{
    UIDevice *device = [YHTrackDeviceInfo sharedInstance].device;
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return @"未知";
    }else if (device.batteryState == UIDeviceBatteryStateUnplugged){
        return @"未充电";
    }else if (device.batteryState == UIDeviceBatteryStateCharging){
        return @"充电中";
    }else if (device.batteryState == UIDeviceBatteryStateFull){
        return @"充电-已充满";
    }
    return nil;
}


/**
 获取电量的等级，0.00~1.00

 @return <#return value description#>
 */
- (float)getBatteryLevel {
    return [YHTrackDeviceInfo sharedInstance].device.batteryLevel;
}

/**
 获取电量
 */
- (NSString *)getBatteryInfo
{
    float level = [self getBatteryLevel]*100.0;
    return [NSString stringWithFormat:@"%d",(int)level];
}






@end
