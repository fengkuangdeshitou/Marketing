//
//  CircleVideoCell.h
//  Marketing
//
//  Created by maiyou on 2021/4/13.
//

#import <UIKit/UIKit.h>
#import "CircleBaseCell.h"

@protocol CircleVideoCellDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface CircleVideoCell : CircleBaseCell

@property (nonatomic, weak, nullable) id<CircleVideoCellDelegate> delegate;

@end

@protocol CircleVideoCellDelegate

- (void)coverItemWasTapped:(CircleVideoCell *)cell;

@end

NS_ASSUME_NONNULL_END
