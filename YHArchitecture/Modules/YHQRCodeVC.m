//
//  YHQRCodeVC.m
//  YHArchitecture
//
//  Created by Yangli on 2020/7/22.
//  Copyright © 2020 永辉. All rights reserved.
//

#import "YHQRCodeVC.h"
#import "YLQRCodeObtain.h"
#import "YLQRCodePreview.h"

@interface YHQRCodeVC ()

/** preview */
@property (nonatomic, strong) YLQRCodePreview *preview;
/** Description */
@property (nonatomic, strong) YLQRCodeObtain *codeObtain;

@end

@implementation YHQRCodeVC

- (YLQRCodePreview *)preview
{
    if (!_preview) {
        _preview = [[YLQRCodePreview alloc] initWithFrame:self.view.bounds rectFrame:CGRectMake(56, iPhoneX_AreaH + 56, SCREEN_WIDTH - 112, SCREEN_WIDTH - 112) rectColor:RGBA(0, 170, 255, 1) tip:@"将二维码/条形码放入框内即可自动扫描"];
        _preview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    return _preview;
}

- (YLQRCodeObtain *)codeObtain
{
    if (!_codeObtain) {
        _codeObtain = [[YLQRCodeObtain alloc] initWithPreviewView:self.preview completion:^{
        }];
    }
    return _codeObtain;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configPreview];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.preview startScanning];
        [self startScanning];
    });
    
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"%s", __func__);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.codeObtain stopScanning];
        [self.preview stopScanning];
    });
}

- (void)configPreview
{
    [self.view addSubview:self.preview];
    NSLog(@"%@",self.codeObtain);
}

- (void)startScanning
{
    YHWeakSelf(self);
    [self.codeObtain startScanningWithCallback:^(NSString *result) {
        if (weakself.scanResultBlock) {
            weakself.scanResultBlock(result);
        }
        [weakself dealWithScanResult:result];
    } autoStop:YES];
}

- (void)dealWithScanResult:(NSString *)result
{
    
}

@end
