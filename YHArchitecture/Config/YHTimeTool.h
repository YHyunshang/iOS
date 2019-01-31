//
//  YHTimeTool.h
//  YHTestDemo_Example
//
//  Created by Yangli on 2018/12/20.
//  Copyright © 2018年 2510479687@qq.com. All rights reserved.
//
/***
 
 
 
 %a    Abbreviated weekday name *                                   Thu
 %A    Full weekday name *                                          Thursday
 %b    Abbreviated month name *                                     Aug
 %B    Full month name *                                            August
 %c    Date and time representation *                               Thu Aug 23 14:55:02 2001
 %C    Year divided by 100 and truncated to integer (00-99)         20
 %d    Day of the month, zero-padded (01-31)                        23
 %D    Short MM/DD/YY date, equivalent to %m/%d/%y                  08/23/01
 %e    Day of the month, space-padded ( 1-31)                       23
 %F    Short YYYY-MM-DD date, equivalent to %Y-%m-%d                2001-08-23
 %g    Week-based year, last two digits (00-99)                     01
 %G    Week-based year                                              2001
 %h    Abbreviated month name * (same as %b)                        Aug
 %H    Hour in 24h format (00-23)                                   14
 %I    Hour in 12h format (01-12)                                   02
 %j    Day of the year (001-366)                                    235
 %m    Month as a decimal number (01-12)                            08
 %M    Minute (00-59)                                               55
 %n    New-line character ('\n')
 %p    AM or PM designation                                         PM
 %r    12-hour clock time *                                         02:55:02 pm
 %R    24-hour HH:MM time, equivalent to %H:%M                      14:55
 %S    Second (00-61)                                               02
 %t    Horizontal-tab character ('\t')
 %T    ISO 8601 time format (HH:MM:SS), equivalent to %H:%M:%S      14:55:02
 %u    ISO 8601 weekday as number with Monday as 1 (1-7)            4
 %U    Week number with the first Sunday as the first day of week one (00-53)    33
 %V    ISO 8601 week number (01-53)                                              34
 %w    Weekday as a decimal number with Sunday as 0 (0-6)                        4
 %W    Week number with the first Monday as the first day of week one (00-53)    34
 %x    Date representation *                                                     08/23/01
 %X    Time representation *                                                     14:55:02
 %y    Year, last two digits (00-99)                                             01
 %Y    Year                                                                      2001
 %z    ISO 8601 offset from UTC in timezone (1 minute=1, 1 hour=100)
 If timezone cannot be determined, no characters                                 +100
 %Z    Timezone name or abbreviation *
 If timezone cannot be determined, no characters                                 CDT
 %%    A % sign    %

 更多格式链接地址 http://www.cplusplus.com/reference/ctime/strftime/?kw=strftime
 
 ***/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHTimeTool : NSObject

/**
 当前时间串
 %Y-%m-%d %H:%M:%S %A  年月日 时分秒 星期

 @return 时间字符串
 */
+ (NSString *)nowTimeString;

/**
 当前时间串

 @param formatter 自定义输出时间格式，格式详见上部
 @return 时间字符串
 */
+ (NSString *)nowTimeStringWithFormatter:(NSString *)formatter;

/**
 根据时间戳输出固定格式时间字符串
 格式 %Y/%m/%d %H:%M:%S  年月日 时分秒
 @param timestamp 指定的时间戳
 @return 时间字符串
 */
+ (NSString *)timeStringWithTimestamp:(NSTimeInterval)timestamp;

/**
 输出指定格式的时间戳对应的字符串

 @param timestamp 指定的时间戳
 @param formatter 指定的格式 %Y/%m/%d %H:%M:%S  年月日 时分秒
 @return 时间字符串
 */
+ (NSString *)timeStringWithTimestamp:(NSTimeInterval)timestamp
                            formatter:(NSString *)formatter;

/**
 输出指定格式的NSDate对应的字符串

 @param date 指定的日期对象
 @param formatter 指定的格式 %Y/%m/%d %H:%M:%S  年月日 时分秒
 @return 时间字符串
 */
+ (NSString *)timeStringWithDate:(NSDate *)date
                       formatter:(NSString *)formatter;


/**
 指定时间距当前时间差

 @param timestamp 指定时间戳
 @return <#return value description#>
 */
+ (NSString *)distanceTimeWithBeforeTimestamp:(NSTimeInterval)timestamp;

@end

NS_ASSUME_NONNULL_END
