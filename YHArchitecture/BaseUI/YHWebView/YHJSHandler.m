//
//  YHJSHandler.m
//  Demo
//
//  Created by Yangli on 2018/9/28.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHJSHandler.h"

@implementation YHJSHandler

+ (instancetype)jsHandlerWithWebView:(id )webView delegate:(id<YHJSHandlerDelegate>)delegate{
    YHJSHandler* handler = [[YHJSHandler alloc] init];
    if ([webView isKindOfClass:[UIWebView class]]) {
        handler.webView = webView;
    }
    if ([webView isKindOfClass:[WKWebView class]]) {
        handler.wkWebView = webView;
    }
    handler.delegate = delegate;
    handler.jsBridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [handler.jsBridge setWebViewDelegate:delegate];
    [handler addFunctions:handler.jsBridge];
    return handler;
}

- (void)addFunctions:(WebViewJavascriptBridge*)bridge{
    __weak typeof(self) weakSelf = self;
    [bridge registerHandler:@"getParam" handler:^(id data, WVJBResponseCallback responseCallback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"/nh5调用了getParam方法/n");
            responseCallback(@"");
        });
    }];
    
    [bridge registerHandler:@"scanCode" handler:^(id data, WVJBResponseCallback responseCallback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"/nh5调用了scanCode方法/n");
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(jsHandlerScanCodeWith:data:callBack:)]) {
                NSLog(@"/n对象 === %@,/n接收了scanCode方法/n",weakSelf.delegate);
                [weakSelf.delegate jsHandlerScanCodeWith:weakSelf data:data callBack:responseCallback];
            }
        });
    }];
    
    [bridge registerHandler:@"refresh" handler:^(id data, WVJBResponseCallback responseCallback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"/nh5调用了scanCode方法/n");
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(jsHandlerRefreshWith:data:callBack:)]) {
                NSLog(@"/n对象 === %@,/n接收了scanCode方法/n",weakSelf.delegate);
                [weakSelf.delegate jsHandlerRefreshWith:weakSelf data:data callBack:responseCallback];
            }
        });
    }];
    
    [bridge registerHandler:@"backPrevious" handler:^(id data, WVJBResponseCallback responseCallback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"/nh5调用了scanCode方法/n");
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(jsHandlerBackPreviousWith:data:callBack:)]) {
                NSLog(@"/n对象 === %@,/n接收了scanCode方法/n",weakSelf.delegate);
                [weakSelf.delegate jsHandlerBackPreviousWith:weakSelf data:data callBack:responseCallback];
            }
        });
    }];
    
    [bridge registerHandler:@"goToView" handler:^(id data, WVJBResponseCallback responseCallback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"/nh5调用了scanCode方法/n");
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(jsHandlerGoToViewWith:data:callBack:)]) {
                NSLog(@"/n对象 === %@,/n接收了scanCode方法/n",weakSelf.delegate);
                [weakSelf.delegate jsHandlerGoToViewWith:weakSelf data:data callBack:responseCallback];
            }
        });
    }];
    
}

@end
