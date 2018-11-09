//
//  YHTrackManager.h
//  YHTrackSDK
//
//  Created by Yangli on 2018/9/12.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTrackLocation.h"

#define YHTrackSetEmptyIfNil(obj) (obj==nil?@"":obj)
#define CurYHTrackMangager [YHTrackManager sharedInstance]

#ifdef DEBUG

#define YHTrackLog(s,...) printf("\n时间：%s\n %s [第%d行]\n %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:s, ## __VA_ARGS__] UTF8String]);

#else
#define YHTrackLog(s,...)

#endif


/** 工具默认统计包含 appType、brand、model、systemVersion、rom、cpu、pid、createTime
 */
@interface YHTrackManager : NSObject

@property(nonatomic,strong)NSDictionary *data;/**/
@property(nonatomic,assign)BOOL isEnable,isDebug;/*是否上传统计数据；是否显示log日志*/
@property(nonatomic,strong)NSString *productId;/*项目id*/


/**
 初始化

 @return <#return value description#>
 */
+ (instancetype)sharedInstance;

/**
 测试模式，isDebug=YES,显示log日志及测试环境

 @param isDebug <#isDebug description#>
 */
+ (void)setDebug:(BOOL)isDebug;

/**
 配置埋点数据

 @param pid 项目id
 @param dataPath 配置文件名，json格式
 @return <#return value description#>
 */
+ (instancetype)configWithProductId:(NSString *)pid dataPath:(NSString *)dataPath;

/**
 埋点配置数据
 
 @param pid 项目id
 @param defaultPath 首次发版配置文件
 @param loadPath 请求的配置文件
 @return 管理对象
 */
+ (instancetype)configWithProductId:(NSString *)pid defaultPath:(NSString *)defaultPath loadPath:(NSURL *)loadPath;

@end
