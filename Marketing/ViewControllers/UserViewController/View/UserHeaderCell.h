//
//  UserHeaderCell.h
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserHeaderCell : UITableViewCell

@property(nonatomic,strong)UserModel * model;
@property(nonatomic,weak)IBOutlet UIButton * memberButton;
@property(nonatomic,weak)IBOutlet UILabel * titleLabel;
@property(nonatomic,weak)IBOutlet UILabel * descLabel;

@end

NS_ASSUME_NONNULL_END
