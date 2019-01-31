//
//  FirstViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "FirstViewController.h"
#import "YHSXRequestControl.h"
#import "YHButton.h"

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
    
    YHButton *button = [[YHButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    [self.view addSubview:button];
    [button setTitle:@"hello" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setImagePosition:0 spacing:5];
    [button addAction:^(UIButton *button) {
        NSLog(@"点击了hello按钮");
    }];
}


@end
