//
//  YHTimeTool.m
//  YHTestDemo_Example
//
//  Created by Yangli on 2018/12/20.
//  Copyright © 2018年 2510479687@qq.com. All rights reserved.
//

#import "YHTimeTool.h"

#include <stdio.h>
#include <time.h>

@implementation YHTimeTool

+ (NSString *)nowTimeString
{
    time_t rawtime;
    struct tm *timeinfo;
    char buffer[128];
    
    time(&rawtime);
//    printf("%ld\n",rawtime);
    
    timeinfo = localtime(&rawtime);
    strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M:%S %A",timeinfo);
//    printf("Now is %s\n", buffer);
    return [NSString stringWithCString:buffer
                              encoding:NSUTF8StringEncoding];
}

+ (NSString *)nowTimeStringWithFormatter:(NSString *)formatter
{
    time_t rawtime;
    struct tm *timeinfo;
    char buffer[128];
    
    time(&rawtime);
//    printf("%ld\n",rawtime);
    
    timeinfo = localtime(&rawtime);
    
    const char *formatterChar = [formatter UTF8String];
    strftime(buffer, sizeof(buffer), formatterChar,timeinfo);
    
//    printf("%s\n", buffer);
    return [NSString stringWithCString:buffer
                              encoding:NSUTF8StringEncoding];
}

+ (NSString *)timeStringWithTimestamp:(NSTimeInterval)timestamp
{
    time_t rawtime = timestamp;
    struct tm *timeinfo;
    char buffer[128];
    
    timeinfo = localtime(&rawtime);
    strftime(buffer, sizeof(buffer), "time is %Y/%m/%d %H:%M:%S",timeinfo);
//    printf("%s\n", buffer);
    
    return [NSString stringWithCString:buffer
                              encoding:NSUTF8StringEncoding];
}

+ (NSString *)timeStringWithTimestamp:(NSTimeInterval)timestamp
                            formatter:(NSString *)formatter
{
    time_t rawtime = timestamp;
    struct tm *timeinfo;
    char buffer[128];
    
    timeinfo = localtime(&rawtime);
    const char *formatterChar = [formatter UTF8String];
    strftime(buffer, sizeof(buffer), formatterChar,timeinfo);
//    printf("%s\n", buffer);
    
    return [NSString stringWithCString:buffer
                              encoding:NSUTF8StringEncoding];
}

+ (NSString *)timeStringWithDate:(NSDate *)date
                       formatter:(NSString *)formatter
{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return [self timeStringWithTimestamp:timeInterval formatter:formatter];
}

/**
 指定时间距当前时间差
 
 @param timestamp 指定时间戳
 @return <#return value description#>
 */
+ (NSString *)distanceTimeWithBeforeTimestamp:(NSTimeInterval)timestamp
{
    NSString *result;
    
    time_t rawtime;    
    time(&rawtime);
    printf("%ld\n",rawtime);
    time_t difference = rawtime - timestamp;
    
    NSString *timeString = [YHTimeTool timeStringWithTimestamp:timestamp formatter:@"%H:%M"];
    
    NSString *nowDay = [YHTimeTool timeStringWithTimestamp:rawtime formatter:@"%d"];
    NSString *lastDay = [YHTimeTool timeStringWithTimestamp:timestamp formatter:@"%d"];
    if (difference < 24*60*60 && ([nowDay integerValue] == [lastDay integerValue])) {
        result = [NSString stringWithFormat:@"今天 %@",timeString];
    }else if (difference < 24*60*60*2 &&([nowDay integerValue] != [lastDay integerValue])){
        if ([nowDay integerValue] - [lastDay integerValue] == 1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            result = [NSString stringWithFormat:@"昨天 %@",timeString];
        }else{
            result = [YHTimeTool timeStringWithTimestamp:timestamp formatter:@"%m:%d %H:%M"];
        }
    }else {
        NSString *nowYear = [YHTimeTool timeStringWithTimestamp:rawtime formatter:@"%Y"];
        NSString *timeYear = [YHTimeTool timeStringWithTimestamp:timestamp formatter:@"%Y"];
        if (nowYear.integerValue == timeYear.integerValue) {
            result = [YHTimeTool timeStringWithTimestamp:timestamp formatter:@"%m:%d %H:%M"];
        }else{
            result = [YHTimeTool timeStringWithTimestamp:timestamp formatter:@"%Y:%m:%d %H:%M"];
        }
    }
    
    return result;
}

@end
