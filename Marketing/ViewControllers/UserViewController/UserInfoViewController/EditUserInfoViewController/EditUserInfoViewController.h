//
//  EditUserInfoViewController.h
//  Marketing
//
//  Created by 王帅 on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^EditUserInfoBlock)(NSString * value);

@interface EditUserInfoViewController : UIViewController

@property(nonatomic,copy)EditUserInfoBlock editBlock;

@end

NS_ASSUME_NONNULL_END
