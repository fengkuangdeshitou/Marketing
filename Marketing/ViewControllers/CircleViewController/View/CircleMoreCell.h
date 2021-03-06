//
//  CircleMoreCell.h
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import <UIKit/UIKit.h>
#import "CircleBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleMoreCell : CircleBaseCell

@property(nonatomic,weak)IBOutlet UIButton * addFriendButton;
@property(nonatomic,weak)IBOutlet UIButton * moreButton;
@property(nonatomic,copy)void(^DeleteCircleBlock)(NSString * circleId);

@end

NS_ASSUME_NONNULL_END
