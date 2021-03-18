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
// @"http://yinxiao-api.wecein.com:8033/yinxiao-server/app/member/weixinuserinfo?code=021DiTkl2OOAH64LANkl2MDTjI0DiTks&sceneParams=snsapi_userinfo&getChannel=MOREN&deviceId=29518120-D65B-4BD0-9228-68F4F119CED8&brand=iPhones&model=iPhone8,4"
+ (NSString *)getWechatLoginWithCode:(NSString *)code sceneParams:(NSString *)scene channel:(NSString *)channel deviceId:(NSString *)deviceId brand:(NSString *)brand model:(NSString *)model{
    return [NSString stringWithFormat:@"%@/%@?code=%@&sceneParams=%@&getChannel=%@&deviceId=%@&brand=%@&model=%@",hostUrl,wechatLoginUrl,code,scene,channel,deviceId,brand,model];
}

+ (NSString *)getVerificationCodeUrlWithTell:(NSString *)tell{
    return [[[hostUrl stringByAppendingPathComponent:verificationCodeUrl] stringByAppendingString:@"?tell="] stringByAppendingString:tell];
}

+ (NSString *)getCodeLoginUrl{
    return [hostUrl stringByAppendingPathComponent:codeLoginUrl];
}

@end
