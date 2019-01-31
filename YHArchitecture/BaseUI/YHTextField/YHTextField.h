//
//  YHTextField.h
//  YHArchitecture
//
//  Created by Yangli on 2019/1/16.
//  Copyright © 2019年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^YHTextFieldBlock)(UITextField *textField);

NS_ASSUME_NONNULL_BEGIN

@interface YHTextField : UITextField

/**
 textfield 事件回调封装

 @param block <#block description#>
 @param controlEvents 事件类型
 */
- (void)addAction:(YHTextFieldBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
