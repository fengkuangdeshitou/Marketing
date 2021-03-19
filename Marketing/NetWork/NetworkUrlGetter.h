//
//  NetworkUrlGetter.h
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUrlGetter : NSObject

+ (NSString *)getHost;

+ (NSString *)getWechatLoginWithCode:(NSString *)code sceneParams:(NSString *)scene;

+ (NSString *)getVerificationCodeUrlWithTell:(NSString *)tell;

+ (NSString *)getCodeLoginUrl;

@end
