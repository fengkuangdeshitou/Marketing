//
//  NetworkUrlGetter.m
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import "NetworkUrlGetter.h"
#import "NetworkUrl.h"

@implementation NetworkUrlGetter

+ (NSString *)getHost {
    return hostUrl;
}

+ (NSString *)getWechatLoginWithCode:(NSString *)code sceneParams:(NSString *)scene;{
    return [NSString stringWithFormat:@"%@/%@?code=%@&sceneParams=%@&getChannel=%@&deviceId=%@&brand=%@&model=%@&h5Url=%@",hostUrl,wechatLoginUrl,code,scene,[DeviceTool shareInstance].getChannel,[DeviceTool shareInstance].deviceId,[DeviceTool shareInstance].brand,[DeviceTool shareInstance].model,[DeviceTool shareInstance].h5Url];
}

+ (NSString *)getVerificationCodeUrlWithTell:(NSString *)tell{
    return [[[hostUrl stringByAppendingPathComponent:verificationCodeUrl] stringByAppendingString:@"?tell="] stringByAppendingString:tell];
}

+ (NSString *)getCodeLoginUrl{
    return [hostUrl stringByAppendingPathComponent:codeLoginUrl];
}

+ (NSString *)getMyGroupDownUrl{
    return [hostUrl stringByAppendingPathComponent:myGroupDownUrl];
}

+ (NSString *)getLivenessCheckUrl{
    return [hostUrl stringByAppendingPathComponent:livenessCheckUrl];
}

+ (NSString *)getApplyPayNotifyUrl{
    return [hostUrl stringByAppendingPathComponent:applyPayNotifyUrl];
}

+ (NSString *)getUpdateMemberInfoUrl{
    return [hostUrl stringByAppendingPathComponent:updateMemberInfoUrl];
}

+ (NSString *)getUploadImgUrl{
    return [hostUrl stringByAppendingPathComponent:uploadImgUrl];
}

+ (NSString *)getUploadVideoUrl{
    return [hostUrl stringByAppendingPathComponent:uploadVidelUrl];
}

+ (NSString *)getMyShareRecordUrl{
    return [hostUrl stringByAppendingPathComponent:myShareRecordUrl];
}

+ (NSString *)getMyMoneyUrl{
    return [hostUrl stringByAppendingPathComponent:myMoneyUrl];
}

+ (NSString *)getBindPhoneUrl{
    return [hostUrl stringByAppendingPathComponent:bindPhoneUrl];
}

+ (NSString *)getAddBankUrl{
    return [hostUrl stringByAppendingPathComponent:addBankUrl];
}

+ (NSString *)getMyBankUrl{
    return [hostUrl stringByAppendingPathComponent:myBankUrl];
}

+ (NSString *)getMyDrawRecordUrl{
    return [hostUrl stringByAppendingPathComponent:myDrawRecordUrl];
}

+ (NSString *)getMyDrawUrlWithMbBankId:(NSString *)mbBankId money:(NSString *)money{
    return [[[[[hostUrl stringByAppendingPathComponent:myDrawUrl] stringByAppendingString:@"?mbBankId="] stringByAppendingString:mbBankId] stringByAppendingString:@"&money="] stringByAppendingString:money];
}

+ (NSString *)getConfigUrlWithKey:(NSString *)key{
    return [[[hostUrl stringByAppendingPathComponent:configUrl] stringByAppendingString:@"?key="] stringByAppendingString:key];
}

+ (NSString *)getDicPriceListUrl{
    return [hostUrl stringByAppendingPathComponent:dicPriceListUrl];
}

+ (NSString *)getMyVipUrl{
    return [hostUrl stringByAppendingPathComponent:myVipUrl];
}

+ (NSString *)getPriceListUrl{
    return [[[[hostUrl stringByAppendingPathComponent:priceListUrl] stringByAppendingString:@"?appVersion="] stringByAppendingString:[DeviceTool shareInstance].appVersion] stringByAppendingString:@"&plat=ios"];
}

+ (NSString *)getFindGroupListUrl{
    return findGroupListUrl;
}

+ (NSString *)getHotSearchUrl{
    return hotSearchUrl;
}

+ (NSString *)getDownUrl{
    return [[hostUrl stringByAppendingPathComponent:downUrl] stringByAppendingString:@"?key=DOWN_PACK_URL"];
}

+ (NSString *)getFindCircleUrl{
    return [hostUrl stringByAppendingPathComponent:findCircleUrl];
}

+ (NSString *)getComplaintTypeListUrl{
    return [hostUrl stringByAppendingPathComponent:complaintTypeListUrl];
}

+ (NSString *)getAddCircleUrl{
    return [hostUrl stringByAppendingPathComponent:addCircleUrl];
}

+ (NSString *)getAddComplaintUrl{
    return [hostUrl stringByAppendingPathComponent:addComplaintUrl];
}

+ (NSString *)getShareTextUrl{
    return [hostUrl stringByAppendingPathComponent:shareTextUrl];
}

+ (NSString *)getUserAgreementUrl{
    return userAgreementUrl;
}

+ (NSString *)getPrivacyPolicyUrl{
    return privacyPolicyUrl;
}

+ (NSString *)getHelpUrl{
    return [hostUrl stringByAppendingPathComponent:helpUrl];
}

+ (NSString *)getDeleteCircelWithCircleId:(NSString *)circleId{
    return [[[hostUrl stringByAppendingPathComponent:deleteCircleUrl] stringByAppendingString:@"?circleId="] stringByAppendingString:circleId];
}

+ (NSString *)getAppVersion{
    return [[hostUrl stringByAppendingPathComponent:appVersionUrl] stringByAppendingFormat:@"?plat=ios"];
}

+ (NSString *)getIosAuditStateUrl{
    return [[[[hostUrl stringByAppendingPathComponent:configUrl] stringByAppendingString:@"?key="] stringByAppendingString:iosAuditStateUrl] stringByAppendingString:[DeviceTool shareInstance].appVersion];
}

+ (NSString *)getIosAuditLoginUrl{
    return [[[[hostUrl stringByAppendingPathComponent:configUrl] stringByAppendingString:@"?key="] stringByAppendingString:iosAuditLoginUrl] stringByAppendingString:[DeviceTool shareInstance].appVersion];
}

+ (NSString *)getFindGroupNumberUrl{
    return [findGroupNumberUrl stringByAppendingString:@"?wxgType=group"];
}

@end
