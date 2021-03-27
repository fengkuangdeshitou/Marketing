//
//  DownloadAlertView.m
//  Marketing
//
//  Created by 王帅 on 2021/3/11.
//

#import "DownloadAlertView.h"
#import "AddValueServicesController.h"

@interface DownloadAlertView ()

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,weak)IBOutlet UILabel * titleLabel;
@property(nonatomic,weak)IBOutlet UILabel * urlLabel;
@property(nonatomic,weak)IBOutlet UIButton * actionButton;

@end

@implementation DownloadAlertView

+ (void)showDownloadAlertView{
    DownloadAlertView * alertView = [[DownloadAlertView alloc] init];
    [alertView getDownloadUrl];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        self.frame = UIScreen.mainScreen.bounds;
        self.alpha = 0;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
    }
    return self;
}

- (void)getDownloadUrl{
    [NetworkWorker networkGet:[NetworkUrlGetter getConfigUrlWithKey:@"DOWN_PACK_URL"] success:^(NSDictionary *result) {
        self.count = [result[@"count"] integerValue];
        if (self.count > 0) {
            [self.actionButton setTitle:@"复制链接" forState:UIControlStateNormal];
        }else{
            [self.actionButton setTitle:@"立即购买" forState:UIControlStateNormal];
        }
        self.titleLabel.text = [NSString stringWithFormat:@"您的下载次数为%ld",self.count];
        self.urlLabel.text = result[@"str"];
        [self show];
    } failure:^(NSString *errorMessage) {
        [self makeToast:errorMessage];
    }];
}

- (IBAction)copyUrl:(UIButton *)sender{
    if (self.count > 0) {
        UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.urlLabel.text;
        [self makeToast:@"已复制到剪贴板" duration:2 position:@"center"];
    }else{
        [self removeFromSuperview];
        AddValueServicesController * services = [[AddValueServicesController alloc] init];
        services.title = @"增值服务";
        services.hidesBottomBarWhenPushed = true;
        [[PreHelper getCurrentVC].navigationController pushViewController:services animated:YES];
    }
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
