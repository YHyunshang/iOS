//
//  YHMultiSegmentView.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/30.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHMultiSegmentView.h"
#import "UIColor+Utilities.h"


@implementation YHMultiSegmentView

+ (instancetype)initWithNib:(NSString*)nibName owner:(id)owner
{
    YHMultiSegmentView *view =  (YHMultiSegmentView*)[[[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil] objectAtIndex:0];
    return view;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    for (int i=0; i<self.btns.count; ++i) {
        UIButton *btn = self.btns[i];
        btn.tag = i;
        [btn addTarget:self action:@selector(segmentBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateSelected];
    }
    
    if (!self.indicatorImageView.image) {
        self.indicatorImageView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }
}

- (void)setSelectedSegmentIndex:(NSInteger)index animated:(BOOL)animated
{
    for (int i=0; i<self.btns.count; ++i) {
        UIButton *btn = self.btns[i];
        btn.selected = (i==index);
    }
    
    if (_selectedSegmentIndex!=index) {
        _selectedSegmentIndex = index;
        UIButton *selectedBtn = self.btns[index];
        if (self.nonuseAutolayout) {
            if (index==0) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.indicatorImageView.center = CGPointMake(selectedBtn.center.x, self.indicatorImageView.center.y);
                }];
            }else{
                [UIView animateWithDuration:0.2 animations:^{
                    self.indicatorImageView.center = CGPointMake(selectedBtn.center.x, self.indicatorImageView.center.y);
                }];
            }
        }else{
            [self removeConstraint:_centerXCons];
            if (index==0) {
                NSLayoutConstraint *constrCenterX = [NSLayoutConstraint constraintWithItem:_indicatorImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:selectedBtn attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
                [self addConstraint:constrCenterX];
                _centerXCons = constrCenterX;
            }else{
                NSLayoutConstraint *constrCenterX = [NSLayoutConstraint constraintWithItem:_indicatorImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:selectedBtn attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
                [self addConstraint:constrCenterX];
                _centerXCons = constrCenterX;
            }
            
            if (animated) {
                [UIView animateWithDuration:0.2 animations:^{
                    [self layoutIfNeeded];
                }];
            }else{
                [self layoutIfNeeded];
            }
        }
    }
}

- (void)setBtnTitles:(NSArray *)btnTitles
{
    if (btnTitles) {
        _btnTitles = btnTitles;
        for (NSInteger i = 0; i < self.btns.count; i++) {
            UIButton *btn = self.btns[i];
            [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectColor:(UIColor *)selectColor
{
    _selectColor = selectColor;
    for (int i=0; i<self.btns.count; ++i) {
        UIButton *btn = self.btns[i];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitleColor:self.selectColor ?self.selectColor : [UIColor blackColor] forState:UIControlStateSelected];
    }
}

- (void)setSelectedSegmentIndex:(NSInteger) index
{
    [self setSelectedSegmentIndex:index animated:YES];
}

- (void)segmentBtnClick:(UIButton*)btn
{
    NSInteger index = btn.tag;
    if (index!=self.selectedSegmentIndex) {
        NSInteger oldIndex = self.selectedSegmentIndex;
        self.selectedSegmentIndex = index;
        if (self.delegate && [self.delegate respondsToSelector:@selector(multiSegmentView:didChangedIndex:oldIndex:)]) {
            [self.delegate multiSegmentView:self didChangedIndex:index oldIndex:oldIndex];
        }
    }
}

@end
