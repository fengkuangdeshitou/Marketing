//
//  ServiceAlertView.m
//  Marketing
//
//  Created by 王帅 on 2021/3/14.
//

#import "ServiceAlertView.h"
#import "NetworkUrl.h"

@interface ServiceAlertView ()

@property(nonatomic,weak)IBOutlet UIImageView * qrcodeImageView;

@end

@implementation ServiceAlertView

+ (void)showServiceAlertView{
    ServiceAlertView * alertView = [[ServiceAlertView alloc] init];
    [alertView show];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        self.frame = UIScreen.mainScreen.bounds;
        self.alpha = 0;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
        [self loadServiceErCodeData];
    }
    return self;
}

/// 客服二维码
- (void)loadServiceErCodeData{
    [NetworkWorker networkGet:[NetworkUrlGetter getConfigUrlWithKey:kefuErCodeUrl] success:^(NSDictionary *result) {
        [ImageLoader loadImage:self.qrcodeImageView url:result[@"str"] placeholder:nil];
    } failure:^(NSString *errorMessage) {
        
    }];
}

- (void)show{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
}

- (IBAction)dismiss:(UITapGestureRecognizer *)sender{
    [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

- (IBAction)saveToPhoto:(UIButton *)sender{
    UIImageWriteToSavedPhotosAlbum(self.qrcodeImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败";
    }else{
        msg = @"保存图片成功";
    }
    [self makeToast:msg];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
