//
//  YLQRCodePreview.m
//  Supplier
//
//  Created by Yangli on 2020/6/8.
//  Copyright © 2020 永辉. All rights reserved.
//

#import "YLQRCodePreview.h"

@interface YLQRCodePreview ()

@property (nonatomic, strong) CAShapeLayer *rectLayer;
@property (nonatomic, strong) CAShapeLayer *cornerLayer;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CABasicAnimation *lineAnimation;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIButton *touchSwithButton;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation YLQRCodePreview

- (instancetype)initWithFrame:(CGRect)frame
{
    return [[YLQRCodePreview alloc] initWithFrame:frame rectFrame:CGRectZero rectColor:[UIColor clearColor] tip:@"将二维码/条形码放入框内即可自动扫描"];
}

- (instancetype)initWithFrame:(CGRect)frame rectColor:(UIColor *)rectColor tip:(nonnull NSString *)tip
{
    return [[YLQRCodePreview alloc] initWithFrame:frame rectFrame:CGRectZero rectColor:rectColor tip:tip];
}

- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame tip:(nonnull NSString *)tip
{
    return [[YLQRCodePreview alloc] initWithFrame:frame rectFrame:rectFrame rectColor:[UIColor clearColor] tip:tip];
}

- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame rectColor:(UIColor *)rectColor tip:(nonnull NSString *)tip
{
    self = [super initWithFrame:frame];
    
    if (self) {
        if (CGRectEqualToRect(rectFrame, CGRectZero)) {
            CGFloat rectSide = fminf(self.layer.bounds.size.width, self.layer.bounds.size.height) * 2 / 3;
            rectFrame = CGRectMake((self.layer.bounds.size.width - rectSide) / 2, (self.layer.bounds.size.height - rectSide) / 2, rectSide, rectSide);
        }
        if (CGColorEqualToColor(rectColor.CGColor, [UIColor clearColor].CGColor)) {
            rectColor = [UIColor whiteColor];
        }
        
        // 根据自定义的rectFrame画矩形框（扫码框）
        [self.layer masksToBounds];
        [self clipsToBounds];
        
        CGFloat lineWidth = .5;
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:(CGRect){lineWidth / 2, lineWidth / 2, rectFrame.size.width - lineWidth, rectFrame.size.height - lineWidth}];
        _rectLayer = [CAShapeLayer layer];
        _rectLayer.fillColor = [UIColor clearColor].CGColor;
        _rectLayer.strokeColor = rectColor.CGColor;
        _rectLayer.path = rectPath.CGPath;
        _rectLayer.lineWidth = lineWidth;
        _rectLayer.frame = rectFrame;
        [self.layer addSublayer:_rectLayer];
        
        // 根据rectFrame创建矩形拐角路径
        CGFloat cornerWidth = 2.0;
        CGFloat cornerLength = fminf(rectFrame.size.width, rectFrame.size.height) / 12;
        UIBezierPath *cornerPath = [UIBezierPath bezierPath];
        // 左上角
        [cornerPath moveToPoint:(CGPoint){cornerWidth / 2, .0}];
        [cornerPath addLineToPoint:(CGPoint){cornerWidth / 2, cornerLength}];
        [cornerPath moveToPoint:(CGPoint){.0, cornerWidth / 2}];
        [cornerPath addLineToPoint:(CGPoint){cornerLength, cornerWidth / 2}];
        // 右上角
        [cornerPath moveToPoint:(CGPoint){rectFrame.size.width, cornerWidth / 2}];
        [cornerPath addLineToPoint:(CGPoint){rectFrame.size.width - cornerLength, cornerWidth / 2}];
        [cornerPath moveToPoint:(CGPoint){rectFrame.size.width - cornerWidth / 2, .0}];
        [cornerPath addLineToPoint:(CGPoint){rectFrame.size.width - cornerWidth / 2, cornerLength}];
        // 右下角
        [cornerPath moveToPoint:(CGPoint){rectFrame.size.width - cornerWidth / 2, rectFrame.size.height}];
        [cornerPath addLineToPoint:(CGPoint){rectFrame.size.width - cornerWidth / 2, rectFrame.size.height - cornerLength}];
        [cornerPath moveToPoint:(CGPoint){rectFrame.size.width, rectFrame.size.height - cornerWidth / 2}];
        [cornerPath addLineToPoint:(CGPoint){rectFrame.size.width - cornerLength, rectFrame.size.height - cornerWidth / 2}];
        // 左下角
        [cornerPath moveToPoint:(CGPoint){.0, rectFrame.size.height - cornerWidth / 2}];
        [cornerPath addLineToPoint:(CGPoint){cornerLength, rectFrame.size.height - cornerWidth / 2}];
        [cornerPath moveToPoint:(CGPoint){cornerWidth / 2, rectFrame.size.height}];
        [cornerPath addLineToPoint:(CGPoint){cornerWidth / 2, rectFrame.size.height - cornerLength}];
        
        // 根据矩形拐角路径画矩形拐角
        _cornerLayer = [CAShapeLayer layer];
        _cornerLayer.frame = rectFrame;
        _cornerLayer.path = cornerPath.CGPath;
        _cornerLayer.lineWidth = cornerPath.lineWidth;
        _cornerLayer.strokeColor = rectColor.CGColor;
        [self.layer addSublayer:_cornerLayer];
        
        // 遮罩+镂空
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:self.bounds];
        UIBezierPath *subPath = [[UIBezierPath bezierPathWithRect:rectFrame] bezierPathByReversingPath];
        [maskPath appendPath:subPath];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor colorWithWhite:.0 alpha:.6].CGColor;
        maskLayer.path = maskPath.CGPath;
        [self.layer addSublayer:maskLayer];
        
        // 根据rectFrame画扫描线
        CGRect lineFrame = (CGRect){rectFrame.origin.x + 5.0, rectFrame.origin.y, rectFrame.size.width - 5.0 * 2, 1.5};
        UIBezierPath *linePath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){.0, .0, lineFrame.size.width, lineFrame.size.height}];
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.frame = lineFrame;
        _lineLayer.path = linePath.CGPath;
        _lineLayer.fillColor = rectColor.CGColor;
        _lineLayer.shadowColor = rectColor.CGColor;
        _lineLayer.shadowRadius = 5.0;
        _lineLayer.shadowOffset = CGSizeMake(.0, .0);
        _lineLayer.shadowOpacity = 1.0;
        _lineLayer.hidden = YES;
        [self.layer addSublayer:_lineLayer];
        
        // 扫描线动画
        _lineAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        _lineAnimation.fromValue = [NSValue valueWithCGPoint:(CGPoint){_lineLayer.frame.origin.x + _lineLayer.frame.size.width / 2, rectFrame.origin.y + _lineLayer.frame.size.height}];
        _lineAnimation.toValue = [NSValue valueWithCGPoint:(CGPoint){_lineLayer.frame.origin.x + _lineLayer.frame.size.width / 2, rectFrame.origin.y + rectFrame.size.height - _lineLayer.frame.size.height}];
        _lineAnimation.repeatCount = CGFLOAT_MAX;
        _lineAnimation.autoreverses = YES;
        _lineAnimation.duration = 2;
        
        // 手电筒开关
        _touchSwithButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _touchSwithButton.frame = CGRectMake(.0, .0, 60.0, 70.0);
        _touchSwithButton.center = CGPointMake(CGRectGetMidX(rectFrame), CGRectGetMaxY(rectFrame) - CGRectGetMidY(_touchSwithButton.bounds));
        _touchSwithButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_touchSwithButton setTitle:@"轻触照亮" forState:UIControlStateNormal];
        [_touchSwithButton setTitle:@"轻触关闭" forState:UIControlStateSelected];
        [_touchSwithButton setImage:[UIImage imageNamed:@"touch_switch_off"] forState:UIControlStateNormal];
        [_touchSwithButton setImage:[[UIImage imageNamed:@"touch_switch_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
        [_touchSwithButton addTarget:self action:@selector(touchSwitchClicked:) forControlEvents:UIControlEventTouchUpInside];
        _touchSwithButton.tintColor = rectColor;
        _touchSwithButton.titleEdgeInsets = UIEdgeInsetsMake(_touchSwithButton.imageView.frame.size.height + 5.0, -_touchSwithButton.imageView.bounds.size.width, .0, .0);
        _touchSwithButton.imageEdgeInsets = UIEdgeInsetsMake(.0, _touchSwithButton.titleLabel.bounds.size.width / 2, _touchSwithButton.titleLabel.frame.size.height + 5.0, - _touchSwithButton.titleLabel.bounds.size.width / 2);
        _touchSwithButton.hidden = YES;
        [self addSubview:_touchSwithButton];
        
        // 提示语label
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipsLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:.6];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.font = [UIFont systemFontOfSize:12.0];
        _tipsLabel.text = tip;
        _tipsLabel.numberOfLines = 0;
        [_tipsLabel sizeToFit];
        _tipsLabel.center = CGPointMake(CGRectGetMidX(rectFrame), CGRectGetMaxY(rectFrame) + CGRectGetMidY(_tipsLabel.bounds)+ 20.0);
        [self addSubview:_tipsLabel];
        
        // 等待指示view
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:rectFrame];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _indicatorView.hidesWhenStopped = YES;
        [self addSubview:_indicatorView];
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}


#pragma mark - Public functions

- (void)setTip:(NSString *)detail
{
    self.tipsLabel.text = detail;
}

- (CGRect)rectFrame
{
    return _rectLayer.frame;
}

- (void)startScanning
{
    _lineLayer.hidden = NO;
    [_lineLayer addAnimation:_lineAnimation forKey:@"lineAnimation"];
}

- (void)stopScanning
{
    _lineLayer.hidden = YES;
    [_lineLayer removeAnimationForKey:@"lineAnimation"];
}

- (void)startIndicating
{
    [_indicatorView stopAnimating];
}

- (void)stopIndicating
{
    [_indicatorView stopAnimating];
}

- (void)showTorchSwitch
{
    _touchSwithButton.hidden = NO;
    _touchSwithButton.alpha = .0;
    [UIView animateWithDuration:0.01 animations:^{
        self.touchSwithButton.alpha = 1.0;
    }];
}

- (void)hideTorchSwitch
{
    [UIView animateWithDuration:0.01 animations:^{
        self.touchSwithButton.alpha = .0;
    } completion:^(BOOL finished) {
        self.touchSwithButton.hidden = YES;
    }];
}


#pragma mark - Private functions

- (void)didAddSubview:(UIView *)subview
{
    if (subview == _indicatorView) {
        [_indicatorView startAnimating];
    }
}


#pragma mark - Action functions

- (void)touchSwitchClicked:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(codeScanningView:didClickedTouchSwitch:)]) {
        [self.delegate codeScanningView:self didClickedTouchSwitch:button];
    }
}

@end
