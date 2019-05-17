//
//  YHMultiSegmentView.h
//  YHArchitecture
//
//  Created by Yangli on 2018/10/30.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Size.h"

NS_ASSUME_NONNULL_BEGIN

@class YHMultiSegmentView;

@protocol YHMultiSegmentViewDelegate <NSObject>

@optional

- (void)multiSegmentView:(YHMultiSegmentView*) segmentView didChangedIndex:(NSInteger)curIndex oldIndex:(NSInteger)oldIndex;

@end

@interface YHMultiSegmentView : UIView

//outlets
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerXCons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorImageView;

/** 选中文字颜色 */
@property (nonatomic, strong) UIColor *selectColor;

@property (weak, nonatomic) id<YHMultiSegmentViewDelegate> delegate;
/** 是否不使用autolayout */
@property (assign, nonatomic) BOOL nonuseAutolayout;
/** 当前选择index */
@property (assign, nonatomic) NSInteger selectedSegmentIndex;
/** 按钮标题 */
@property (nonatomic, strong) NSArray *btnTitles;

- (void)setSelectedSegmentIndex:(NSInteger)index animated:(BOOL)animated;
- (void)segmentBtnClick:(UIButton*)btn;
+ (instancetype)initWithNib:(NSString*)nibName owner:(id)owner;

@end

NS_ASSUME_NONNULL_END
