//
//  YHUserModel.h
//  YHNetworkTool
//
//  Created by Yangli on 2018/10/25.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHDataModel.h"
@class RoleDto,UserDataDto,StoreInfoDto;

NS_ASSUME_NONNULL_BEGIN

@interface YHUserModel : YHDataModel

@property(nonatomic, strong) UserDataDto* passportUser;

@property(nonatomic, copy) NSString* shopCode;
@property(nonatomic, copy) NSString* token;
@property(strong,nonatomic) NSArray<RoleDto *>* roles;
@property(strong,nonatomic) NSArray<StoreInfoDto *>* regionPrivileges;
@property(strong,nonatomic) NSArray<StoreInfoDto *>* shopPrivileges;
@property(assign,nonatomic) BOOL updatePassword;

@end

@interface RoleDto : YHDataModel
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* profile;
@property (nonatomic, copy) NSString* roleType;

@end

@interface UserDataDto : YHDataModel
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* telephone;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* nickname;
@property (nonatomic, assign) NSInteger createdTime;
@property (nonatomic, copy) NSString* createdBy;
@property (nonatomic, assign) NSInteger updatedTime;
@property (nonatomic, copy) NSString* updatedBy;
@property (nonatomic, copy) NSString* note;
@property (nonatomic, copy) NSString* userId;


@end

@interface StoreInfoDto : YHDataModel

@property(nonatomic, copy) NSString* dataDesc;
@property(nonatomic, copy) NSString* dataId;
@property(nonatomic, copy) NSString* dataType;
@property(nonatomic, copy) NSString* id;
@property(nonatomic, copy) NSString* userId;
@property(nonatomic, copy) NSString* regionName;

@end

NS_ASSUME_NONNULL_END
