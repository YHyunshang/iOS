//
//  YHBaseViewController.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHBaseViewController : UIViewController
@property (strong,nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) UIView *nothingView;
@property (strong, nonatomic) UILabel *nothingTitleLabel;


//创建列表为空页面
- (void)createNothingView;

- (void)createNothingViewOnView:(UIView *)view;

/**
 *  是否全屏布局
 *
 *  @param full 是否全屏
 */
- (void)fullScreen:(BOOL)full;

- (NSInvocation *)callClassName:(NSString *)className staticMethodSelector:(SEL)aSelector params:(void*_Nonnull[])params paramsSize:(int)size;

//显示dataCenter图片的nav标题
- (void)showDataCenterNavTitle;

/**
 *  显示或隐藏没有数据提示view
 */
- (void)showOrHideNoContentView:(BOOL)show;

/**展示空的view*/
+ (void)ifShowEnptyView:(BOOL)show inView:(UIView*)view;

/**去空控制器*/
+ (void)gotoEmptyControllerWithTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
