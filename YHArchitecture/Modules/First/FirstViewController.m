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
#import "YHMultiSegmentView.h"
#import "YHDataModel.h"

@interface FirstViewController ()<YHMultiSegmentViewDelegate>
/** <#Description#> */
@property (nonatomic, strong) YHMultiSegmentView *multiSementView;
@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self configureUI];
//    [YHSXRequestControl freshLoginWithUser:@"chaney"
//                                  password:@"afdd0b4ad2ec172c586e2150770fbf9e"
//                                    inView:self.view
//                                    handle:^(YHDataModel * _Nullable result,
//                                             YHUserModel * _Nullable userModel,
//                                             NSDictionary * _Nonnull requestParams,
//                                             NSString * _Nullable errMsg) {
//        if ([YHDataModel handleResult:result]) {
//            ;
//        }
//    }];
        
}

- (void)configureUI
{
    YHMultiSegmentView *segmentView = [YHMultiSegmentView initWithNib:@"YHMultiSegmentView" owner:self];
    self.multiSementView = segmentView;
    self.multiSementView.delegate = self;
    UIView *headView = [UIView new];

    [headView addSubview:segmentView];
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(headView);
    }];
    
    [segmentView setSelectedSegmentIndex:0 animated:YES];
}

- (void)multiSegmentView:(YHMultiSegmentView*)segmentView didChangedIndex:(NSInteger)curIndex oldIndex:(NSInteger)oldIndex
{
    YHLog(@"当前index == %ld",(long)curIndex);
}

@end
