//
//  YHPickerView.m
//  YHArchitecture
//
//  Created by Yangli on 2018/11/9.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHPickerView.h"
#import <objc/runtime.h>

@implementation YHPickerView{
    UIViewController *parent;
    NSArray *dataList;
    NSMutableArray *dataStringList;
    id infoStr;
}

+ (instancetype)setPublicPickerView
{
    YHPickerView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    return view;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _maxCoverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxCoverBtn.frame = [UIScreen mainScreen].bounds;
    [_maxCoverBtn setBackgroundColor:[UIColor blackColor]];
    [_maxCoverBtn setAlpha:0.3];
    [_maxCoverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
}

//遮盖被点击了,收回view
- (void)coverClick
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 266);
    } completion:^(BOOL finished) {
        [self.maxCoverBtn removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

- (void)updateInfo:(UIViewController*)parentCtrl list:(NSArray*)list
{
    parent = parentCtrl;
    infoStr = [list firstObject];
    [parentCtrl.view endEditing:YES];
    [parentCtrl.navigationController.view addSubview:self.maxCoverBtn];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    
    self.frame = CGRectMake( 0 , parentCtrl.navigationController.view.bounds.size.height + 266, SCREEN_WIDTH, 266);
    
    [parentCtrl.navigationController.view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, parentCtrl.navigationController.view.bounds.size.height - 266, SCREEN_WIDTH, 266);
    }];
    
    dataList = list;
    
    if (self.jsonModelPropertyName) {
        [self setJsonModelPropertyName:self.jsonModelPropertyName];
        infoStr = [dataStringList firstObject];
    }
    else{
        dataStringList = [[NSMutableArray alloc]initWithArray:list];
    }
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
}
- (void)setJsonModelPropertyName:(NSString *)jsonModelPropertyName
{
    _jsonModelPropertyName = jsonModelPropertyName;
    dataStringList = [NSMutableArray array];
    for (NSInteger i = 0; i < dataList.count; i++) {
        NSString *str;
        str = [dataList[i] valueForKey:jsonModelPropertyName];
        if (!str) {
            if ([dataList[i] isKindOfClass:[NSString class]]) {
                str = dataList[i];
            }
            else{
                str = @"";
            }
        }
//        if ([dataList[i] isKindOfClass:[NSDictionary class]]) {
//            str = dataList[i][jsonModelPropertyName];
//            if (!str) {
//                str = @"";
//            }
//        }
//        else{
//            str = [self getVariablevarName:_jsonModelPropertyName data:dataList[i]];
//        }
        
        [dataStringList addObject:str];
        infoStr = dataStringList[0];
        
    }
    
}

//- (NSString *)getVariablevarName:(NSString *)name data:(id)data
//{
//    Class modelClass;
//    modelClass = [data class];
//
//    unsigned int outCount, i;
//    Ivar *ivars = class_copyIvarList(modelClass, &outCount);
//    for (i = 0; i < outCount; i++) {
//        Ivar property = ivars[i];
//        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
//        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
//        if ([keyName isEqualToString:name]) {
//            NSString *showStr = [data valueForKey:keyName];
//            return showStr;
//        }
//    }
//    NSLog(@"PublicPicker jsomodel 解析出错");
//    return @"";
//}
//点击取消
- (IBAction)actCancel:(id)sender
{
    [self coverClick];
}

//完成
- (IBAction)actComplete:(id)sender
{
    [self coverClick];
    
    if (self.didSelectBlockAtIndex && dataList.count) {
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        id value = [dataList objectAtIndex:row];
        
        self.didSelectBlockAtIndex(row,value);
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return dataList.count;
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id content = dataList[row];
    
    if ([content isKindOfClass:[NSDictionary class]]) {
        if(_jsonModelPropertyName){
            return dataStringList[row];
        }
        return content[@"name"];
    }
    
    return dataStringList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    //    infoStr = dataStringList[row];
    
}



@end
