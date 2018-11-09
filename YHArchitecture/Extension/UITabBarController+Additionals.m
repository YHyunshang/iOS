//
//  UITabBarController+Additionals.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "UITabBarController+Additionals.h"
#import "YHNavigationViewController.h"


@implementation UITabBarController (Additionals)


//tabbaritem的批量生成
- (NSArray *)createSubViewsFromItems:(NSArray *)subViewClasses
{
    NSMutableArray *subViewControllers = [NSMutableArray new];
    NSArray *items;
    UIViewController *tmpController;
    for (NSString *class in subViewClasses) {
        items = [class componentsSeparatedByString:@","];
        if (items.count == 4) {
            tmpController = [NSClassFromString(items[1]) new];
            YHNavigationViewController *nav = [[YHNavigationViewController alloc] initWithRootViewController:tmpController];
            nav.tabBarItem.title = items[0];
            nav.tabBarItem.image = [[UIImage imageNamed:items[2]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [[UIImage imageNamed:items[3]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            /** 修改title位置 */
            [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
            [subViewControllers addObject:nav];
        }
    }
    return subViewControllers;
}

@end
