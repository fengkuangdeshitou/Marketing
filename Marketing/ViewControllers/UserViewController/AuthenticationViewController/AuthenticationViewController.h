//
//  AuthenticationViewController.h
//  Marketing
//
//  Created by maiyou on 2021/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AuthenticationViewControllerDelegate <NSObject>

- (void)onAuthemticationSuccess;

@end

@interface AuthenticationViewController : UIViewController

@property(nonatomic,weak)id<AuthenticationViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
