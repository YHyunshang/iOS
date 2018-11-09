//
//  YHPickerView.h
//  YHArchitecture
//
//  Created by Yangli on 2018/11/9.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHPickerViewDelegate <NSObject>

@optional
- (void)getPickerInfo:(id)info infoID:(NSString*)infoID;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YHPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(strong,nonatomic) NSString *title;
@property (copy, nonatomic) void (^didSelectBlockAtIndex)(NSUInteger index,id selectobj);
/** 如果list是 jsonModel，设置显示它的那个属性的名字//如果list是dictnory 此处 设置为要显示的key的名字 */
@property(strong,nonatomic) NSString *jsonModelPropertyName;//
/** 背部的遮盖按钮 */
@property (nonatomic, strong) UIButton *maxCoverBtn;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (void)coverClick;
+ (instancetype)setPublicPickerView;
- (void)updateInfo:(UIViewController*)parentCtrl list:(NSArray*)list;

@end

NS_ASSUME_NONNULL_END
