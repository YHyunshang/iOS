//
//  YHButton.h
//  YHArchitecture
//
//  Created by Yangli on 2019/1/16.
//  Copyright © 2019年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YHButtonImagePosition) {
    YHButtonImagePositionLeft = 0,
    YHButtonImagePositionRight,
    YHButtonImagePositionTop,
    YHButtonImagePositionBottom
};

typedef void(^YHButtonBlock)(UIButton *button);

NS_ASSUME_NONNULL_BEGIN

@interface YHButton : UIButton

/**
 按钮UIControlEventTouchUpInside事件block回调

 @param block <#block description#>
 */
- (void)addAction:(YHButtonBlock)block;

/**
 按钮事件回调block

 @param block <#block description#>
 @param controlEvents 系统事件类型
 */
- (void)addAction:(YHButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

/**
 按钮图文布局，以及图文距离控制

 @param postion 布局样式
 @param spacing 图文间距
 */
- (void)setImagePosition:(YHButtonImagePosition)postion spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
