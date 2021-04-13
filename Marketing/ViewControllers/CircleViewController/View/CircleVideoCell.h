//
//  CircleVideoCell.h
//  Marketing
//
//  Created by maiyou on 2021/4/13.
//

#import <UIKit/UIKit.h>
#import "CircleBaseCell.h"
@class CircleVideoCell;

NS_ASSUME_NONNULL_BEGIN

@protocol CircleVideoCellDelegate <NSObject>

- (void)coverItemWasTapped:(CircleVideoCell *)cell;

@end

@interface CircleVideoCell : CircleBaseCell

@property (nonatomic, weak, nullable) id<CircleVideoCellDelegate> delegate;

@end



NS_ASSUME_NONNULL_END
