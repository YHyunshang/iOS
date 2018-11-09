//
//  UITabBarController+Additionals.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarController (Additionals)

/**
 tabbaritem的批量生成，格式如下
 NSArray* subViewClasses = [NSArray arrayWithObjects:
 @"供零在线,QSHomeViewController,shouye2,shouye",
 @"订购服务,QSOrderViewController,dinggou,dinggou2-0",
 @"用户中心,QSUserCenterController,geren,geren2",
 @"购物车,QSCartViewController,gouwuche,gouwuche-2",nil];
 
 @param subViewClasses <#subViewClasses description#>
 @return <#return value description#>
 */
- (NSArray *)createSubViewsFromItems:(NSArray *)subViewClasses;

@end

NS_ASSUME_NONNULL_END
