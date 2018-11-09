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
@property (nonatomic, strong) UIWebView* webView;
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
- (void)jsHandlerGetParamWith:(YHJSHandler*)jsHandler
                         data:(id)data
                     callBack:(WVJBResponseCallback)callBack;


/**
 扫码

 @param jsHandler <#jsHandler description#>
 @param data <#data description#>
 @param callBack <#callBack description#>
 */
- (void)jsHandlerScanCodeWith:(YHJSHandler*)jsHandler
                         data:(id)data
                     callBack:(WVJBResponseCallback)callBack;


/**
 web back app

 @param jsHandler <#jsHandler description#>
 @param data <#data description#>
 @param callBack <#callBack description#>
 */
- (void)jsHandlerBackPreviousWith:(YHJSHandler*)jsHandler
                         data:(id)data
                     callBack:(WVJBResponseCallback)callBack;


/**
 刷新是吧刷新

 @param jsHandler <#jsHandler description#>
 @param data <#data description#>
 @param callBack <#callBack description#>
 */
- (void)jsHandlerRefreshWith:(YHJSHandler*)jsHandler
                             data:(id)data
                         callBack:(WVJBResponseCallback)callBack;

- (void)jsHandlerGoToViewWith:(YHJSHandler*)jsHandler
                        data:(id)data
                    callBack:(WVJBResponseCallback)callBack;

@end
