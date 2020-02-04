//
//  AppDelegate.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 控制app的展示效果,1为正常app  0，nil为审核版app */
@property (nonatomic, assign) BOOL page;

+ (AppDelegate *)appDelegate;

@end

