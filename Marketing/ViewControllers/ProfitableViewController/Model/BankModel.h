//
//  BankModel.h
//  Marketing
//
//  Created by 王帅 on 2021/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankModel : NSObject

@property(nonatomic,copy)NSString * myMoney;
@property(nonatomic,copy)NSString * bank_name;
@property(nonatomic,copy)NSString * bank_no;
@property(nonatomic,copy)NSString * bank_user;
@property(nonatomic,copy)NSString * mb_bank_id;
@property(nonatomic,copy)NSString * icon_url;

@property(nonatomic,copy)NSString * draw_money;
@property(nonatomic,copy)NSString * draw_state;
@property(nonatomic,copy)NSString * draw_time;

@end

NS_ASSUME_NONNULL_END
