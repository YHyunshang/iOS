//
//  YHTextField.m
//  YHArchitecture
//
//  Created by Yangli on 2019/1/16.
//  Copyright © 2019年 永辉. All rights reserved.
//

#import "YHTextField.h"
#import <objc/runtime.h>

@implementation YHTextField

static char YHActionTag;

/**
 textfield 事件回调封装
 
 @param block <#block description#>
 @param controlEvents 事件类型
 */
- (void)addAction:(YHTextFieldBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, &YHActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

- (void)action:(id)sender
{
    YHTextFieldBlock blockAction = (YHTextFieldBlock)objc_getAssociatedObject(self, &YHActionTag);
    if (blockAction){
        blockAction(self);
    }
}

@end
