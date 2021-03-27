//
//  PreHelper.h
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PreHelper : NSObject

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (BOOL)isLogin;

+ (void)pushToTabbarController;

+ (void)pushToLoginController;

+ (UIViewController *)getCurrentVC;

+ (NSString *)setCreateTime:(NSString *)createTime;

+ (NSString *)getHourAndMinute:(NSDate *)date;

+ (void)setExtraCellLineHidden:(UITableView *)tableView;

+ (NSString *)stringFormatDateMin:(NSDate *)date;

+ (NSData *)toJSONData:(id)theData;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

+ (NSString *)getCurrentDataAndTime;

+ (NSString *)dateFromString:(NSString*)dateString;

+ (CGFloat)getCircleContentHeight:(NSString *)content;

+ (void)resetTableViewFrame:(UITableView *)tableView;

+ (void)resignFirstResponderTextFieldOrTextView:(NSArray *)fieldArray;

+ (NSString *)getDays:(NSString *)dateStr;

+ (NSString *)getHours:(NSString *)dateStr;

+ (NSDateComponents *)getDate:(NSString *)dateStr;

+ (NSString *)getSubmitMouth:(long long)submitTime;

+ (NSString *)getSubmitDays:(long long)submitTime;

+ (long long)getTimeSinceWithDate:(NSDate *)date;

+ (long long)getTimeWithDateStr:(NSString *)dateStr;

+(BOOL)DocumentFilePaht:(NSString*)fileName requestUrl:(NSString*)URl;

+(NSDictionary*)ReadDocmentsTempFile :(NSString*)_Name;

+(BOOL) isBlankString:(NSString *)string;

+ (BOOL)valiMobile:(NSString *)mobile;

@end
