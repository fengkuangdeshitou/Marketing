//
//  EditUserInfoViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/16.
//

#import "EditUserInfoViewController.h"

@interface EditUserInfoViewController ()

@property(nonatomic,weak)IBOutlet UITextField * textField;

@end

@implementation EditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.title];
}

- (IBAction)updateUserInfo:(UIButton*)sender{
    if (self.editBlock) {
        self.editBlock(self.textField.text);
    }
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
