//
//  MemberAlertView.m
//  Marketing
//
//  Created by maiyou on 2021/4/26.
//

#import "MemberAlertView.h"

@interface MemberAlertView ()

@property(nonatomic,weak)id<MemberAlertViewDelegate>delegate;

@end

@implementation MemberAlertView

+ (void)showMemberAlertViewWithDelegate:(id<MemberAlertViewDelegate>)delegate{
    MemberAlertView * alertView = [[MemberAlertView alloc] initWithDelegate:delegate];
    [alertView show];
}

- (instancetype)initWithDelegate:(id<MemberAlertViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.frame = UIScreen.mainScreen.bounds;
        self.alpha = 0;
        self.delegate = delegate;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
    }
    return self;
}

- (IBAction)experienceImmediatelyAction:(UIButton *)sender{
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(memberDidSelectAction)]) {
        [self.delegate memberDidSelectAction];
    }
}

- (void)show{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha =1;
    }];
}

- (void)dismiss{
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
