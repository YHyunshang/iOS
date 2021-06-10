//
//  YHConstant.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#ifndef YHConstant_h
#define YHConstant_h

// log日志
#ifdef DEBUG
#define YHLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define YHLog(format, ...)
#endif

// 当前版本号
#define AppVersion [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] intValue]

//获取当前语言
#define YHCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//屏幕大小宏定义
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_SCALE   (SCREEN_WIDTH/320.0)

//颜色r、g、b
#define YHRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//16进制颜色
#define YHHexColor(hexstr) [UIColor colorWithHexString:hexstr]

// kvo自动提示宏
#define keyPath(objc,keyPath) @(((void)objc.keyPath,#keyPath))

// 弱引用宏
#define YHWeakSelf(type)  __weak typeof(type) weak##type = type;

// 强引用宏
#define YHStrongSelf(type)  __strong typeof(type) type = weak##type;

#define iPhoneX_AreaH (isIPhoneXSeries ? 34 : 0)

//沙盒目录文件
//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// 单例宏
#define YHShareInstanceWithClass(CLASS) \
static CLASS * sharedInstance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[CLASS alloc] init]; \
}); \
return sharedInstance;

// 机型
#define Is_Ipad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define Is_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//刘海屏系列
#define isIPhoneXSeries ((MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 896) || (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 812))

//通知
#define YHNotificationDefaultCenter [NSNotificationCenter defaultCenter]

//偏好设置存储
#define YHUserDefaults [NSUserDefaults standardUserDefaults]

//时间戳格式化
#define YHTimeIntervalFormatter(timeInterval,formatter)    myTimeIntervalFormatter(LRTimeIntervalSince1970(timeInterval),formatter)

UIKIT_STATIC_INLINE NSString * myTimeIntervalFormatter(NSTimeInterval time,NSString *formatter){
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];\
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
    [dateFormatter setDateFormat:formatter];\
    NSString *datestring = [dateFormatter stringFromDate:date];\
    return datestring;\
}

//获取图片资源
UIKIT_STATIC_INLINE UIImage *YHImage(id imageName){
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName] ];
}

//获取view所属的controller
UIKIT_STATIC_INLINE UIViewController *YHgetCurViewController(UIView *view){
    for (UIView* next = view; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

//设置 button  或 label 的字体 颜色
UIKIT_STATIC_INLINE void LRLabelButtonQuickSet(id labelOrButton,id textcolor, CGFloat fontsize ){
    if ([labelOrButton isKindOfClass:[UIButton class]]) {
        UIButton *tempbutton=labelOrButton;
        [tempbutton setTitleColor:textcolor forState:UIControlStateNormal];
        [tempbutton.titleLabel setFont:[UIFont systemFontOfSize:fontsize]];
    }
    else{
        [labelOrButton setTextColor:textcolor];
        [labelOrButton setFont:[UIFont systemFontOfSize:fontsize]];
    }
}

//7.设置 view 圆角和边框
#define YHViewCornerRadius(view,Radius)\
{float rad=Radius;if(rad<0){rad=2.5;}\
[view.layer setCornerRadius:(rad)];[view.layer setMasksToBounds:YES];}

//设置控件圆角和边框
#define LRViewBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//处理接口解析数据小数点精度问题
UIKIT_STATIC_INLINE NSString * LRRateString(NSString *originString,NSUInteger effective){
    if(!originString){
        return nil;
    }
    double testDouble = [originString doubleValue];
    NSString *doubleStr = @"";
    if (effective == 3) {
        doubleStr = [NSString stringWithFormat:@"%.3f", testDouble];
    }else if(effective == 2){
        doubleStr = [NSString stringWithFormat:@"%.2f", testDouble];
    }else if(effective == 1){
        doubleStr = [NSString stringWithFormat:@"%.1f", testDouble];
    }else if(effective == 4){
        doubleStr = [NSString stringWithFormat:@"%.4f", testDouble];
    }
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleStr];
    return [decNumber stringValue];
}


#define CurAppDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)
#define FIRSTENTER  @"FIRSTENTER"

#endif /* YHConstant_h */
