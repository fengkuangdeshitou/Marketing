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

+ (NSString *)dateFromString:(NSString*)dateString;

+ (CGFloat)getCircleContentHeight:(NSString *)content;

+ (BOOL)isBlankString:(NSString *)string;

+ (CGFloat)getWidthWithUrl:(NSString *)url;

+ (CGFloat)getHeightWithUrl:(NSString *)url;

@end
