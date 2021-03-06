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

+ (NSString *)getUploadVideoUrl;

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

+ (NSString *)getFindGroupListUrl;

+ (NSString *)getHotSearchUrl;

+ (NSString *)getDownUrl;

+ (NSString *)getFindCircleUrl;

+ (NSString *)getComplaintTypeListUrl;

+ (NSString *)getAddCircleUrl;

+ (NSString *)getAddComplaintUrl;

+ (NSString *)getShareTextUrl;

+ (NSString *)getUserAgreementUrl;

+ (NSString *)getPrivacyPolicyUrl;

+ (NSString *)getHelpUrl;

+ (NSString *)getDeleteCircelWithCircleId:(NSString *)circleId;

+ (NSString *)getAppVersion;

+ (NSString *)getIosAuditStateUrl;

+ (NSString *)getIosAuditLoginUrl;

+ (NSString *)getFindGroupNumberUrl;

@end
