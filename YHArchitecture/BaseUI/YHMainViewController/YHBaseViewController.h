//
//  YHBaseViewController.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBaseTableView.h"
#import "YHButton.h"


NS_ASSUME_NONNULL_BEGIN

@interface YHBaseViewController : UIViewController
@property (strong,nonatomic) YHBaseTableView *mainTableView;
@property (strong, nonatomic) UIView *baseNothingV;
@property (strong, nonatomic) UILabel *baseNothingTitleLb;
/** 跳转btn */
@property (nonatomic, strong) YHButton *baseGotoBtn;

//创建内容为空页面
- (void)createNothingView;

- (void)createNothingViewOnView:(UIView *)view imageName:(NSString *)imageName;

/**
 *  是否全屏布局
 *
 *  @param full 是否全屏
 */
- (void)fullScreen:(BOOL)full;

- (NSInvocation *)callClassName:(NSString *)className staticMethodSelector:(SEL)aSelector params:(void*_Nonnull[_Nullable])params paramsSize:(int)size;

//显示dataCenter图片的nav标题
- (void)showDataCenterNavTitle;

/**去空控制器*/
+ (void)gotoEmptyControllerWithTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
