//
//  UITableView+EmptyView.h
//  Marketing
//
//  Created by 王帅 on 2021/4/20.
//

#import <UIKit/UIKit.h>
#import "NoDataEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (EmptyView)

@property (nonatomic, strong) NoDataEmptyView *emptyView;

@end

NS_ASSUME_NONNULL_END
