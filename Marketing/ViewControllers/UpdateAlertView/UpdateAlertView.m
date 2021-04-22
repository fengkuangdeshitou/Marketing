//
//  UpdateAlertView.m
//  Marketing
//
//  Created by maiyou on 2021/4/22.
//

#import "UpdateAlertView.h"

@implementation UpdateAlertView

+ (void)showUpdateAlertViewWithData:(NSDictionary *)dict{
    UpdateAlertView * alertView = [[UpdateAlertView alloc] init];
    [alertView show];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([UpdateAlertView class]) owner:self options:nil] lastObject];
        self.frame = UIScreen.mainScreen.bounds;
        self.alpha = 0;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
    }
    return self;
}

- (void)show{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
}

- (IBAction)dismiss:(UIButton *)sender{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
