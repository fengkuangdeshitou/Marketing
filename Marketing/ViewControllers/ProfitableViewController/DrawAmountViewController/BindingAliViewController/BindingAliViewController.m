//
//  BindingAliViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/10.
//

#import "BindingAliViewController.h"

@interface BindingAliViewController ()

@property(nonatomic,weak)IBOutlet UITextField * nameTextField;
@property(nonatomic,weak)IBOutlet UITextField * accountTextField;

@end

@implementation BindingAliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)doneAction:(UIButton *)sender{
    if (self.nameTextField.text.length == 0) {
        [self.view makeToast:@"请输入账号"];
        return;
    }
    if (self.accountTextField.text.length == 0) {
        [self.view makeToast:@"请输入账号"];
        return;
    }
    NSString * url = @"http://file.weceinfo.com/img/assets/alipay_icon.png";
    [NetworkWorker networkPost:[NetworkUrlGetter getAddBankUrl] params:@{@"bankName":@"支付宝",@"bankNo":self.accountTextField.text,@"bankUser":self.nameTextField.text,@"alipay_icon":url,@"iconUrl":url} success:^(NSDictionary *result) {
        [self.view makeToast:@"绑定成功"];
        BankModel * model = [[BankModel alloc] init];
        model.bank_user = self.nameTextField.text;
        model.bank_no = self.accountTextField.text;
        model.mb_bank_id = result[@"mbBankId"];
        model.icon_url = url;
        if (self.delegate && [self.delegate respondsToSelector:@selector(onBindAliSuccessWithModel:)]) {
            [self.delegate onBindAliSuccessWithModel:model];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
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
