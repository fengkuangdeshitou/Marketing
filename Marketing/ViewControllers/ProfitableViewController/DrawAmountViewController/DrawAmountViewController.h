//
//  DrawAmountViewController.h
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DrawAmountViewControllerDelegate <NSObject>

- (void)onDeawAmountSuccess;

@end

@interface DrawAmountViewController : UIViewController

@property(nonatomic,strong)BankModel * model;

@property(nonatomic,weak)id<DrawAmountViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
