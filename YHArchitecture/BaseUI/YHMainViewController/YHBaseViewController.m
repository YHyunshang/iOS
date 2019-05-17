//
//  YHBaseViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHBaseViewController.h"
#import "YHEmptyViewController.h"
#define NoContentViewTag 0x010101010101

@interface YHBaseViewController ()

@end

@implementation YHBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        [self.view addSubview:_mainTableView];
        _mainTableView.sectionHeaderHeight = 0.01;
        _mainTableView.sectionFooterHeight = 0.01;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.separatorColor = [UIColor clearColor];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _mainTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 0.01)];
        _mainTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 0.01)];
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        _mainTableView.delegate = (id<UITableViewDelegate>)self;
        _mainTableView.dataSource = (id<UITableViewDataSource>)self;

    }
    return _mainTableView;
}


- (void)createNothingView
{
    [self createNothingViewOnView:self.view];
}

- (void)createNothingViewOnView:(UIView *)view
{
    _nothingView = [[UIView alloc]init];
    [view addSubview:_nothingView];
    [_nothingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [_nothingView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(75);
        make.centerX.mas_equalTo(self.nothingView.mas_centerX);
        make.centerY.mas_equalTo(self.nothingView.mas_centerY).offset(-70);
    }];
    
    _nothingTitleLabel = [[UILabel alloc]init];
    [_nothingView addSubview:_nothingTitleLabel];
    [_nothingTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self.nothingView.mas_centerX);
        make.centerY.mas_equalTo(self.nothingView.mas_centerY).offset(12);
    }];
    
    _nothingTitleLabel.font = [UIFont systemFontOfSize:13];
    _nothingTitleLabel.textAlignment = NSTextAlignmentCenter;
    _nothingView.hidden = YES;
}


- (void)fullScreen:(BOOL)full
{
    if (full) {
        self.edgesForExtendedLayout =  UIRectEdgeAll;
        self.extendedLayoutIncludesOpaqueBars = YES;
    } else {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
}

- (NSInvocation *)callClassName:(NSString *)className staticMethodSelector:(SEL)aSelector params:(void*[])params paramsSize:(int)size
{
    Class cellClass = NSClassFromString(className);
    SEL selector = aSelector;
    
    NSMethodSignature *sig = [cellClass methodSignatureForSelector:selector];
    //根据方法签名创建一个NSInvocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    //设置调用者也就是AsynInvoked的实例对象，在这里我用self替代
    [invocation setTarget:cellClass];
    //设置被调用的消息
    [invocation setSelector:selector];
    
    //如果此消息有参数需要传入，那么就需要按照如下方法进行参数设置，需要注意的是，atIndex的下标必须从2开始。原因为：0 1 两个参数已经被target 和selector占用
    for (int i = 0; i < size; i++) {
        [invocation setArgument:params[i] atIndex:2+i];
    }
    
    //消息调用
    [invocation invoke];
    return invocation;
}

- (void)showDataCenterNavTitle
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yonghuidatacenter"]];
    self.navigationItem.titleView = imageView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/**
 *  显示或隐藏没有数据提示view
 */
- (void)showOrHideNoContentView:(BOOL)show
{
    UIView *view = [self.view viewWithTag:NoContentViewTag];
    if (show) {
        if (view) {
            [self.view bringSubviewToFront:view];
            view.hidden = NO;
        } else {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
            label.text = @"数据为空~";
            label.textColor = [UIColor darkGrayColor];
            label.center = CGPointMake(self.view.center.x, 100);
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = NoContentViewTag;
            [self.view addSubview:label];
        }
    } else {
        if (view) {
            view.hidden = YES;
        }
    }
}

/** 显示火隐藏没有数据提示的view */
+ (void)ifShowEnptyView:(BOOL)show inView:(UIView*)view
{
    if (show) {
        UIView *emptyView = [view viewWithTag:12345678910];
        if (!emptyView) {
            YHEmptyViewController *emptyVc = [[YHEmptyViewController alloc] init];
            emptyVc.view.tag = 12345678910;
            emptyVc.view.frame = view.frame;
            [view addSubview:emptyVc.view];
        }
    }else{
        UIView *emptyView = [view viewWithTag:12345678910];
        if (emptyView) {
            [emptyView removeFromSuperview];
        }
    }
}

+ (void)gotoEmptyControllerWithTitle:(NSString*)title
{
    [YHToast showViewWithText:@"即将上线 敬请期待！" imageType:YHToastImageTypeError];
}



@end
