//
//  UserModel.h
//  Marketing
//
//  Created by 王帅 on 2021/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property(nonatomic,copy)NSString * user_name;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * token;

@end

NS_ASSUME_NONNULL_END
