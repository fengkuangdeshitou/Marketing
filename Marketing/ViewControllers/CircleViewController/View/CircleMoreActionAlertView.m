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
@property(nonatomic,strong)NSMutableArray * imageArray;

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
    [self dismiss];
    if (sender.tag == 10) {
        UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.model.text;
        [UIApplication.sharedApplication.keyWindow makeToast:@"已为您复制到粘贴板"];
    }else if(sender.tag == 11){
        if (self.model.images.count > 0) {
            self.imageArray = [[NSMutableArray alloc] initWithArray:self.model.images];
            [self saveImage];
        }else{
            [UIApplication.sharedApplication.keyWindow makeToast:@"暂无图片"];
        }
    }else if(sender.tag == 12){
        UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.model.text;
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
        ComplaintsViewController * complaints = [[ComplaintsViewController alloc] initWithCircleId:self.model.circle_id];
        complaints.title = @"违规举报";
        complaints.hidesBottomBarWhenPushed = true;
        [[PreHelper getCurrentVC].navigationController pushViewController:complaints animated:true];
    }
}

- (void)saveImage{
    if (self.imageArray.count > 0) {
        NSString *urlString = self.imageArray.firstObject;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
        UIImage *image = [UIImage imageWithData:data];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else{
        [UIApplication.sharedApplication.keyWindow makeToast:@"图片已保存到相册"];
    }
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败";
    }else{
        msg = @"保存图片成功";
        [self.imageArray removeObjectAtIndex:0];
    }
    [self saveImage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
