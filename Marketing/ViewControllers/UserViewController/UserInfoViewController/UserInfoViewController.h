//
//  UserInfoViewController.h
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoViewController : UIViewController

@property(nonatomic,copy)void(^reloadUserInfo)(void);

@end

NS_ASSUME_NONNULL_END
