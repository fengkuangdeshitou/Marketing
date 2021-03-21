//
//  NetworkUrl.h
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUrl : NSObject

extern NSString * const hostUrl;

extern NSString * const ApplePayUrl;

extern NSString * const wechatLoginUrl;

extern NSString * const verificationCodeUrl;

extern NSString * const codeLoginUrl;

/// 赚钱

extern NSString * const myMoneyUrl;

extern NSString * const myShareRecordUrl;

extern NSString * const addBankUrl;

extern NSString * const myBankUrl;

extern NSString * const myDrawRecordUrl;

extern NSString * const myDrawUrl;

/// 个人中心

extern NSString * const myGroupDownUrl;

extern NSString * const livenessCheckUrl;

extern NSString * const applyPayNotifyUrl;

extern NSString * const updateMemberInfoUrl;

extern NSString * const uploadImgUrl;

extern NSString * const bindPhoneUrl;

@end
