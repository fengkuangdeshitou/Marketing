//
//  CircleModel.m
//  Marketing
//
//  Created by 王帅 on 2021/3/12.
//

#import "CircleModel.h"

@implementation CircleModel

- (NSArray *)images{
    return [self.img_urls componentsSeparatedByString:@","];
}

@end
