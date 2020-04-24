//
//  SecondViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "SecondViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface SecondViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"数据服务";
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.mainTableView.emptyDataSetSource = self;
    self.mainTableView.emptyDataSetDelegate = self;
}

#pragma mark ============================    tableView    ============================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

#pragma mark ============================    DZNEmptyDataSetDelegate    ============================
/**
*  空白区域点击事件
*/
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    
}

//点击按钮或图片事件处理
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    YHLog(@"需要刷新了");
}

#pragma mark ============================    DZNEmptyDataSetSource    ============================

/**
*  返回文字详情
*/
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"这只一段短描述";
    NSMutableAttributedString *attribuString = [[NSMutableAttributedString alloc]initWithString:text attributes:nil];
    [attribuString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:[attribuString.string rangeOfString:@"哈哈哈"]];
    return attribuString;
}

/**
*  返回图片按钮
*/
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"placeholder_image"];
}

/**
*  调整垂直位置
*/
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64.f;
}

@end
