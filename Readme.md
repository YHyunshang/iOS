#### 永辉iOS项目说明文档
    

##### 运行环境
* Xcode9.0+
* 电脑配置cocoapod(注：未配置可参考：[cocoapod 配置](https://www.cnblogs.com/chuancheng/p/8443677.html))

##### 目录结构描述

```
├── Readme.md                   // help
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
│   └── YHMainViewController    // 项目基础框架
├── Modules                     // 模块
│   ├── YHSplashViewController  // 项目指引
│   │   ├── YHSplashViewController     // 环境切换配置
│   │   └── YHUserGuideViewController  // 产品说明轮播图
文档
... ...  ...
├── Podfile                     // 第三方依赖库
│   ├── AFNetworking            // 网络库
│   ├── Masonry                 // 布局库
│   ├── SDWebImage              // 图片缓存
│   ├── IQKeyboardManager       // 键盘管理
│   ├── MJRefresh               // 刷新管理
│   ├── SDCycleScrollView       // 轮播图
│   ├── MBProgressHUD           // 加载loding
│   ├── YHTrackSDK-iOS          // 埋点封装
    └── YHNetworkTools          // 网络库封装
```
##### 部分控件使用说明
###### YHPickerView 使用
```
    YHPickerView *picker = [YHPickerView setPublicPickerView];
    picker.title = @"标题名称";
    picker.jsonModelPropertyName = @"showProperty";//显示的字段
    [picker updateInfo:self list:dataList];
    [picker setDidSelectBlockAtIndex:^(NSUInteger index,   id selectedData){
       //selectedData即为选中的条目
    }];
```

###### YHMultisegmentView 使用
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

###### YHToast 使用
```
    [YHToast showViewWithText:@"成功提示内容" imageType:YHToastImageTypeSuccess];
    [YHToast showViewWithText:@"失败提示内容" imageType:YHToastImageTypeError];
```

##### 版本更新说明

###### V0.1.0更新说明
1. 约束项目目录结构；
2. 约束常用第三方库；
3. 配置常用宏、pch；
4. 制定代码规范。
