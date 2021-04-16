//
//  CustomerServiceCell.h
//  Marketing
//
//  Created by maiyou on 2021/3/12.
//

#import <UIKit/UIKit.h>
#import "HelpModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomerServiceCell : UITableViewCell

@property (nonatomic, assign) BOOL isShowContent;
@property (nonatomic, strong) HelpModel *model;
@property (nonatomic, copy) void(^moreBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
