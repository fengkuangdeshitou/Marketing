//
//  DownloadAlertView.m
//  Marketing
//
//  Created by 王帅 on 2021/3/11.
//

#import "DownloadAlertView.h"

@interface DownloadAlertView ()

@property(nonatomic,weak)IBOutlet UILabel * urlLabel;

@end

@implementation DownloadAlertView

+ (void)showDownloadAlertViewWithUrl:(NSString *)url{
    DownloadAlertView * alertView = [[DownloadAlertView alloc] initWithUrl:url];
    [alertView show];
}

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        self.frame = UIScreen.mainScreen.bounds;
        self.alpha = 0;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
        
        self.urlLabel.text = url;
    }
    return self;
}

- (IBAction)copyUrl:(UIButton *)sender{
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.urlLabel.text;
    [self makeToast:@"已复制到剪贴板" duration:2 position:@"center"];
}

- (void)show{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
}

- (IBAction)dismiss:(UITapGestureRecognizer *)tap{
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
