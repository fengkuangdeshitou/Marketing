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

+ (NSString *)getMyGroupDownUrl;

+ (NSString *)getLivenessCheckUrl;

+ (NSString *)getApplyPayNotifyUrl;

+ (NSString *)getUpdateMemberInfoUrl;

+ (NSString *)getUploadImgUrl;

+ (NSString *)getMyShareRecordUrl;

+ (NSString *)getMyMoneyUrl;

+ (NSString *)getBindPhoneUrl;

+ (NSString *)getAddBankUrl;

+ (NSString *)getMyBankUrl;

+ (NSString *)getMyDrawRecordUrl;

+ (NSString *)getMyDrawUrlWithMbBankId:(NSString *)mbBankId money:(NSString *)money;

+ (NSString *)getConfigUrlWithKey:(NSString *)key;

+ (NSString *)getDicPriceListUrl;

+ (NSString *)getMyVipUrl;

+ (NSString *)getPriceListUrl;



@end
