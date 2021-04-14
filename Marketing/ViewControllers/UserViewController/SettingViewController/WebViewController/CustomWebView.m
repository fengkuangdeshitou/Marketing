//
//  CustomWebView.m
//  Marketing
//
//  Created by 王帅 on 2021/4/14.
//

#import "CustomWebView.h"

@implementation CustomWebView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    self = [super initWithFrame:frame configuration:configuration];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
