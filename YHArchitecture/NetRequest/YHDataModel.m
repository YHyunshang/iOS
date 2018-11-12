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
    _responseClass = responseClass;
    YHDataModel *result = [YHDataModel modelWithDictionary:dictionary];
    if (dictionary[@"desc"]) {
        result.message = dictionary[@"desc"];
    }
    if (dictionary[@"data"]) {
        id obj = [_responseClass modelWithDictionary:dictionary[@"data"]];
        id t_result = dictionary[@"data"];
        if ([t_result isKindOfClass:[NSArray class]]) {
            obj = [_responseClass modelWithDictionary:@{@"data":t_result}];
        }else if ([t_result isKindOfClass:[NSString class]]){
            //返回数据是json串
            id t_dic = [YHDataModel convertjsonStringToDict:t_result];
            if ([t_dic isKindOfClass:[NSDictionary class]]) {
                obj = [_responseClass modelWithDictionary:t_dic];
            }else if ([t_dic isKindOfClass:[NSArray class]]){
                obj = [_responseClass modelWithDictionary:@{@"data":t_dic}];
            }
        }
        
        result.yhresponse = obj;
    }
    if (dictionary[@"response"]) {
        id obj = [_responseClass modelWithDictionary:dictionary[@"response"]];
        id t_result = dictionary[@"response"];
        if ([t_result isKindOfClass:[NSArray class]]) {
            obj = [_responseClass modelWithDictionary:@{@"data":dictionary[@"response"]}];
        }
        
        result.yhresponse = obj;
    }
    
    if (dictionary[@"result"]) {
        id obj = [_responseClass modelWithDictionary:dictionary[@"result"]];
        id t_result = dictionary[@"response"];
        if ([t_result isKindOfClass:[NSArray class]]) {
            obj = [_responseClass modelWithDictionary:@{@"data":dictionary[@"result"]}];
        }
        
        result.yhresponse = obj;
    }
    
    if (dictionary[@"firstPage"]) {
        result.yhresponse = [_responseClass modelWithDictionary:@{@"firstPage":dictionary[@"firstPage"]}];
    }
    
    return result;
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
