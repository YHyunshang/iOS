//
//  YHLaunchManager.m
//  YHArchitecture
//
//  Created by Yangli on 2020/4/20.
//  Copyright © 2020 永辉. All rights reserved.
//

#import "YHLaunchManager.h"
#import "XHLaunchAd.h"

@interface YHLaunchManager()<XHLaunchAdDelegate>

@end

@implementation YHLaunchManager

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self sharedManager];
    });
}

+ (instancetype)sharedManager{
    static YHLaunchManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YHLaunchManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //初始化开屏广告
            [self setupXHLaunchAd];
        }];
    }
    return self;
}

//XHLaunchAd使用示例
- (void)setupXHLaunchAd{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchScreen];
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    //注意本地广告图片,直接放在工程目录,不要放在Assets里面,否则不识别,此处涉及到内存优化
    imageAdconfiguration.imageNameOrURLString = @"launchimg.jpg";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.it7090.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeRoundProgressText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

#pragma mark ============================   XHLaunchAdDelegate     ============================

/// 广告点击
/// @param launchAd <#launchAd description#>
/// @param openModel <#openModel description#>
/// @param clickPoint <#clickPoint description#>
- (BOOL)xhLaunchAd:(XHLaunchAd *)launchAd clickAtOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    //广告点击逻辑处理
    return YES;//YES移除广告,NO不移除广告
}

/// 跳过按钮点击
/// @param launchAd <#launchAd description#>
/// @param skipButton <#skipButton description#>
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickSkipButton:(UIButton *)skipButton{
    //跳过按钮处理
}

/// 图片下载完成
/// @param launchAd <#launchAd description#>
/// @param image <#image description#>
/// @param imageData <#imageData description#>
- (void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData{
    
}

- (void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd
{
    
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}
@end
