//
//  BindingAliViewController.h
//  Marketing
//
//  Created by 王帅 on 2021/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BindingAliViewControllerDelegate <NSObject>

- (void)onBindAliSuccess;

@end

@interface BindingAliViewController : UIViewController

@property(nonatomic,weak)id<BindingAliViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
