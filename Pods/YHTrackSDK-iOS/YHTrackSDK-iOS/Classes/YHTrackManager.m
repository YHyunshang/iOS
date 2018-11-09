//
//  YHTrackManager.m
//  YHTrackSDK
//
//  Created by Yangli on 2018/9/12.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHTrackManager.h"


@implementation YHTrackManager

+ (instancetype)sharedInstance
{
    static YHTrackManager * instacne = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instacne = [YHTrackManager new];
    });
    return instacne;
}

+ (void)setDebug:(BOOL)isDebug
{
    CurYHTrackMangager.isDebug = isDebug;
}

/**
 配置埋点数据
 
 @param pid 项目id
 @param dataPath 配置文件名，json格式
 @return <#return value description#>
 */
+ (instancetype)configWithProductId:(NSString *)pid dataPath:(NSString *)dataPath
{
    YHTrackManager *manager = [YHTrackManager sharedInstance];
    manager.productId = pid;
    NSString *path = [[NSBundle mainBundle] pathForResource:dataPath ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:path];
    if (JSONData) {
        manager.data = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    }else{
        YHTrackLog(@"请先配置‘YHTrack_Data.json’");
    }
    return manager;
}

/**
 埋点配置数据
 
 @param pid 项目id
 @param defaultPath 首次发版配置文件
 @param loadPath 请求的配置文件
 @return 管理对象
 */
+ (instancetype)configWithProductId:(NSString *)pid defaultPath:(NSString *)defaultPath loadPath:(NSURL *)loadPath
{
    YHTrackManager *manager = [YHTrackManager sharedInstance];
    manager.productId = pid;
    
    NSData *loadData = [NSData dataWithContentsOfURL:loadPath];
    NSDictionary *loadDic = [NSJSONSerialization JSONObjectWithData:loadData
                                                            options:NSJSONReadingAllowFragments
                                                              error:nil];
    if (loadDic) {
        manager.data = loadDic;
    }else{
        NSString *path = [[NSBundle mainBundle] pathForResource:defaultPath ofType:@"json"];
        
        NSData *JSONData = [NSData dataWithContentsOfFile:path];
        if (JSONData) {
            manager.data = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        }else{
            YHTrackLog(@"请先配置‘YHTrack_Data.json’");
        }
    }
    
    return manager;
}



@end
