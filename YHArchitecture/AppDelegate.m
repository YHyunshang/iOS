//
//  AppDelegate.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "AppDelegate.h"
#import <WHDebugTool/WHDebugToolManager.h>
#import <YHTrackHeader.h>
#import "YHSplashViewController.h"
#import <AppOrderFiles/AppOrderFiles.h>
#import "LSSafeProtector.h"
#import <Bugly/Bugly.h>
#import "YHDeployInfo.h"

//自测启动耗时使用
extern CFAbsoluteTime YH_MainStartTime;

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    //二进制重排文件表可注释
//    AppOrderFiles(^(NSString *orderFilePath) {
//        YHLog(@"orderFilePath --- %@",orderFilePath);
//    });
    [self configAssistTool];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[YHSplashViewController new]];
    
    if (YH_ISDEBUG) {
        //统计mainLaunchTime耗时
        double mainLaunchTime = (CFAbsoluteTimeGetCurrent() - YH_MainStartTime);
        YHLog(@"mainLaunchTime 阶段耗时：%.2fms", mainLaunchTime * 1000);
    }
    return YES;
}

#pragma mark ============================    private method    ============================

- (void)configAssistTool
{
    //初始化bugly
    [Bugly startWithAppId:YH_ISDEBUG ? @"":@""];
    //开启防止闪退功能：注意线上环境isDebug一定要设置为NO)
    [LSSafeProtector openSafeProtectorWithIsDebug:YH_ISDEBUG types:LSSafeProtectorCrashTypeAll block:^(NSException *exception, LSSafeProtectorCrashType crashType) {
        //上传崩溃信息到bugly
        [Bugly reportExceptionWithCategory:3 name:exception.name reason:[NSString stringWithFormat:@"%@ 崩溃位置:%@",exception.reason,exception.userInfo[@"location"]] callStack:@[exception.userInfo[@"callStackSymbols"]] extraInfo:exception.userInfo terminateApp:NO];
    }];
    if (YH_ISDEBUG) {
        //性能监控工具
        [[WHDebugToolManager sharedInstance] toggleWith: DebugToolTypeAll];
    }
    
    //公司内部数据统计
//    [YHTrackManager configWithProductId:@"YHFresh" defaultPath:@"YHTrack_Data" loadPath:[NSURL URLWithString:@""]];
}
@end
