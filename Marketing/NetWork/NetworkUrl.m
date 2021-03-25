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
NSString * const ApplePayUrl = @"https://sandbox.itunes.apple.com/verifyReceipt";
#else
NSString * const hostUrl = @"http://yinxiao-api.wecein.com:8033/yinxiao-server";
NSString * const ApplePayUrl = @"https://buy.itunes.apple.com/verifyReceipt";
#endif

/// 系统配置
NSString * const configUrl = @"/app/member/getConfig";

/// 微信登录
NSString * const wechatLoginUrl = @"app/member/weixinuserinfo";
/// 获取验证码
NSString * const verificationCodeUrl = @"app/sms/send";
/// 验证码登录
NSString * const codeLoginUrl = @"app/sms/checkCode";



/// 我的余额
NSString * const myMoneyUrl = @"/app/bank/myMoney";
/// 我的邀请记录
NSString * const myShareRecordUrl = @"app/member/myShareRecord";
/// 绑定支付宝
NSString * const addBankUrl = @"/app/bank/addBank";
/// 查询我的提现方式
NSString * const myBankUrl = @"app/bank/myBank";
/// 提现记录
NSString * const myDrawRecordUrl = @"app/member/myDrawRecord";
/// 提现
NSString * const myDrawUrl = @"app/bank/tixian";
/// 价目表
NSString * const dicPriceListUrl = @"/app/pay/getDicPriceList";


/// 剩余下载
NSString * const myGroupDownUrl = @"/app/member/getMyGroupDown";
/// 实名认证
NSString * const livenessCheckUrl = @"app/member/livenessCheck";
/// 内购验证
NSString * const applyPayNotifyUrl = @"/app/pay/applyPayNotify";
/// 修改个人信息
NSString * const updateMemberInfoUrl = @"/app/member/updateMemberInfo";
/// 图片上传
NSString * const uploadImgUrl = @"sys/oss/uploadImg";
/// 绑定手机号
NSString * const bindPhoneUrl = @"app/member/bindPhone";





@end
