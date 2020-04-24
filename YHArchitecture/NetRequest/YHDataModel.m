//
//  YHDataModel.m
//  YHArchitecture
//
//  Created by Yangli on 2018/11/11.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHDataModel.h"

@interface YHDataModel(){
    Class _responseClass;
}

@end

@implementation YHDataModel

- (BOOL)requestCorrect
{
    return self.code == 200;
}

- (id)response_class
{
    return _responseClass;
}

- (id)initWithDictionary:(NSDictionary *)dictionary responseClass :(id)responseClass
{
    self = [super init];
    _responseClass = responseClass;
    if (self) {
        //code 处理
        if (dictionary[@"code"]) {
            self.code = [dictionary[@"code"] longValue];
        }else if(dictionary[@"status"]){
            self.code = [dictionary[@"status"] longValue];
        }else{
            //其他适配
            self.code = -NOGROUP;
        }
        //message 处理
        if(dictionary[@"desc"]) {
            self.message = dictionary[@"desc"];
        }else if(dictionary[@"message"]) {
            self.message = dictionary[@"message"];
        }else if(dictionary[@"status"]){
            self.message = dictionary[@"status"];
        }else{
            //其他适配
            self.message = @"";
        }
        
        //data 处理
        if (dictionary[@"response"]) {
            id obj = [_responseClass modelWithDictionary:dictionary[@"response"]];
            id t_result = dictionary[@"response"];
            if ([t_result isKindOfClass:[NSArray class]]) {
                obj = [NSArray yy_modelArrayWithClass:[_responseClass class] json:dictionary[@"response"]];
            }else if ([t_result isKindOfClass:[NSString class]]){
                obj = t_result;
            }
            self.yhresponse = obj;
        }else if(dictionary[@"page"]) {
            id obj = [_responseClass modelWithDictionary:dictionary[@"page"]];
            id t_result = dictionary[@"page"];
            if ([t_result isKindOfClass:[NSArray class]]) {
                obj = [NSArray yy_modelArrayWithClass:[_responseClass class] json:dictionary[@"page"]];
            }else if ([t_result isKindOfClass:[NSString class]]){
                obj = t_result;
            }
            self.yhresponse = obj;
        }else if(dictionary[@"result"]){
            id obj = [_responseClass modelWithDictionary:dictionary[@"result"]];
            id t_result = dictionary[@"result"];
            if ([t_result isKindOfClass:[NSArray class]]) {
                obj = [NSArray yy_modelArrayWithClass:[_responseClass class] json:dictionary[@"result"]];
            }else if ([t_result isKindOfClass:[NSString class]]){
                obj = t_result;
            }
            self.yhresponse = obj;
        }else if(dictionary[@"data"]){
            id obj = [_responseClass modelWithDictionary:dictionary[@"data"]];
            id t_result = dictionary[@"data"];
            if ([t_result isKindOfClass:[NSArray class]]) {
                obj =  [NSArray yy_modelArrayWithClass:[_responseClass class] json:dictionary[@"data"]];
            }else if ([t_result isKindOfClass:[NSString class]]){
                obj = t_result;
            }
            self.yhresponse = obj;
        }
        //其他适配
    }
        
    return self;
}

+ (BOOL)handleResult:(YHDataModel *)result
{
    [super handleResult:result];
    if (result == nil) {
        NSLog(@"网络不太给力哦");
        return NO;
    }else if (result.code == 200 || result.code == 0 || result.code == 200000){
        return YES;
    }
    return NO;
}

+ (id)convertjsonStringToDict:(NSString *)jsonString
{
    id retDict = nil;
    if ([jsonString isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        return  retDict;
    }else{
        return retDict;
    }
    
}

@end
