//
//  YHJSHandler.h
//  Demo
//
//  Created by Yangli on 2018/9/28.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewJavascriptBridge.h"
@protocol YHJSHandlerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface YHJSHandler : NSObject
@property (nonatomic, strong) WKWebView* wkWebView;
@property (nonatomic, strong) WebViewJavascriptBridge* jsBridge;
@property (nonatomic, weak) id<YHJSHandlerDelegate> delegate;

+ (instancetype)jsHandlerWithWebView:(id)webView
                            delegate:(id<YHJSHandlerDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END

@protocol YHJSHandlerDelegate <NSObject>

@optional


/**
 获取参数

 @param jsHandler <#jsHandler description#>
 @param data <#data description#>
 @param callBack <#callBack description#>
 */
- (void)jsHandlerGetParamWith:(YHJSHandler*_Nonnull)jsHandler
                         data:(id _Nullable )data
                     callBack:(WVJBResponseCallback _Nonnull )callBack;


/**
 扫码

 @param jsHandler <#jsHandler description#>
 @param data <#data description#>
 @param callBack <#callBack description#>
 */
- (void)jsHandlerScanCodeWith:(YHJSHandler*_Nonnull)jsHandler
                         data:(id _Nullable )data
                     callBack:(WVJBResponseCallback _Nonnull )callBack;


/**
 web back app

 @param jsHandler <#jsHandler description#>
 @param data <#data description#>
 @param callBack <#callBack description#>
 */
- (void)jsHandlerBackPreviousWith:(YHJSHandler*_Nonnull)jsHandler
                             data:(id _Nullable )data
                         callBack:(WVJBResponseCallback _Nonnull )callBack;


/**
 刷新是吧刷新

 @param jsHandler <#jsHandler description#>
 @param data <#data description#>
 @param callBack <#callBack description#>
 */
- (void)jsHandlerRefreshWith:(YHJSHandler*_Nonnull)jsHandler
                        data:(id _Nullable )data
                    callBack:(WVJBResponseCallback _Nonnull )callBack;

- (void)jsHandlerGoToViewWith:(YHJSHandler*_Nullable)jsHandler
                         data:(id _Nullable )data
                     callBack:(WVJBResponseCallback _Nonnull )callBack;

@end
