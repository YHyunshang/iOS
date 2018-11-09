//
//  YHTrackNetTool.h
//  YHTrackSDK
//
//  Created by Yangli on 2018/9/14.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHTrackNetTool : NSObject

#warning 使用前确保pid和配置json已配置，并且isEnable为YES
/**
 上传埋点信息

 @param params 埋点数据 已包含appType、brand、model、systemVersion、rom、cpu、pid、createTime参加
 */
+ (void)uploadTrackInfoWithParams:(NSDictionary *)params;

@end
