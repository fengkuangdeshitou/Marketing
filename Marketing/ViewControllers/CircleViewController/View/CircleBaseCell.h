//
//  CircleBaseCell.h
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import <UIKit/UIKit.h>
#import "CircleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleBaseCell : UITableViewCell

@property(nonatomic,strong)CircleModel * model;

+ (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath dataModel:(CircleModel *)model;

@end

NS_ASSUME_NONNULL_END
