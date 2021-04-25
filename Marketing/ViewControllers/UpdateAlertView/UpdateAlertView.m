//
//  UpdateAlertView.m
//  Marketing
//
//  Created by maiyou on 2021/4/22.
//

#import "UpdateAlertView.h"

@interface UpdateAlertView ()

@property(nonatomic,strong)NSDictionary * dictionary;
@property (nonatomic,weak) IBOutlet UILabel * versionLabel;
@property (nonatomic,weak) IBOutlet UILabel * updateContent;
@property (nonatomic,weak) IBOutlet UIButton *closeButton;

@end

@implementation UpdateAlertView

+ (void)showUpdateAlertViewWithData:(NSDictionary *)dict{
    UpdateAlertView * alertView = [[UpdateAlertView alloc] initWithDictionary:dict];
    [alertView show];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.frame = UIScreen.mainScreen.bounds;
        self.alpha = 0;
        self.dictionary = dictionary;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
        self.updateContent.text = dictionary[@"description"];
        self.versionLabel.text = [NSString stringWithFormat:@"V.%@",dictionary[@"title"]];
        if ([dictionary[@"must_update"] isEqualToString:@"no"]){
            self.closeButton.hidden  = NO;
        }else{
            self.closeButton.hidden  = YES;
        }
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
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 下载升级
- (IBAction)downloadAction:(id)sender{
    NSString *path = self.dictionary[@"url"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
    [self dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
