//
//  MembersViewController.h
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MembersViewControllerDelegate <NSObject>

- (void)onRechargeMemberSuccess;

@end

@interface MembersViewController : UIViewController

@property(nonatomic,weak)id<MembersViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
