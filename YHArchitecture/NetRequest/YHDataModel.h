//
//  YHDataModel.h
//  YHArchitecture
//
//  Created by Yangli on 2018/11/11.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHBaseResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHDataModel : YHBaseResult

@property (strong, nonatomic) id yhresponse;      //数据
@property (strong, nonatomic) NSString *message;  //描述
@property (assign, nonatomic) long code;  //状态码

/** 是否正确请求，code200 为正确 */
- (BOOL)requestCorrect;

- (id)initWithDictionary:(NSDictionary *)dictionary responseClass :(id)responseClass;

@end

NS_ASSUME_NONNULL_END
