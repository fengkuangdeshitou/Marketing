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
    return [NSString stringWithFormat:@"%@/%@?code=%@&sceneParams=%@&getChannel=%@&deviceId=%@&brand=%@&model=%@",hostUrl,wechatLoginUrl,code,scene,[DeviceTool shareInstance].getChannel,[DeviceTool shareInstance].deviceId,[DeviceTool shareInstance].brand,[DeviceTool shareInstance].model];
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

@end
