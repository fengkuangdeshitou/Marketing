//
//  WechatTimelineAlertView.m
//  Marketing
//
//  Created by 王帅 on 2021/5/21.
//

#import "WechatTimelineAlertView.h"

@implementation WechatTimelineAlertView

+ (void)showWechatTimelineAlertView{
    WechatTimelineAlertView * alertView = [[WechatTimelineAlertView alloc] init];
    [alertView show];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.frame = UIScreen.mainScreen.bounds;
        self.alpha = 0;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)show{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
}

- (IBAction)dismiss{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)share{
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:@"weixin://"]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
