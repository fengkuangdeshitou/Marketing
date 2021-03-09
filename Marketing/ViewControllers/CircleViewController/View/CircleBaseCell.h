//
//  CircleBaseCell.h
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleBaseCell : UITableViewCell

+ (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath dataModel:(id)model;

@end

NS_ASSUME_NONNULL_END
