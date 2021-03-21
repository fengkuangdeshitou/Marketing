//
//  InvitationViewController.h
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvitationViewController : UIViewController

/// 本月收益
@property(nonatomic,copy)NSString * monthMoney;

/// 累计收益
@property(nonatomic,copy)NSString * totalMoney;

/// 邀请人数
@property(nonatomic,copy)NSString * myShareCount;

@end

NS_ASSUME_NONNULL_END
