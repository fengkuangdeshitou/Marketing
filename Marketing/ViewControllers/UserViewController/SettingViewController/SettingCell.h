//
//  SettingCell.h
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel * titleLabel;
@property(nonatomic,weak)IBOutlet UILabel * descLabel;
@property(nonatomic,weak)IBOutlet UIImageView * detailIcon;

@property(nonatomic,weak)IBOutlet NSLayoutConstraint * detailIconLeft;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint * detailIconWidth;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint * detailIconHeight;

@end

NS_ASSUME_NONNULL_END
