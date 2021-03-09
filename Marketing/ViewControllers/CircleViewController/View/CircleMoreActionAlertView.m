//
//  CircleMoreActionAlertView.m
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import "CircleMoreActionAlertView.h"
#import "ComplaintsViewController.h"

@implementation CircleMoreActionAlertView

+ (instancetype)showMoreAcrionAlertViewWithId:(NSString *)modelId{
    CircleMoreActionAlertView * more = [[CircleMoreActionAlertView alloc] init];
    return more;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.frame = UIScreen.mainScreen.bounds;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
    }
    return self;
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
        
    }else if(sender.tag == 11){
        
    }else if(sender.tag == 12){
        
    }else{
        [self dismiss];
        ComplaintsViewController * complaints = [[ComplaintsViewController alloc] init];
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
