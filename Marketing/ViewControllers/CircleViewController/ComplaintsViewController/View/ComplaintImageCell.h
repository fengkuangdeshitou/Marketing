//
//  ComplaintImageCell.h
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import <UIKit/UIKit.h>
#import "PhotoManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComplaintImageCellDelegate <NSObject>

- (void)complaintImageCellDidSelectedImage:(NSArray<HXPhotoModel *> *)imageArray;

@end

@interface ComplaintImageCell : UITableViewCell

@property(nonatomic,weak)id<ComplaintImageCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
