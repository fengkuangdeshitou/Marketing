//
//  NetworkUrl.m
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import "NetworkUrl.h"

@implementation NetworkUrl

#ifdef DEBUG
NSString * const hostUrl = @"http://yinxiao-api.wecein.com:8033/yinxiao-server";
#else
NSString * const hostUrl = @"http://yinxiao-api.wecein.com:8033/yinxiao-server";
#endif

/// 微信登录
NSString * const wechatLoginUrl = @"app/member/weixinuserinfo";
/// 获取验证码
NSString * const verificationCodeUrl = @"app/sms/send";
/// 验证码登录
NSString * const codeLoginUrl = @"app/sms/checkCode";



@end
