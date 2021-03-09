//
//  NSDate+Additions.m
//  jinsuibao
//
//  Created by tj on 4/21/16.
//  Copyright © 2016 yiqiniu. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)


- (uint64_t)timeIntervalSince1970_MSEC {
    uint64_t mps = 1000;
    return [self timeIntervalSince1970] * mps;
}

+ (NSString *)monthlyDetailTimeWithTimeStrap:(NSTimeInterval)ts {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM月dd日 HH:mm:ss";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:ts];
    
    return [dateFormatter stringFromDate:date];
}

+ (BOOL)moreThanADayToNow:(NSDate *)theDate {
    NSTimeInterval late = [theDate timeIntervalSince1970] * 1;
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now =[dat timeIntervalSince1970] * 1;
    NSTimeInterval diff = now - late;
    if (diff > 60 * 60 * 24) {
        return YES;
    }
    return NO;
}

+ (NSDate *)getLocalDateWithCurrentDate:(NSDate *)date {
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    return localDate;
}


+ (NSString *)dayTimeStringWithTS:(NSTimeInterval)ts {
    return [self dateWithFormat:@"HH:mm" WithTS:ts];
}

+ (NSString *)dateTimeStringWithTS:(NSTimeInterval)ts {
    return [self dateWithFormat:@"yyyy-MM-dd" WithTS:ts];
}

+ (NSString *)monthTimeStringWithTs:(NSTimeInterval)ts {
    return [self dateWithFormat:@"yyyy年MM月" WithTS:ts];
}

+ (NSString *)detailTimeStringWithTs:(NSTimeInterval)ts {
    return [self dateWithFormat:@"yyyy-MM-dd HH:mm:ss" WithTS:ts];
}




+ (NSString*)dateWithFormat:(NSString*)format WithTS:(NSTimeInterval)ts {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:ts];
    
    return [dateFormatter stringFromDate:date];
}

- (NSString *)stringWithFormaterString:(NSString *)formaterString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formaterString;
    NSString * str = [dateFormatter stringFromDate:self];
    return str;
}

+ (NSDate *)dateWithFormaterString:(NSString *)formaterString dateString:(NSString *)dateString {
    
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formaterString];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
    
}

+ (BOOL)isNowAvailableFromTs:(NSTimeInterval)fromTs endTs:(NSTimeInterval)endTs {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    if (timeInterval >= fromTs && timeInterval <= endTs) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNowAnothrDayForDate:(NSDate *)date {
    //获取公历
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    
    //日历单位
    NSCalendarUnit units = NSCalendarUnitTimeZone | NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    //起始时间
    NSDate *fromDate = date;
    NSDateComponents *fromComponents = [calendar components:units fromDate:fromDate];
    
    //当前时间
    NSDate *nowDate = [NSDate date];
    NSDateComponents *nowComponents = [calendar components:units fromDate:nowDate];
    
    //转换后的起始时间
    NSDate *convertFromDate = [calendar dateFromComponents:fromComponents];
    
    //转换后的当前时间
    NSDate *convertNowDate = [calendar dateFromComponents:nowComponents];
    
    if ([convertNowDate isEqualToDate:convertFromDate]) {
        return NO;
    }else {
        return YES;
    }
}

//获取当前的时间

+(NSString*)getCurrentTimes:(NSString *)string
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:string];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
    
}

#pragma mark - 将某个时间转化成 时间戳
+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"yyyy-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSString * timeSp = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:[date timeIntervalSince1970]]];
    return timeSp;
}

//获取当前时间戳(以秒为单位)
+ (NSString *)getNowTimeTimestamp
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}

//转换英文为中文
+ (NSString *)cTransformFromE:(NSString *)theWeek
{
    NSString *chinaStr;
    if(theWeek){
        if([theWeek isEqualToString:@"Monday"] || [theWeek isEqualToString:@"星期一"]){
            chinaStr = @"一";
        }else if([theWeek isEqualToString:@"Tuesday"] || [theWeek isEqualToString:@"星期二"]){
            chinaStr = @"二";
        }else if([theWeek isEqualToString:@"Wednesday"] || [theWeek isEqualToString:@"星期三"]){
            chinaStr = @"三";
        }else if([theWeek isEqualToString:@"Thursday"] || [theWeek isEqualToString:@"星期四"]){
            chinaStr = @"四";
        }else if([theWeek isEqualToString:@"Friday"] || [theWeek isEqualToString:@"星期五"]){
            chinaStr = @"五";
        }else if([theWeek isEqualToString:@"Saturday"] || [theWeek isEqualToString:@"星期六"]){
            chinaStr = @"六";
        }else if([theWeek isEqualToString:@"Sunday"] || [theWeek isEqualToString:@"星期日"]){
            chinaStr = @"日";
        }
    }
    return chinaStr;
}

+ (NSString *)cTransEnformCh:(NSString *)date
{
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
    [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
    NSString *theWeek = [weekFormatter stringFromDate:[NSDate dateWithFormaterString:@"yyyy-MM-dd" dateString:date]];
    
    NSString *chinaStr;
    if(theWeek){
        if([theWeek isEqualToString:@"Monday"]){
            chinaStr = @"星期一";
        }else if([theWeek isEqualToString:@"Tuesday"]){
            chinaStr = @"星期二";
        }else if([theWeek isEqualToString:@"Wednesday"]){
            chinaStr = @"星期三";
        }else if([theWeek isEqualToString:@"Thursday"]){
            chinaStr = @"星期四";
        }else if([theWeek isEqualToString:@"Friday"]){
            chinaStr = @"星期五";
        }else if([theWeek isEqualToString:@"Saturday"]){
            chinaStr = @"星期六";
        }else if([theWeek isEqualToString:@"Sunday"]){
            chinaStr = @"星期日";
        }
        else
        {
            chinaStr = theWeek;
        }
    }
    return chinaStr;
}

+ (NSString *)getWeekDayFordate:(long long)data{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

@end
