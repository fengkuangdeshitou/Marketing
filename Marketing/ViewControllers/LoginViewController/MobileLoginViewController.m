//
//  MobileLoginViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "MobileLoginViewController.h"

@interface MobileLoginViewController ()

@property(nonatomic,weak)IBOutlet UIButton * sendCodeButton;

@end

@implementation MobileLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.sendCodeButton.layer.borderWidth = 1;
    self.sendCodeButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.sendCodeButton.layer.cornerRadius = 14.5;
    self.sendCodeButton.layer.masksToBounds = true;
    
}

/// 发送验证码
/// @param sender 按钮
- (IBAction)sendVerificationCode:(UIButton *)sender{
    
}

/// 账号密码登录
/// @param sender 按钮
- (IBAction)login:(UIButton *)sender{
    [PreHelper pushToTabbarController];
}

/// 返回三方登录
/// @param sender 按钮
- (IBAction)threePartiesLogin:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:true];
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
