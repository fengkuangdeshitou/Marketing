//
//  InvitationModel.h
//  Marketing
//
//  Created by 王帅 on 2021/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvitationModel : NSObject

@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * share_reg_time;
@property(nonatomic,copy)NSString * buy_price_total;
@property(nonatomic,copy)NSString * buy_count;

@end

NS_ASSUME_NONNULL_END
