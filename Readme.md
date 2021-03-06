### 永辉iOS项目说明文档
* [1 开发语言](#1-开发语言)
* [2 运行环境](#2-运行环境)
* [3 使用说明](#3-使用说明)
* [4 框架及目录结构](#4-框架及目录结构)
* [5 组件库说明](#5-组件库说明)
* [6 部分控件使用说明](#6-部分控件使用说明)
* [7 版本更新说明](#7-版本更新说明)

#### 1 开发语言

>Objective-C为主

>Swift、Objective-C混合开发(部分项目)

#### 2 运行环境

###### a、编译工具
>Xcode11.0+,[下载或更新][下载或更新]

###### b、包管理工具
>电脑配置cocoapod(注：未配置可参考：[cocoapod 配置][cocoapod 配置])

#### 3 使用说明

###### a、[编码须知][编码须知]

###### b、初始化项目
>type1  ===>   cd到项目目录 
    
>type2  ===>   执行命令 ： pod install

#### 4 框架及目录结构

###### a、说明
> 根据项目实际需要、人员配置及维护成本选择MVC、MVP、MVVM等开发模式

###### b、目录结构
```
├── Readme.md                   // help
├── 编码须知.txt                 // 编码规范             
├── config                      // 项目配置文件
│   ├── YHAppColor              // 应用颜色配置
│   ├── YHPermissionManager     // 常用权限获取
│   ├── YHCacheManager          // 存储管理
│   ├── YHUrlMacro              // 域名接口配置
│   ├── YHPlatformIDsMacro      // 第三方平台账号
│   ├── YHConstant              // 常用宏定义
│   ├── YHLaunchManager         // 开屏广告配置
│   └── YHArchitecture.pch      // 全局头文件管理
├── Resource                    // 资源库配置
│   ├── YHTrack_Data            // 永辉埋点配置文件
│   └── Assets                  // 项目图片管理
├── NetRequest                  // 请求类
├── Library                     // 非pod第三方库
├── Category                    // Category
├── Widgets                     // 自定义扩展类、控件
├── BaseUI                      // UI控件基类
│   ├── YHPickerView            // 单选picker封装
│   ├── YHWebView               // webview 封装
│   ├── YHMultisegmentView      // 订单列表头部封装
│   ├── YHToast                 // 基本提示封装
│   ├── YHTextField             // TextField封装
│   ├── YHButton                // Button封装
│   ├── TableViewAndCollectionView // tableView 和collectionView基类
│   └── YHMainViewController    // 项目基础框架
├── Modules                     // 模块
│   ├── YHSplashViewController  // 项目指引
│   │   ├── YHSplashViewController     // 环境切换配置
│   │   └── YHUserGuideViewController  // 产品说明轮播图
code file
... ...  ...
└──
├── Podfile                     // 第三方依赖库
│   ├── AFNetworking            // 网络库
│   ├── Masonry                 // 布局库
│   ├── SDWebImage              // 图片缓存
│   ├── IQKeyboardManager       // 键盘管理
│   ├── MJRefresh               // 刷新管理
│   ├── SDCycleScrollView       // 轮播图
│   ├── MBProgressHUD           // 加载loding
│   ├── YHTrackSDK-iOS          // 埋点封装
│   ├── YHDataSource            // tableView、collectionView代理封装
│   ├── MLeaksFinder            // 内存泄漏检查
│   ├── WHDebugTool             // fps、cpu占用显示辅助工具
│   ├── XHLaunchAd              // 启动广告配置
│   ├── LSSafeProtector         // 线上防崩溃容错处理
│   ├── Bugly                   // 线上崩溃采集
└── └── YHNetworkTools          // 网络库封装
```

#### 5 组件库说明
###### a、基础组件
组件名称|组件说明
:-|:-
YHAppColor|应用颜色配置
YHPermissionManager|常用权限获取
YHCacheManager|存储管理
YHConstant|常用宏定义
YHArchitecture.pch|全局头文件管理
YHUrlMacro|域名接口配置
YHPlatformIDsMacro|第三方平台账号
YHLaunchManager|开屏广告配置
YHTimeTool|c方式处理时间格式化
YHDeployInfo|部署配置

###### b、第三方框架
组件名称|组件说明
:-|:-
[AFNetworking][AFNetworking]|iOS网络库
[Masonry][Masonry]|layout布局框架
[SDWebImage][SDWebImage]|图片缓存
[IQKeyboardManager][IQKeyboardManager]|键盘处理
[MJRefresh][MJRefresh]|下拉刷新
[SDCycleScrollView][SDCycleScrollView]|轮播图
[MBProgressHUD][MBProgressHUD]|加载lodind
[XHLaunchAd][XHLaunchAd]|开屏广告
[WHDebugTool][WHDebugTool]|FPS工具
[MLeaksFinder][MLeaksFinder]|内存泄漏检测
[YHTrackSDK-iOS][YHTrackSDK-iOS]|永辉埋点封装
[YHNetworkTools][YHNetworkTools]|永辉网络封装库
[YHDataSource][YHDataSource]|tableView代理封装使用
[XHLaunchAd][XHLaunchAd]|启动广告处理
[LSSafeProtector][LSSafeProtector]|线上防崩溃容错处理
[Bugly][Bugly]|线上崩溃采集

#### 6 部分控件使用说明

###### a、YHPickerView 使用
```
YHPickerView *picker = [YHPickerView setPublicPickerView];
picker.title = @"标题名称";
picker.jsonModelPropertyName = @"showProperty";//显示的字段
[picker updateInfo:self list:dataList];
[picker setDidSelectBlockAtIndex:^(NSUInteger index,   id selectedData){
    //selectedData即为选中的条目
}];
```


###### b、YHMultisegmentView 使用

```
{//创建
    YHMultiSegmentView *segmentView = [YHMultiSegmentView initWithNib:@"OrderTitleView" owner:self];
    segmentView.delegate = self;
    segmentView.frame = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];;
    UIView *contentView = [[UIView new]];
    [contentView addSubview:segmentView];
}   

- (void)multiSegmentView:(YHMultiSegmentView*) segmentView didChangedIndex:(NSInteger)curIndex oldIndex:(NSInteger)oldIndex
{
    //处理代理事件
}
```
###### c、YHToast 使用
```
[YHToast showViewWithText:@"成功提示内容" imageType:YHToastImageTypeSuccess];
[YHToast showViewWithText:@"失败提示内容" imageType:YHToastImageTypeError];
```

#### 7 版本更新说明

###### V0.2.0更新说明
- 新增线上崩溃处理库LSSafeProtector、Bugly，并在AppDelegate增加bug采集逻辑
- 新增启动广告图处理库XHLaunchAd
- 新增放抓包逻辑处理（NSURLSession），优化模型解析逻辑
- 新增url管理、发包关键参数配置、第三方平台配置头文件
- 新增UIUserInterfaceStyle配置，禁用夜间模式
- 修改模态模式为UIModalPresentationFullScreen
- 优化引导轮播图，使用时请自定义跳过按钮位置
- 优化文件目录接口及基础组件，删除冗余代码及文件

###### V0.1.2更新说明

- 增加UITableView、UICollectionView代理封装以及空视图处理工具YHDataSource

###### V0.1.1更新说明

- 修改Readme文件
- 优化编码规范显示
- 添加debug工具和内存泄漏检测工具



[下载或更新]:https://developer.apple.com/download/
[cocoapod 配置]:https://www.cnblogs.com/chuancheng/p/8443677.html
[编码须知]:http://10.0.55.125/80727655/YHArchitecture-iOS/blob/master/YHArchitecture/编码需知.md
[AFNetworking]:https://github.com/AFNetworking/AFNetworking
[Masonry]:https://github.com/SnapKit/Masonry
[SDWebImage]:https://github.com/SDWebImage/SDWebImage
[IQKeyboardManager]:https://github.com/hackiftekhar/IQKeyboardManager
[MJRefresh]:https://github.com/CoderMJLee/MJRefresh
[SDCycleScrollView]:https://github.com/gsdios/SDCycleScrollView
[MBProgressHUD]:https://github.com/jdg/MBProgressHUD
[WHDebugTool]:https://github.com/remember17/WHDebugTool
[MLeaksFinder]:https://github.com/Tencent/MLeaksFinder
[YHTrackSDK-iOS]:http://gitlab.yonghui.cn/yangli/YHTrackSDK-iOS.git
[YHNetworkTools]:http://gitlab.yonghui.cn/yh-b2b/YHNetworkTools.git
[YHDataSource]:http://gitlab.yonghui.cn/YH-iOS/yhdatasource.git
[XHLaunchAd]:https://github.com/CoderZhuXH/XHLaunchAd.git
[LSSafeProtector]:https://github.com/lsmakethebest/LSSafeProtector.git
[Bugly]:https://bugly.qq.com/docs/
