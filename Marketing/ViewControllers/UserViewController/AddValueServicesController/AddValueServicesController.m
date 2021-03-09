//
//  AddValueServicesController.m
//  Marketing
//
//  Created by maiyou on 2021/3/9.
//

#import "AddValueServicesController.h"

@interface AddValueServicesController ()

@property(nonatomic,weak)IBOutlet UIButton * downloadButton;
@property(nonatomic,weak)IBOutlet UIButton * createButton;

@property(nonatomic,weak)IBOutlet UILabel * remainingDownloadLabel;
@property(nonatomic,weak)IBOutlet UILabel * remainingCreateLabel;
@property(nonatomic,strong)UIView * flagView;


@end

@implementation AddValueServicesController

- (UIView *)flagView{
    if (!_flagView) {
        _flagView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4-40, 36, 80, 1)];
        _flagView.backgroundColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR];
    }
    return _flagView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self topupItem:self.downloadButton];
    
}

/// 充值类型
/// @param sender 按钮
- (IBAction)topupItem:(UIButton *)sender{
    [self.downloadButton setTitleColor:[PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR] forState:UIControlStateNormal];
    [self.createButton setTitleColor:[PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR] forState:UIControlStateNormal];
    [sender setTitleColor:[PreHelper colorWithHexString:COLOR_MAIN_COLOR] forState:UIControlStateNormal];
    [sender addSubview:self.flagView];
}

/// 微信支付
/// @param sender 按钮
- (IBAction)wechatAction:(UIButton *)sender{
    
}

/// 支付宝支付
/// @param sender 按钮
- (IBAction)aliAction:(UIButton *)sender{
    
}

/// 苹果支付
/// @param sender 按钮
- (IBAction)appleAction:(UIButton *)sender{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
