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
    [NetworkWorker networkPost:[NetworkUrlGetter getAddBankUrl] params:@{@"bankName":@"支付宝",@"bankNo":self.accountTextField.text,@"bankUser":self.nameTextField.text} success:^(NSDictionary *result) {
        [self.view makeToast:@"绑定成功"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onBindAliSuccess)]) {
            [self.delegate onBindAliSuccess];
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
