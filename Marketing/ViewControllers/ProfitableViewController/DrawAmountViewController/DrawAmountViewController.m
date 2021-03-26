//
//  DrawAmountViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import "DrawAmountViewController.h"
#import "DrawAmountListViewController.h"
#import "BindingAliViewController.h"

@interface DrawAmountViewController ()<BindingAliViewControllerDelegate>

@property(nonatomic,weak)IBOutlet UITextField * textfield;
@property(nonatomic,weak)IBOutlet UILabel * balanceLabel;
@property(nonatomic,weak)IBOutlet UILabel * bankNameLabel;

@end

@implementation DrawAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem * history = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(drawAmountHistory)];
    self.navigationItem.rightBarButtonItem = history;
    
}

- (void)setModel:(BankModel *)model{
    _model = model;
    self.bankNameLabel.text = [NSString stringWithFormat:@"%@  %@",self.model.bank_user,self.model.bank_no];
}

/// 添加账号
/// @param sender 手势
- (IBAction)addAliAmount:(UITapGestureRecognizer *)sender{
    BindingAliViewController * binding = [[BindingAliViewController alloc] init];
    binding.delegate = self;
    binding.title = @"绑定支付宝";
    [self.navigationController pushViewController:binding animated:true];
}

/// 添加账号回调
/// @param model 数据模型
- (void)onBindAliSuccessWithModel:(BankModel *)model{
    self.model = model;
}

/// 提现记录
- (void)drawAmountHistory{
    DrawAmountListViewController * list = [[DrawAmountListViewController alloc] init];
    list.title = @"提现记录";
    [self.navigationController pushViewController:list animated:true];
}

/// 提现
/// @param sender 按钮
- (IBAction)drawAction:(UIButton *)sender{
    
    if (self.model.myMoney.intValue == 0) {
        [self.view makeToast:@"余额不足"];
        return;
    }
    
    if (self.textfield.text.length == 0) {
        [self.view makeToast:@"请输入提现金额"];
        return;
    }
    [NetworkWorker networkGet:[NetworkUrlGetter getMyDrawUrlWithMbBankId:self.model.mb_bank_id money:self.textfield.text] success:^(NSDictionary *result) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onDeawAmountSuccess)]) {
            [self.delegate onDeawAmountSuccess];
        }
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
