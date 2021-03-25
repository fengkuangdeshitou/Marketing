//
//  UserModel.h
//  Marketing
//
//  Created by 王帅 on 2021/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property(nonatomic,copy)NSString * mb_no;
/// 账号绑定手机号
@property(nonatomic,copy)NSString * tell;
/// 微信绑定手机号
@property(nonatomic,copy)NSString * contact;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * token;
@property(nonatomic,copy)NSString * wechatNum;
@property(nonatomic,copy)NSString * wechatErCode;

@end

NS_ASSUME_NONNULL_END
