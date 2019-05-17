//
//  YHSplashViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHSplashViewController.h"
#import "YHUserGuideViewController.h"

#define NetWorkTag   111111
@interface YHSplashViewController ()<UIAlertViewDelegate>

@end

@implementation YHSplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self selectEnv];
}

#pragma mark ============================    custom method    ============================

/**
 切换环境
 */
- (void)selectEnv
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络选择" message:@"" preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"生产" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self enterApp];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"内网测试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self enterApp];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"外网测试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self enterApp];
    }]];

    [self presentViewController:alert animated:YES completion:^{

    }];
}

/**
 跳转到app
 */
- (void)enterApp
{
    if (![[YHUserDefaults objectForKey:FIRSTENTER] isEqualToString:@"NO"]) {
        [YHUserDefaults setObject:@"NO" forKey:FIRSTENTER];
        YHUserGuideViewController *userGuideVC = [YHUserGuideViewController new];
        [userGuideVC setFinishAndBack:^{
            [self enterMainViewController];
        }];
        userGuideVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:userGuideVC animated:YES completion:nil];
    }else{
        [self enterMainViewController];
    }
}

- (void)enterMainViewController
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] delegate].window;
    keyWindow.rootViewController = [YHMainViewController instance];
}

@end
