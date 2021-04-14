//
//  CircleMoreActionAlertView.m
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import "CircleMoreActionAlertView.h"
#import "ComplaintsViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface CircleMoreActionAlertView ()

@property(nonatomic,strong)CircleModel * model;

@end

@implementation CircleMoreActionAlertView

+ (void)showMoreAcrionAlertViewWithCircleModel:(CircleModel *)model{
    CircleMoreActionAlertView * alertView = [[CircleMoreActionAlertView alloc] initWithCircleModel:model];
    [alertView show];
}

- (instancetype)initWithCircleModel:(CircleModel *)model
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.frame = UIScreen.mainScreen.bounds;
        self.alpha = 0;
        self.model = model;
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

- (void)dismiss{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)moreAction:(UIButton *)sender{
    if (sender.tag == 10) {
        UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.model.text;
    }else if(sender.tag == 11){
        
    }else if(sender.tag == 12){
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
        [params SSDKSetupShareParamsByText:self.model.text images:self.model.images.count > 0 ? self.model.images : nil url:self.model.video_url.length > 0 ? [NSURL URLWithString:self.model.video_url] : nil title:self.model.text type:SSDKContentTypeAuto];
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
               case SSDKResponseStateSuccess:
                    NSLog(@"分享成功");//成功
               break;
               case SSDKResponseStateFail:
                    {
                         NSLog(@"--分享失败%@",error.description);
                         //失败
                         break;
                    }
                case SSDKResponseStateCancel:
                    NSLog(@"--分享取消");
                         break;
                default:
                break;
             }
        }];
    }else{
        [self dismiss];
        ComplaintsViewController * complaints = [[ComplaintsViewController alloc] initWithCircleId:self.model.circle_id];
        complaints.title = @"违规举报";
        complaints.hidesBottomBarWhenPushed = true;
        [[PreHelper getCurrentVC].navigationController pushViewController:complaints animated:true];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
