//
//  YHBaseWebViewController.h
//  Demo
//
//  Created by Yangli on 2018/9/28.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "YHJSHandler.h"

typedef void(^YHWebViewBlock)(id item);

NS_ASSUME_NONNULL_BEGIN

@interface YHBaseWebViewController : UIViewController<WKUIDelegate,WKNavigationDelegate,YHJSHandlerDelegate,UIWebViewDelegate>

@property (nonatomic, strong) WKWebView* webview;

/**
 当为ios8而且加载本地html时候,启用iosWebView
 */
@property (nonatomic, strong) UIWebView* ios8Webview;

/** 当前请求的url */
@property (nonatomic, strong) NSString* curURL;

/** 第一次请求的url */
@property (nonatomic, strong) NSString* firstURL;

/** web页面中的图片链接数组 */
@property (nonatomic, strong) NSMutableArray *imgSrcArray;

/** 网页标题更改回调 */
@property (nonatomic, strong) YHWebViewBlock titleBlock;

/** 是否清楚cookie,默认YES */
@property (nonatomic, assign) BOOL isRemoveCookies;

/** 是否取网页标题为controller标题,默认YES */
@property (nonatomic, assign) BOOL isAutoTitle;

/** 是否点击图片放大, 默认YES */
@property (nonatomic, assign) BOOL isClickImage;

/** 点击下标图片回调 */
@property (nonatomic, strong) YHWebViewBlock imageBlock;

/**
 是否显示加载的HTML页面源码 default NO
 */
@property (nonatomic, assign) BOOL isDisplayHTML;

/**
 是否显示加载的HTML页面中的cookie default NO
 */
@property (nonatomic, assign) BOOL isDisplayCookies;

/**
 是否本地链接,默认NO
 */
@property (nonatomic, assign) BOOL isLocal;

/**
 是否隐藏navi,默认NO
 */
@property (nonatomic, assign) BOOL isTransform;

- (instancetype)initWithURL:(NSString*)URL;

- (void)openURL:(NSString*)url;

- (void)setLocalURL:(NSString*)url basePath:(NSString*)basePath;

- (void)close;

- (void)reloadWebView;
@end

NS_ASSUME_NONNULL_END
