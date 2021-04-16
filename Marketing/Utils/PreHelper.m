//
//  PreHelper.m
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "MyTabbarViewController.h"
#import "LoginViewController.h"
#import "CustomNavagationController.h"

@implementation PreHelper

+ (UIColor *)colorWithHexString:(NSString *)color{
    return [self colorWithHexString:color alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (BOOL)isLogin{
    UserModel * model = [UserManager getUser];
    if (model) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)pushToTabbarController{
    MyTabbarViewController *tabbar = [[MyTabbarViewController alloc] init];
    UIWindow *window =  [[UIApplication sharedApplication].delegate window];
    window.rootViewController = tabbar;
    [window makeKeyAndVisible];
}

+ (void)pushToLoginController{
    LoginViewController *login = [[LoginViewController alloc] init];
    CustomNavagationController * nav = [[CustomNavagationController alloc] initWithRootViewController:login];
    nav.navigationBar.hidden = YES;
    UIWindow *window =  [[UIApplication sharedApplication].delegate window];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
}

+ (UIViewController *)jsd_getRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController* currentViewController = [self jsd_getRootViewController];

    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    return currentViewController;
}

+ (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    return [dateFormatter stringFromDate:date];
}

+ (long long)getTimeSinceWithDate:(NSDate *)date {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    return (long long) [localeDate timeIntervalSince1970];
}

+(NSString*)dateFromString:(NSString*)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT_MIN];
    NSDate * date = [dateFormatter dateFromString:dateString];
    long long time = [self getTimeSinceWithDate:date];
    return [self compareCurrentTime:time];
}

+ (NSString *)compareCurrentTime:(long long)time {
    NSDate * timeDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}

+(long long)longLongFromDate:(NSDate*)date{
    return [date timeIntervalSince1970] * 1000;
}

+ (CGFloat)getCircleContentHeight:(NSString *)content {
    UIFont *font = [UIFont systemFontOfSize:17];
    CGRect rect = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 83, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
    return rect.size.height;
}

#pragma mark - 字符串判空
+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)urlContainsWidthAndHeight:(NSString *)url{
    if ([url containsString:@"__"]) {
        NSArray * widthArray = [url componentsSeparatedByString:@"__"];
        return widthArray.count == 3;
    }else{
        return NO;
    }
}

+ (CGFloat)getWidthWithUrl:(NSString *)url{
    if ([self urlContainsWidthAndHeight:url]) {
        NSArray * widthArray = [url componentsSeparatedByString:@"__"];
        CGFloat widthValue = [widthArray[1] floatValue];
        CGFloat heightValue = [widthArray[2] floatValue];
        if (widthValue <= heightValue) {
            widthValue = DEFAULT_IMAGE_WIDTH;
        }else{
            if (widthValue > (SCREEN_WIDTH-80)) {
                CGFloat proportion = heightValue/widthValue;
                widthValue = DEFAULT_IMAGE_HEIGHT/proportion;
            }
        }
        return widthValue;
    }else{
        return DEFAULT_IMAGE_WIDTH;
    }
}

+ (CGFloat)getHeightWithUrl:(NSString *)url{
    if ([self urlContainsWidthAndHeight:url]) {
        NSArray * widthArray = [url componentsSeparatedByString:@"__"];
        CGFloat widthValue = [widthArray[1] floatValue];
        CGFloat heightValue = [widthArray[2] floatValue];
        if (widthValue <= heightValue) {
            CGFloat proportion = widthValue/heightValue;
            heightValue = DEFAULT_IMAGE_WIDTH/proportion;
        }else{
            heightValue = DEFAULT_IMAGE_HEIGHT;
        }
        return heightValue;
    }else{
        return DEFAULT_IMAGE_HEIGHT;
    }
}

@end
