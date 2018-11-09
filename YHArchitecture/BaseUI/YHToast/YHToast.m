//
//  YHToast.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHToast.h"
#define TEXT_FONT [UIFont systemFontOfSize:13]

@interface YHToast ()
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) YHToastImageType imageType;
@property (assign, nonatomic) NSTimeInterval hideDelay;
@property (strong, nonatomic) UIView *promptView;
@property (strong, nonatomic) UIImageView *tipImageView;
@property (strong, nonatomic) UILabel *textLabel;

@end

@implementation YHToast

- (CGSize)textSizeString:(NSString *)text font:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if (text && font) {
        size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    return size;
}

- (CGSize)labelSizeForText:(NSString *)text font:(UIFont *)font
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, 100) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size;
    return size;
}

+ (void)showViewWithText:(NSString *)text imageType:(YHToastImageType)imageType hideDelay:(NSTimeInterval)hideDelay
{
    YHToast *bView = [[YHToast alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bView.text = text;
    bView.imageType = imageType;
    bView.hideDelay = hideDelay;
    [bView updateView];
    [[UIApplication sharedApplication].keyWindow addSubview:bView];
}

+ (void)showViewWithText:(NSString *)text imageType:(YHToastImageType)imageType
{
    BOOL isEqual = [YHToast isEqualToNil:text];
    if (isEqual == YES) {
        text = @"服务器错误";
    }
    
    [self showViewWithText:text imageType:imageType hideDelay:2.0];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSelf];
    }
    return self;
}

- (void)createSelf {
    CGFloat width = 150;
    _promptView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 50)];
    [self addSubview:_promptView];

    _promptView.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:0.95];
    YHViewCornerRadius(_promptView, 2.5);
    
    _tipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12.5, 25, 25)];
    [_promptView addSubview:_tipImageView];
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 15, width - 50, 20)];
    _textLabel.numberOfLines = 0;
    [_promptView addSubview:_textLabel];
    
    _textLabel.textColor = YHRGB(204, 204, 204, 1.0);
    _textLabel.font = TEXT_FONT;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)updateView {
    CGSize size = [self labelSizeForText:_text font:TEXT_FONT];
    if (size.width > 150 - 60) {
        CGRect frame = _promptView.frame;
        if (size.width + 60 < SCREEN_WIDTH - 40) {
            frame.size.width = size.width + 60;
        }else {
            frame.size.width = SCREEN_WIDTH - 40;
        }
        if (size.height > 50 - 30) {
            frame.size.height = size.height + 30;
        }
        _promptView.frame = frame;
        
        CGRect LabelFrame = _textLabel.frame;
        LabelFrame.size.width = frame.size.width - 50;
        LabelFrame.size.height = size.height;
        _textLabel.frame = LabelFrame;
    }
    
    _promptView.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    NSString *image = @"tip_error";
    if (_imageType == YHToastImageTypeSuccess) {
        image = @"tip_success";
    }
    _tipImageView.image = YHImage(image);
    _textLabel.text = _text;
    [self performSelector:@selector(removeSelf) withObject:nil afterDelay:_hideDelay];
}

- (void)removeSelf
{
    [UIView animateWithDuration:0.15 animations:^{
        self.promptView.alpha = 0.0f;
        [self performSelector:@selector(removeSelfs) withObject:nil afterDelay:0.15];
    }];
    
}

- (void)removeSelfs
{
    [self removeFromSuperview];
}

+ (BOOL)isEqualToNil:(NSString *)str {
    return str.length <= 0 || [str isEqualToString:@""] || !str||[str isEqualToString:@" "];
}

@end
