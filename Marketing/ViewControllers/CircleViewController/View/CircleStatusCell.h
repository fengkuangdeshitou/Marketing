//
//  CircleStatusCell.h
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import <UIKit/UIKit.h>
#import "CircleBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleStatusCell : CircleBaseCell

@property(nonatomic,copy) void(^cellHeightChangeBlock)(void);

@end

NS_ASSUME_NONNULL_END
