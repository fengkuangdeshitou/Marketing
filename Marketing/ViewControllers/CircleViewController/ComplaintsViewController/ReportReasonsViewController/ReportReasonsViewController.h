//
//  ReportReasonsViewController.h
//  Marketing
//
//  Created by maiyou on 2021/4/13.
//

#import <UIKit/UIKit.h>
#import "ComplaintsModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ReportReasonsViewControllerDelegate <NSObject>

- (void)onDidSelectedReasonsModel:(ComplaintsModel *)model;

@end

@interface ReportReasonsViewController : UIViewController

@property(nonatomic,weak)id<ReportReasonsViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
