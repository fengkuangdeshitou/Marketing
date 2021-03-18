//
//  UserManager.h
//  Marketing
//
//  Created by 王帅 on 2021/3/18.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

/// 保存用户信息
/// @param model 数据模型
+ (void)saveUser:(UserModel *)model;

/// 获取用户信息
+ (UserModel *)getUser;

/// 删除用户
+ (void)deleteUser;

@end

NS_ASSUME_NONNULL_END
