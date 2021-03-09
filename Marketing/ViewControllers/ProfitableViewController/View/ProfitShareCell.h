//
//  ProfitShareCell.h
//  Marketing
//
//  Created by 王帅 on 2021/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitShareCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIButton * shareToFriendsButton;
@property(nonatomic,weak)IBOutlet UIButton * shareToGroupButton;
@property(nonatomic,weak)IBOutlet UIButton * shareToFriendCircleButton;

@end

NS_ASSUME_NONNULL_END
