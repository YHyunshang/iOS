//
//  YHTrackLocation.h
//  YHTrackSDK
//
//  Created by Yangli on 2018/9/18.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YHTrackLocation : NSObject

@property(nonatomic,assign) double latitude;/*维度*/
@property(nonatomic,assign) double longtitude;/*经度*/
@property(nonatomic,strong) NSString *province;/*省份（不包括直辖市）*/
@property(nonatomic,strong) NSString *city;/*市（县，包括直辖市）*/
@property(nonatomic,strong) NSString *district;/*街道*/
@property(nonatomic,strong) NSString *country;/*国家*/

@end
