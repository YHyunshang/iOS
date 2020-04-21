//
//  YHBaseWebViewController.m
//  Demo
//
//  Created by Yangli on 2018/9/28.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHBaseWebViewController.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface YHBaseWebViewController ()
/** 注入图片点击和获取图片js方法 */
@property (nonatomic, strong) WKUserScript *userScript;
/** 进度条 */
@property (nonatomic, strong) UIProgressView *progressView;
/** js交互类 */
@property (nonatomic, strong) YHJSHandler *jsHandler;

@property (nonatomic, strong) NSString *localURL;

@property (nonatomic, strong) NSString *baseURL;
@end

@implementation YHBaseWebViewController{
    NSString *_imgSrc;
}

#pragma mark ============================    mark - lazy    ============================
- (WKWebView *)webview
{
    if (!_webview) {
        WKWebViewConfiguration *configer = [[WKWebViewConfiguration alloc] init];
        configer.userContentController = [[WKUserContentController alloc] init];
        configer.preferences = [[WKPreferences alloc] init];
        configer.preferences.javaScriptEnabled = YES;
        configer.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        configer.allowsInlineMediaPlayback = YES;
        [configer.userContentController addUserScript:self.userScript];
        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configer];
        _webview.backgroundColor = [UIColor whiteColor];
        _webview.allowsBackForwardNavigationGestures = true;
        _webview.UIDelegate = self;
        _webview.navigationDelegate = self;
        [_webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        _jsHandler = [YHJSHandler jsHandlerWithWebView:_webview delegate:self]; //注册js交互
    }
    return _webview;
}

- (UIWebView *)ios8Webview
{
    if (!_ios8Webview) {
        _ios8Webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _ios8Webview.delegate = self;
        _ios8Webview.backgroundColor = [UIColor whiteColor];
        _jsHandler = [YHJSHandler jsHandlerWithWebView:_ios8Webview delegate:self]; //注册js交互
    }
    return _ios8Webview;
}

- (WKUserScript *)userScript
{
    if (!_userScript) {
        static  NSString * const jsGetImages =
        @"function getImages(){\
        var objs = document.getElementsByTagName(\"img\");\
        var imgScr = '';\
        for(var i=0;i<objs.length;i++){\
        imgScr = imgScr + objs[i].src + '++++';\
        };\
        return imgScr;\
        };function registerImageClickAction(){\
        var imgs=document.getElementsByTagName('img');\
        var length=imgs.length;\
        for(var i=0;i<length;i++){\
        img=imgs[i];\
        img.onclick=function(){\
        window.location.href='image-preview:'+this.src}\
        }\
        }";
        _userScript = [[WKUserScript alloc] initWithSource:jsGetImages injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:false];
    }
    return _userScript;
}

- (UIProgressView *)progressView
{
    if(!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 3);
        _progressView.progressTintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (instancetype)init
{
    self = [super init];
    if (self) { // custom configer
        _isRemoveCookies = YES;
        _isAutoTitle = YES;
        _isClickImage = YES;
        _isDisplayHTML = NO;
        _isDisplayCookies = NO;
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)URL
{
    self = [self init];
    if (self) {
        _firstURL = URL;
        _curURL = URL;
    }
    return self;
}

#pragma mark ============================    controller生命周期    ============================
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.extendedLayoutIncludesOpaqueBars = true;

    if (_isLocal) {
        [self.navigationController setNavigationBarHidden:YES];
        [self openLocalURL:_localURL basePath:_baseURL];
        
    }
    [self setupUI];
    if (!_isLocal) {
        [self openURL:self.firstURL];
    }
}

- (void)dealloc
{
    [self removeCookies];
    [_webview removeObserver:self forKeyPath:@"title"];
    [_webview removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)reloadWebView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self->_webview reload];
        [self->_ios8Webview reload];
    });
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _webview.frame = self.view.bounds;
    _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3);
    
    if (self.isTransform) {
        _webview.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height-20);
        _ios8Webview.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width,self.view.bounds.size.height-20);
        [self reloadWebView];
    }
}

#pragma mark ============================    function    ============================
- (void)openURL:(NSString *)url
{
    NSURL* URL = [NSURL URLWithString:url];
    if (!URL || URL == NULL) {
        NSLog(@"url不合法 ===== %@",url);
        return;
    }
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:URL];
    
    if (!request || request == NULL) {
        NSLog(@"request不合法 ===== %@",url);
        return;
    }
    [_webview loadRequest:request];
    [_ios8Webview loadRequest:request];
}

- (void)setLocalURL:(NSString *)url basePath:(NSString *)basePath
{
    _localURL = url;
    _baseURL = basePath;
    _isLocal = true;
}

- (void)openLocalURL:(NSString *)url basePath:(NSString*)basePath
{
    _isLocal = true;
    
    NSURL* baseURL = nil;
    if (basePath) {
        baseURL = [[NSURL alloc] initFileURLWithPath:basePath];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:url]) {
        NSLog(@"url  ==== %@,/n路径不存在",url);
        return;
    }
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9")) {
        [self.webview loadFileURL:[[NSURL alloc] initFileURLWithPath:url] allowingReadAccessToURL:baseURL];
    }else{
        NSString *htmlString = [NSString stringWithContentsOfFile:url encoding:NSUTF8StringEncoding error:nil];
        [self.ios8Webview loadHTMLString:htmlString baseURL:baseURL];
    }
}
// 创建左上角按钮
- (void)creatItems
{
    NSMutableArray* items = [NSMutableArray new];
    if (_webview) {
        if (_webview.canGoBack) {
            UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
            [items addObject:backItem];
        }
    }
    if (_ios8Webview) {
        if (_ios8Webview.canGoBack) {
            UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
            [items addObject:backItem];
        }
    }
    UIBarButtonItem* closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    [items addObject:closeItem];
    for (UIBarButtonItem* item in items) {
        item.tintColor = [UIColor whiteColor];
    }
    [self.navigationItem setLeftBarButtonItems:items];
}

- (void)goBack
{
    if (_webview.canGoBack) {
        [_webview goBack];
    }
    if (_ios8Webview.canGoBack) {
        [_ios8Webview goBack];
    }
}

- (void)close
{
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 预览图片
- (void)previewPicture
{
    
}

- (void)setupUI
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9") || !_isLocal) {
        [self.view addSubview:self.webview];
    }else{
        [self.view addSubview:self.ios8Webview];
    }
    [self.view addSubview:self.progressView];
}

#pragma mark ============================    js交互方法    ============================

#pragma mark ============================    WKWebView代理    ============================
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    _curURL = navigationAction.request.URL.absoluteString;
    NSLog(@"当前加载url ======== %@",_curURL);
    if ([navigationAction.request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [navigationAction.request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        _imgSrc = path;
        [self previewPicture];
    }
    
    //拨打电话
    if ([navigationAction.request.URL.scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [navigationAction.request.URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:^(BOOL success) {
                    NSLog(@"是否进行了跳转 === %d",success);
                }];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
            }
        });
    }
    
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    [self creatItems];
    decisionHandler(WKNavigationActionPolicyAllow);
}

/** 网页加载完毕调用 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.progressView.hidden = true;
    [self creatItems];
    //获取图片数组
    __weak typeof(self) weakSelf = self;
    [webView evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        weakSelf.imgSrcArray = [NSMutableArray arrayWithArray:[result componentsSeparatedByString:@"++++"]];
        if (weakSelf.imgSrcArray.count >= 2) {
            [weakSelf.imgSrcArray removeLastObject];
        }
        NSLog(@"%@",weakSelf.imgSrcArray);
    }];
    
    [webView evaluateJavaScript:@"registerImageClickAction();" completionHandler:^(id _Nullable result, NSError * _Nullable error) {}];
    
    if (_isDisplayCookies) {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [cookieJar cookies]) {
            NSLog(@"%@", cookie);
        }
    }
    
    if (_isDisplayHTML) {
        NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
        [webView evaluateJavaScript:jsToGetHTMLSource completionHandler:^(id _Nullable HTMLsource, NSError * _Nullable error) {
            NSLog(@"%@",HTMLsource);
        }];
    }
    
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    self.progressView.hidden = YES;
    [self creatItems];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    completionHandler();
}

// 信任不安全的https
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}

#pragma mark ============================    ios8 WebView代理    ============================
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"当前加载url ==== %@",request.URL.absoluteString);
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        _imgSrc = path;
        [self previewPicture];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:self.userScript.source];
    self.progressView.progress = 0;
    self.progressView.hidden = false;
    [UIView animateWithDuration:0.8 animations:^{
        self.progressView.progress = 0.6;
    }];
    [self creatItems];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.progressView.progress = 1;
    self.progressView.hidden = true;
    [self creatItems];
    if (_isAutoTitle) {
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    NSString* imagesPaths = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    _imgSrcArray = [NSMutableArray arrayWithArray:[imagesPaths componentsSeparatedByString:@"++++"]];
    if (_imgSrcArray.count >= 2) {
        [_imgSrcArray removeLastObject];
    }
    //        NSLog(@"%@",_imgSrcArray);
    [webView stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.progressView.hidden = true;
    [self creatItems];
}

#pragma mark - 清除cookie
- (void)removeCookies
{
    if (_isRemoveCookies) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9")) {
            WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
            NSSet *websiteDataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeCookies]];
            //            [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
            //                             completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
            //                                 for (WKWebsiteDataRecord *record  in records) {
            //                                     [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
            //                                                                               forDataRecords:@[record]
            //                                                                            completionHandler:^{
            //                                                                                NSLog(@"Cookies for %@ deleted successfully",record.displayName);
            //                                                                            }];
            //                                 }
            //                             }];
            [dateStore fetchDataRecordsOfTypes:websiteDataTypes
                             completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                                 for (WKWebsiteDataRecord *record  in records) {
                                     [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                               forDataRecords:@[record]
                                                                            completionHandler:^{
                                                                                NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                            }];
                                 }
                             }];
        }else{
            //清除cookies
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies]){
                [storage deleteCookie:cookie];
            }
            //            //清除UIWebView的缓存
            //            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            //            NSURLCache * cache = [NSURLCache sharedURLCache];
            //            [cache removeAllCachedResponses];
            //            [cache setDiskCapacity:0];
            //            [cache setMemoryCapacity:0];
        }
        
    }
}

#pragma mark ============================    kvo判断title和进度条    ============================
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // 首先，判断是哪个路径
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        // 判断是哪个对象
        if (object == _webview) {
            if (_webview.estimatedProgress == 1.0) {
                //隐藏
                self.progressView.hidden = YES;
            }else{
                // 添加进度数值
                self.progressView.hidden = NO;
                self.progressView.progress = _webview.estimatedProgress;
            }
        }
    }
    if ([keyPath isEqualToString:@"title"]) {
        // 判断是哪个对象
        if (object == _webview) {
            __weak typeof(self) weakSelf = self;
            if (_isAutoTitle) {
                self.title = _webview.title;
            }
            if (weakSelf.titleBlock) {
                weakSelf.titleBlock(_webview.title);
            }
        }
    }
}





@end
