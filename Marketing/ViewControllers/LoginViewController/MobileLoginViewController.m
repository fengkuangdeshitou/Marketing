//
//  MobileLoginViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "MobileLoginViewController.h"

@interface MobileLoginViewController ()<UINavigationControllerDelegate>

@property(nonatomic,weak)IBOutlet UITextField * tellTextfield;
@property(nonatomic,weak)IBOutlet UITextField * codeTextfield;
@property(nonatomic,weak)IBOutlet UIButton * sendCodeButton;
@property(nonatomic,assign)NSInteger timeNumber;
@property(nonatomic,strong)NSTimer * timer;

@end

@implementation MobileLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.delegate = self;
    self.timeNumber = 60;
    self.sendCodeButton.layer.borderWidth = 1;
    self.sendCodeButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.sendCodeButton.layer.cornerRadius = 14.5;
    self.sendCodeButton.layer.masksToBounds = true;
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL isHidden = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isHidden animated:YES];
}

- (void)dealloc{
    [self.timer invalidate];
}

/// 发送验证码
/// @param sender 按钮
- (IBAction)sendVerificationCode:(UIButton *)sender{
    if (self.tellTextfield.text == 0) {
        [self.view makeToast:@"请输入手机号"];
        return;
    }
    if (self.tellTextfield.text.length != 11) {
        [self.view makeToast:@"请输入正确的手机号"];
        return;
    }
    sender.userInteractionEnabled = NO;
    
    [NetworkWorker networkGet:[NetworkUrlGetter getVerificationCodeUrlWithTell:self.tellTextfield.text] success:^(NSDictionary *result) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

/// 短信倒计时
- (void)timeChange{
    if (self.timeNumber > 1) {
        self.timeNumber --;
        self.sendCodeButton.userInteractionEnabled = NO;
        [self.sendCodeButton setTitle:[NSString stringWithFormat:@"%ld秒",self.timeNumber] forState:UIControlStateNormal];
    }else{
        [self.timer invalidate];
        [self.sendCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.timeNumber = 60;
        self.sendCodeButton.userInteractionEnabled = YES;
    }
}

/// 账号密码登录
/// @param sender 按钮
- (IBAction)login:(UIButton *)sender{
    if (self.tellTextfield.text.length == 0) {
        [self.view makeToast:@"请输入手机号"];
        return;
    }
    if (self.tellTextfield.text.length != 11) {
        [self.view makeToast:@"请输入正确的手机号"];
        return;
    }
    if (self.codeTextfield.text.length == 0) {
        [self.view makeToast:@"请输入验证码"];
        return;
    }
    
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary:[[DeviceTool shareInstance] mj_JSONObject]];
    [params setValue:self.codeTextfield.text forKey:@"code"];
    [params setValue:self.tellTextfield.text forKey:@"phone"];
    [params setValue:@"" forKey:@"sceneParams"];/// 深度链参数
    [NetworkWorker networkPost:[NetworkUrlGetter getCodeLoginUrl] params:params success:^(NSDictionary *result) {
        UserModel * model = [UserModel mj_objectWithKeyValues:result[@"member"]];
        model.token = result[@"token"];
        [UserManager saveUser:model];
        [PreHelper pushToTabbarController];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
    
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
