//
//  DrawAmountViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import "DrawAmountViewController.h"
#import "DrawAmountListViewController.h"

@interface DrawAmountViewController ()

@property(nonatomic,weak)IBOutlet UITextField * textfield;
@property(nonatomic,weak)IBOutlet UILabel * balanceLabel;
@property(nonatomic,weak)IBOutlet UILabel * bankNameLabel;

@end

@implementation DrawAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.bankNameLabel.text = [NSString stringWithFormat:@"%@  %@",self.model.bank_user,self.model.bank_no];
    UIBarButtonItem * history = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(drawAmountHistory)];
    self.navigationItem.rightBarButtonItem = history;
    
}

- (void)drawAmountHistory{
    DrawAmountListViewController * list = [[DrawAmountListViewController alloc] init];
    list.title = @"提现记录";
    [self.navigationController pushViewController:list animated:true];
}

- (IBAction)drawAction:(UIButton *)sender{
    [NetworkWorker networkGet:[NetworkUrlGetter getMyDrawUrlWithMbBankId:self.model.mb_bank_id money:self.textfield.text] success:^(NSDictionary *result) {
            
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
