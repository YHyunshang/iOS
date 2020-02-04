//
//  DJUserDefaultUtil.h
//  YHArchitecture
//
//  Created by Yangli on 2019/6/12.
//  Copyright © 2019 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>


//NS_ASSUME_NONNULL_BEGIN

@interface YHUserDefaultUtil : NSObject

+ (void)setObj:(id)object forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
+ (void)synchronize;

@end

//NS_ASSUME_NONNULL_END
