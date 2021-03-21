//
//  BindingMobileViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/10.
//

#import "BindingMobileViewController.h"

@interface BindingMobileViewController ()

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger time;
@property(nonatomic,weak)IBOutlet UIButton * codeButton;
@property(nonatomic,weak)IBOutlet UITextField * mobileTextfield;
@property(nonatomic,weak)IBOutlet UITextField * codeTextfield;

@end

@implementation BindingMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.time = 60;
    self.codeButton.layer.cornerRadius = 15;
    self.codeButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.codeButton.layer.borderWidth = 0.5;
}

- (IBAction)sendCode:(UIButton *)sender{
    if (self.mobileTextfield.text.length == 0) {
        [self.view makeToast:@"请输入手机号码"];
        return;
    }
    
    if (self.mobileTextfield.text.length != 11) {
        [self.view makeToast:@"请输入正确的手机号码"];
        return;
    }
    [NetworkWorker networkGet:[NetworkUrlGetter getVerificationCodeUrlWithTell:self.mobileTextfield.text] success:^(NSDictionary *result) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:true];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
    
}

- (void)timeChange{
    if (self.time > 1) {
        self.time--;
        [self.codeButton setTitle:[NSString stringWithFormat:@"%ld秒",self.time] forState:UIControlStateNormal];
        self.codeButton.userInteractionEnabled = NO;
    }else{
        self.time = 60;
        [self.timer invalidate];
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeButton.userInteractionEnabled = YES;
    }
}

- (IBAction)doneAction:(UIButton *)sender{
    if (self.mobileTextfield.text.length == 0) {
        [self.view makeToast:@"请输入手机号码"];
        return;
    }
    
    if (self.mobileTextfield.text.length != 11) {
        [self.view makeToast:@"请输入正确的手机号码"];
        return;
    }
    
    if (self.codeTextfield.text.length == 0) {
        [self.view makeToast:@"请输入验证码"];
        return;
    }
    [NetworkWorker networkPost:[NetworkUrlGetter getBindPhoneUrl] params:@{@"phone":self.mobileTextfield.text,@"code":self.codeTextfield.text} success:^(NSDictionary *result) {
        [self.view makeToast:@"绑定成功" duration:2 position:@"bottom"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
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
