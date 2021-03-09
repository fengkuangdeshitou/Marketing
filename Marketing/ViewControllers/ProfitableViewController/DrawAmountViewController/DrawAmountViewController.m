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

@end

@implementation DrawAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem * history = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(drawAmountHistory)];
    self.navigationItem.rightBarButtonItem = history;
    
}

- (void)drawAmountHistory{
    DrawAmountListViewController * list = [[DrawAmountListViewController alloc] init];
    list.title = @"提现记录";
    [self.navigationController pushViewController:list animated:true];
}

- (IBAction)drawAction:(UIButton *)sender{
    
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
