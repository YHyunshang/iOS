//
//  YHSXRequestControl.m
//  YHArchitecture
//
//  Created by Yangli on 2018/11/9.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHSXRequestControl.h"
#import "YHSXNetworkConfig.h"
#import "MBProgressHUD.h"

@implementation YHSXRequestControl

+ (instancetype)sharedRequestControl
{
    YHSXNetworkConfig *config = [YHSXNetworkConfig sharedConfiguration];
    YHSXRequestControl *control = [[YHSXRequestControl alloc] initWithConfiguration:config];
    return control;
}

+ (void)freshLoginWithUser:(NSString *)username
                  password:(NSString *)password
                    inView:(UIView *)view
                    handle:(void (^_Nullable)(YHDataModel * _Nullable result,
                                              YHUserModel *_Nullable userModel,
                                              NSDictionary *requestParams,
                                              NSString* _Nullable errMsg))handle
{
    YHSXRequestControl *request = [YHSXRequestControl sharedRequestControl];
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    [request POST:@"http://freshserver.dev.ys.yh-test.com/pub/fresh/user/login" inView:view parameters:@{@"username":username,@"password":password} requestBack:^(BOOL requestSuccess, id  _Nullable response, NSString * _Nullable responseJson, NSDictionary * _Nullable requestDic, NSString * _Nullable errorMessage) {
        if (requestSuccess) {
            YHUserModel *userModel = [[YHUserModel alloc]initWithDictionary:response responseClass:[YHUserModel class]];
            NSLog(@"%@",userModel);
            handle(userModel,userModel.yhresponse,requestDic,nil);
        }else{
            handle(nil,nil,requestDic,errorMessage);
        }
    }];
}

@end
