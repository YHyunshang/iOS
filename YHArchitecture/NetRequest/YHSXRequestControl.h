//
//  YHSXRequestControl.h
//  YHArchitecture
//
//  Created by Yangli on 2018/11/9.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <YHNetworkTools/YHNetworkTool.h>
#import "YHUserModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ YHBaseRequestBack)(YHDataModel * _Nullable result,id responseData, NSString* _Nullable errMsg);

@interface YHSXRequestControl : YHNetworkTool

+ (instancetype)sharedRequestControl;

+ (void)freshLoginWithUser:(NSString *)username
                  password:(NSString *)password
                    inView:(UIView *)view
                    handle:(void (^_Nullable)(YHDataModel * _Nullable result,YHUserModel *_Nullable userModel, NSDictionary *requestParams, NSString* _Nullable errMsg))handle;

@end

NS_ASSUME_NONNULL_END
