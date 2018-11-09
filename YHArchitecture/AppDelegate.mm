//
//  AppDelegate.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "AppDelegate.h"
#import <WHDebugTool/WHDebugToolManager.h>
#import "WTSafeGuard.h"
#import <YHTrackHeader.h>
#import "YHSplashViewController.h"
#import "YHToast.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configAssistTool];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[YHSplashViewController new]];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}


- (void)applicationWillTerminate:(UIApplication *)application
{

}

#pragma mark ============================    private method    ============================

- (void)configAssistTool
{
    //性能监控工具
    [[WHDebugToolManager sharedInstance] toggleWith: DebugToolTypeAll];
    //防止崩溃造成闪退
    [WTSafeGuard startSafeGuardWithType:WTSafeGuardType_NilTarget| WTSafeGuardType_Foundation];
    //公司内部数据统计
//    [YHTrackManager configWithProductId:@"YHFresh" defaultPath:@"YHTrack_Data" loadPath:[NSURL URLWithString:@""]];
}
@end
