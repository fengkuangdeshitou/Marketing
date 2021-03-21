//
//  UserInfoHeaderCell.h
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoHeaderCell : UITableViewCell

@property(nonatomic,strong)UserModel * model;
@property(nonatomic,copy)void(^headerImageReloadCompletion)(void);

@end

NS_ASSUME_NONNULL_END
