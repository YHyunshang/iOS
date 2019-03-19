#### 永辉iOS项目说明文档
[TOC]   
##### 开发语言
>Objective-C为主
>Swift、Objective-C混合开发(部分项目)
##### 运行环境
###### 1、编译工具
>Xcode9.0+,[下载或更新](https://developer.apple.com/download/)
###### 2、包管理工具
>电脑配置cocoapod(注：未配置可参考：[cocoapod 配置](https://www.cnblogs.com/chuancheng/p/8443677.html))
##### 使用说明
###### 1、[编码须知](http://10.0.55.125/80727655/YHArchitecture-iOS/blob/master/YHArchitecture/编码需知.md)
###### 2、初始化项目
>1、cd到项目目录 
>2、执行命令 ： pod install

##### 框架及目录结构
###### 1、说明
> 根据项目实际需要、人员配置及维护成本选择MVC、MVP、MVVM等开发模式
###### 2、目录结构
>├── Readme.md                   // help
├── 编码须知.txt                 // 编码规范             
├── config                      // 项目配置文件
│   ├── YHAppColor              // 应用颜色配置
│   ├── YHPermissionManager     // 常用权限获取
│   ├── YHCacheManager          // 存储管理
│   ├── YHConstant              // 常用宏定义
│   └── YHArchitecture.pch      // 全局头文件管理
├── Resource                    // 资源库配置
│   ├── YHTrack_Data            // 永辉埋点配置文件
│   └── Assets                  // 项目图片管理
├── NetRequest                  // 请求类
├── Library                     // 非pod第三方库
├── Extension                   // 自定义扩展类
├── BaseUI                      // UI控件基类
│   ├── YHPickerView            // 单选picker封装
│   ├── YHWebView               // webview 封装
│   ├── YHMultisegmentView      // 订单列表头部封装
│   ├── YHToast                 // 基本提示封装
│   ├── YHTextField             // TextField封装
│   ├── YHButton                // Button封装
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
└── └── YHNetworkTools          // 网络库封装

##### 组件库说明
###### 1、基础组件
组件名称|组件说明
:-:|:-:
YHAppColor|应用颜色配置
YHPermissionManager|常用权限获取
YHCacheManager|存储管理
YHConstant|常用宏定义
YHArchitecture.pch|全局头文件管理

###### 2、第三方框架
组件名称|组件说明
:-:|:-:
[AFNetworking](https://github.com/AFNetworking/AFNetworking)|iOS网络库
[Masonry](https://github.com/SnapKit/Masonry)|layout布局框架
[SDWebImage](https://github.com/SDWebImage/SDWebImage)|图片缓存
[IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)|键盘处理
[MJRefresh](https://github.com/CoderMJLee/MJRefresh)|下拉刷新
[SDCycleScrollView](https://github.com/gsdios/SDCycleScrollView)|轮播图
[MBProgressHUD](https://github.com/jdg/MBProgressHUD)|加载lodind
[QMUIKit](https://github.com/Tencent/QMFI_iOS)|腾讯UI库
[WHDebugTool](WHDebugTool)|FPS工具
[MLeaksFinder](https://github.com/Tencent/MLeaksFinder)|内存泄漏检测
[YHTrackSDK-iOS](http://10.0.71.125/yangli/YHTrackSDK-iOS.git)|永辉埋点封装
[YHNetworkTools](http://10.0.71.125/yh-b2b/YHNetworkTools.git)|永辉网络封装库

##### 部分控件使用说明


###### 1、YHPickerView 使用
>YHPickerView *picker = [YHPickerView setPublicPickerView];
>picker.title = @"标题名称";
>picker.jsonModelPropertyName = @"showProperty";//显示的字段
>[picker updateInfo:self list:dataList];
>[picker setDidSelectBlockAtIndex:^(NSUInteger index,   id selectedData){
//selectedData即为选中的条目
}];


###### 2、YHMultisegmentView 使用

>{//创建
YHMultiSegmentView *segmentView = [YHMultiSegmentView initWithNib:@"OrderTitleView" owner:self];
segmentView.delegate = self;
segmentView.frame = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];;
UIView *contentView = [[UIView new]];
>[contentView addSubview:segmentView];
}   
>       - (void)multiSegmentView:(YHMultiSegmentView*) segmentView didChangedIndex:(NSInteger)curIndex oldIndex:(NSInteger)oldIndex
{
//处理代理事件
}
###### 3、YHToast 使用
>[YHToast showViewWithText:@"成功提示内容" imageType:YHToastImageTypeSuccess];
>[YHToast showViewWithText:@"失败提示内容" imageType:YHToastImageTypeError];

##### 版本更新说明

###### V0.1.1更新说明

\* 修改Readme文件
\* 优化编码规范显示
\* 添加debug工具和内存泄漏检测工具
