//
//  YHBaseViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHBaseViewController.h"
#import "YHEmptyViewController.h"

@interface YHBaseViewController ()

@end

@implementation YHBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[YHBaseTableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
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

- (UIView *)baseNothingV
{
    if (!_baseNothingV) {
        _baseNothingV = [UIView new];
    }
    return _baseNothingV;
}

- (UILabel *)baseNothingTitleLb
{
    if (!_baseNothingTitleLb) {
        _baseNothingTitleLb = [[UILabel alloc]init];
        _baseNothingTitleLb.font = [UIFont systemFontOfSize:13];
        _baseNothingTitleLb.textAlignment = NSTextAlignmentCenter;
        _baseNothingTitleLb.textColor = YHHexColor(@"4A4A4A");
        _baseNothingTitleLb.font = [UIFont systemFontOfSize:16];
        _baseNothingTitleLb.textAlignment = NSTextAlignmentCenter;
        _baseNothingTitleLb.numberOfLines = 1;
        [_baseNothingTitleLb sizeToFit];
    }
    return _baseNothingTitleLb;
}

- (YHButton *)baseGotoBtn
{
    if (!_baseGotoBtn) {
        _baseGotoBtn = [YHButton buttonWithType:UIButtonTypeSystem];
        _baseGotoBtn.backgroundColor = YHHexColor(@"#41B25D");
        _baseGotoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _baseGotoBtn.layer.cornerRadius = 17.5;
        _baseGotoBtn.hidden = YES;
    }
    return _baseGotoBtn;
}

- (void)createNothingView
{
    [self createNothingViewOnView:self.view imageName:@""];
}

- (void)createNothingViewOnView:(UIView *)view imageName:(NSString *)imageName
{
    //添加视图
    [view addSubview:self.baseNothingV];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:YHImage(imageName)];
    [self.baseNothingV addSubview:imageView];
    [self.baseNothingV addSubview:self.baseNothingTitleLb];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"看看其他的吧";
    label.textColor = YHHexColor(@"A4A4B4");
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
    [label sizeToFit];
    [self.baseNothingV addSubview:label];
    [self.baseNothingV addSubview:self.baseGotoBtn];
    
    //布局
    [self.baseNothingV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190, 190));
        make.centerX.mas_equalTo(self.baseNothingV.mas_centerX);
        make.centerY.mas_equalTo(self.baseNothingV.mas_centerY).offset(-170);
    }];
    [self.baseNothingV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom);
        make.centerX.mas_equalTo(self.baseNothingV.mas_centerX);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baseNothingTitleLb.mas_bottom).mas_offset(16);
        make.centerX.mas_equalTo(self.baseNothingV.mas_centerX);
    }];
    [self.baseGotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 35));
        make.top.mas_equalTo(label.mas_bottom).mas_offset(13);
        make.centerX.mas_equalTo(0);
    }];
    
    //设置隐藏
    self.baseNothingV.hidden = YES;
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

+ (void)gotoEmptyControllerWithTitle:(NSString*)title
{
    [YHToast showViewWithText:@"即将上线 敬请期待！" imageType:YHToastImageTypeError];
}



@end
