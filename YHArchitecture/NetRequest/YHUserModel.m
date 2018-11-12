//
//  YHUserModel.m
//  YHNetworkTool
//
//  Created by Yangli on 2018/10/25.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHUserModel.h"

@implementation YHUserModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"regionPrivileges":[StoreInfoDto class],
             @"shopPrivileges":[StoreInfoDto class],
             @"roles":[RoleDto class],
             @"passportUser":[UserDataDto class]
             };
}


@end

@implementation RoleDto

@end

@implementation UserDataDto

@end

@implementation StoreInfoDto

@end
