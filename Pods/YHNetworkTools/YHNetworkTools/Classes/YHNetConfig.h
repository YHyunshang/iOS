//
//  YHNetConfig.h
//  YHNetClient_Example
//
//  Created by Yangli on 2019/4/1.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YHNetConfig <NSObject>

@required

/**
 请求参数编码格式
 
 @return
 0:AFHTTPRequestSerializer 普通的http的编码格式，二进制;
 1:AFJSONRequestSerializer json格式;
 2:AFPropertYHistRequestSerializer plist 编码格式
 */
- (NSInteger)requestParameterEncoding;

/**
 响应参数编码格式
 
 @return
 0:AFJSONResponseSerializer json格式;
 1:AFHTTPResponseSerializer 普通的http的编码格式，二进制;
 2:AFXMLParserResponseSerializer XML,只能返回XMLParser，还需要自己解析;
 3:AFPropertYHistResponseSerializer plist编码格式;
 4:AFImageResponseSerializer image;
 5:AFCompoundResponseSerializer 组合
 */
- (NSInteger)responseParameterEncoding;

/**
 请求超时时间
 */
- (NSInteger)requestTimeOut;

/**
 请求头自定义数据,如设置请求tonken
 */
- (NSDictionary*)customRequestHeader;

/**
 响应体acceptableContentTypes
 */
- (NSSet *)responseAcceptableContentTypes;



@end

NS_ASSUME_NONNULL_END
