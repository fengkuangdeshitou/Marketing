//
//  MemberAlertView.h
//  Marketing
//
//  Created by maiyou on 2021/4/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MemberAlertViewDelegate <NSObject>

- (void)memberDidSelectAction;

@end

@interface MemberAlertView : UIView

+ (void)showMemberAlertViewWithDelegate:(id<MemberAlertViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
