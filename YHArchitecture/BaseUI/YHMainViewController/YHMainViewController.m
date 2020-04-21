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
    NSArray* subViewClasses = [NSArray arrayWithObjects:
                               @"首页,FirstViewController,Tab_home1,Tab_home2",
                               @"数据服务,SecondViewController,Tab_shujufuwu1,Tab_shujufuwu2",
                               @"订单服务,ThirdViewController,订单服务（默认）,订单服务（点击）",
                               @"用户中心,ForthViewController,Tab_grzhongxin1,Tab_grzhongxin2",nil];
    return [self createSubViewsFromItems:subViewClasses];
}


@end
