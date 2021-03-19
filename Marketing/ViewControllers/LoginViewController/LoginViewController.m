//
//  LoginViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "LoginViewController.h"
#import "MobileLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <WechatConnector/WechatConnector.h>

@interface LoginViewController ()

@property(nonatomic,weak)IBOutlet UIImageView * appIconImageView;
@property(nonatomic,weak)IBOutlet UIButton * wechatLoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.appIconImageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.appIconImageView.layer.shadowColor = [PreHelper colorWithHexString:@"#CC341A"].CGColor;
    self.appIconImageView.layer.shadowRadius = 5;
    self.appIconImageView.layer.shadowOpacity = 0.3;
    
    self.wechatLoginButton.layer.cornerRadius = 5;
    self.wechatLoginButton.layer.masksToBounds = true;
    self.wechatLoginButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.wechatLoginButton.layer.borderWidth = 1;
    
    [WeChatConnector setRequestAuthTokenOperation:^(NSString *authCode, void (^getUserinfo)(NSString *uid, NSString *token)) {
        [self loginWithCode:authCode];
    }];
    
}


/// 切换手机号登录
/// @param sender 按钮
- (IBAction)mobileLogin:(UIButton *)sender{
    MobileLoginViewController * mobile = [[MobileLoginViewController alloc] init];
    [self.navigationController pushViewController:mobile animated:true];
}

/// 微信登录
/// @param sender 按钮
- (IBAction)wechatLogin:(UIButton *)sender{
    [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        switch (state) {
           case SSDKResponseStateSuccess:
                NSLog(@"登录数据:%@",[user.credential rawData]);
                break;
           case SSDKResponseStateFail:
                 {
                    NSLog(@"--%@",error.description);
                    //失败
                    break;
                  }
           case SSDKResponseStateCancel:
                //用户取消授权
                break;
           default:
                break;
        }
    }];
}

- (void)loginWithCode:(NSString *)code{
    [NetworkWorker networkGet:[NetworkUrlGetter getWechatLoginWithCode:code sceneParams:@""] success:^(NSDictionary *dictionary) {
        NSLog(@"===%@",dictionary);
        UserModel * model = [UserModel mj_objectWithKeyValues:dictionary[@"member"]];
        model.token = dictionary[@"token"];
        [UserManager saveUser:model];
        [PreHelper pushToTabbarController];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
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
