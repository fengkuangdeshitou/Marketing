//
//  CALayer+YYLayer.h
//  Coach
//
//  Created by Maiyou on 2019/3/15.
//  Copyright © 2019 yangyong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (YYLayer)

@property(nonatomic, assign) UIColor *shadowUIColor;

- (void)setBorderUIColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
