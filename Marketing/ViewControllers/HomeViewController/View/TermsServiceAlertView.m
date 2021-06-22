//
//  TermsServiceAlertView.m
//  Marketing
//
//  Created by 王帅 on 2021/6/22.
//

#import "TermsServiceAlertView.h"
#import "WebViewController.h"

@implementation TermsServiceAlertView

+(void)showTermsServiceAlertView{
    TermsServiceAlertView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]lastObject];
    view.frame = UIScreen.mainScreen.bounds;
    [UIApplication.sharedApplication.keyWindow addSubview:view];
    view.alpha = 0;
    [view show];
}

- (void)show{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
}

- (IBAction)statusChangeAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (IBAction)dismiss{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)termsServiceAction:(id)sender{
    [self dismiss];
    WebViewController *web = [[WebViewController alloc] initWithHtml:@"http://file-oss.wecein.com/html/dsf.html"];
    web.hidesBottomBarWhenPushed = YES;
    [[PreHelper getCurrentVC].navigationController pushViewController:web animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
