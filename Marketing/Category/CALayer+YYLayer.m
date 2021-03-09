//
//  CALayer+YYLayer.m
//  Coach
//
//  Created by Maiyou on 2019/3/15.
//  Copyright © 2019 yangyong. All rights reserved.
//

#import "CALayer+YYLayer.h"

@implementation CALayer (YYLayer)

- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}


- (void)setShadowUIColor:(UIColor *)color
{
    self.shadowColor = color.CGColor;
}

- (UIColor *)shadowUIColor
{
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end
