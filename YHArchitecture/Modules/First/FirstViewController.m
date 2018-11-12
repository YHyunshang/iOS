//
//  FirstViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "FirstViewController.h"
#import "YHSXRequestControl.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
//    [YHSXRequestControl freshLoginWithUser:@"chaney"
//                                  password:@"afdd0b4ad2ec172c586e2150770fbf9e"
//                                    inView:self.view
//                                    handle:^(YHDataModel * _Nullable result,
//                                             YHUserModel * _Nullable userModel,
//                                             NSDictionary * _Nonnull requestParams,
//                                             NSString * _Nullable errMsg) {
//        if ([YHResultBase handleResult:result]) {
//            ;
//        }
//    }];
}


@end
