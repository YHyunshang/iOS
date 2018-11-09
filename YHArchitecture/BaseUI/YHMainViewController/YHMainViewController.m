//
//  YHMainViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHMainViewController.h"
#import "UITabBarController+Additionals.h"
#import "UIView+Size.h"
#import "UITabBar+TabBarTip.h"
#import "YHNavigationViewController.h"
#import "YHConstant.h"


@interface YHMainViewController ()<UITabBarControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, assign) BOOL isShouldSelected;
@end

@implementation YHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.viewControllers = [self createSubViewController];
    [self setSelectedIndex:0];
    self.delegate = self;
    [self setItems];
}

+ (instancetype)instance
{
    YHMainViewController *controller = [[YHMainViewController alloc] init];
    return controller;
}

- (void)showBadgeOnItemIndex:(int)index
{
    [self.tabBar showBadgeOnItemIndex:index];
}

- (void)hideBadgeOnItemIndex:(int)index
{
    [self.tabBar hideBadgeOnItemIndex:index];
}

/** 设置底部item样式 */
- (void)setItems
{
    for (UIViewController *vc in self.childViewControllers) {
        [vc.tabBarItem setTitleTextAttributes:@{
                                                NSForegroundColorAttributeName:[UIColor redColor]
                                                } forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:@{
                                                NSForegroundColorAttributeName:[UIColor blueColor]
                                                } forState:UIControlStateSelected];
    }
}


- (NSArray *)createSubViewController
{
    if (CurAppDelegate.page == 0) {
        NSArray* subViewClasses = [NSArray arrayWithObjects:
                                   @"首页,FirstViewController,Tab_home1,Tab_home2",
                                   @"数据服务,SecondViewController,Tab_shujufuwu1,Tab_shujufuwu2",
                                   @"订单服务,ThirdViewController,订单服务（默认）,订单服务（点击）",
                                   @"用户中心,ForthViewController,Tab_grzhongxin1,Tab_grzhongxin2",nil];
        return [self createSubViewsFromItems:subViewClasses];
    }else{
        NSArray* subViewClasses = [NSArray arrayWithObjects:
                                   @"数据分析,SecondViewController,shouye2,shouye",
                                   nil];
        return [self createSubViewsFromItems:subViewClasses];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    _isShouldSelected = 0;
    self.tabBar.hidden = NO;
//    if (isIPhoneXSeries) {
//        self.tabBar.height = KTOPHEIGHT;
//    }
    
    YHNavigationViewController *nav = (YHNavigationViewController*)viewController;
    if (![nav.topViewController isKindOfClass:NSClassFromString(@"QSHomeViewController")]) {
        [self setSelectedViewController:viewController];
    }else{
        _isShouldSelected = YES;
    }
    return _isShouldSelected;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.selectedViewController;
}

- (void)setTabBarHidden:(BOOL)hidden
{
    UIView *tab = self.tabBarController.view;
    
    if ([tab.subviews count] < 2) {
        return;
    }
    UIView *view;
    
    if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        view = [tab.subviews objectAtIndex:1];
    } else {
        view = [tab.subviews objectAtIndex:0];
    }
    
    if (hidden) {
        view.frame = tab.bounds;
    } else {
        view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
    }
    self.view.frame = view.frame;
    self.tabBarController.tabBar.hidden = hidden;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
//    if (isIPhoneXSeries) {
//        self.tabBar.height = KTOPHEIGHT;
//    }
    
}



@end
