//
//  YHNavigationViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHNavigationViewController.h"

@interface YHNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation YHNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.opaque = NO;
#warning 设置导航栏背景色
    self.navigationBar.barTintColor = [YHAppColor navBackgroudColor];
    self.navigationBar.translucent=NO;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    [self customBackItem:viewController];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated hideBottom:(BOOL)hide
{
    [viewController setHidesBottomBarWhenPushed:hide];
    [self pushViewController:viewController animated:animated];
}

- (void)customBackItem:(UIViewController *)viewController
{
    if ([self.viewControllers count] > 1) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        viewController.navigationItem.leftBarButtonItem = item;
    }
}

- (void)backAction
{
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count > 1) {
        return YES;
    }else{
        return NO;
    };
}
@end
