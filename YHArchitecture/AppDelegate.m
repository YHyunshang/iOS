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
    AppOrderFiles(^(NSString *orderFilePath) {
        YHLog(@"orderFilePath --- %@",orderFilePath);
    });
    [self configAssistTool];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[YHSplashViewController new]];
    
    double mainLaunchTime = (CFAbsoluteTimeGetCurrent() - YH_MainStartTime);
    YHLog(@"mainLaunchTime 阶段耗时：%.2fms", mainLaunchTime * 1000);
    return YES;
}

#pragma mark ============================    private method    ============================

- (void)configAssistTool
{
    //性能监控工具
    [[WHDebugToolManager sharedInstance] toggleWith: DebugToolTypeAll];
    //公司内部数据统计
//    [YHTrackManager configWithProductId:@"YHFresh" defaultPath:@"YHTrack_Data" loadPath:[NSURL URLWithString:@""]];
}
@end
