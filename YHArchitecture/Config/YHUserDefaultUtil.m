//
//  DJUserDefaultUtil.m
//  YHArchitecture
//
//  Created by Yangli on 2019/6/12.
//  Copyright © 2019 永辉. All rights reserved.
//

#import "YHUserDefaultUtil.h"
#import "YHDataModel.h"

@implementation YHUserDefaultUtil

+ (void)setObj:(id)object forKey:(NSString *)key
{
    if (!key) {
        return ;
    }
    if ([object isKindOfClass:[YHDataModel class]]) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
        [YHUserDefaults setObject:data forKey:key];
    }else{
        [YHUserDefaults setObject:object forKey:key];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)key
{
    id temp =  [YHUserDefaults objectForKey:key];
    if ([temp isKindOfClass:[NSData class]]) {
        id object = [NSKeyedUnarchiver unarchiveObjectWithData:temp];
        if ([object isKindOfClass:[YHDataModel class]]) {
            return object;
        }
    }
    return [YHUserDefaults objectForKey:key];
}

+ (void)synchronize
{
    [YHUserDefaults synchronize];
}


@end
