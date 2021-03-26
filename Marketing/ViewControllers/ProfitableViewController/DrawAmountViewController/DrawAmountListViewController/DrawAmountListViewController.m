//
//  DrawAmountListViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import "DrawAmountListViewController.h"
#import "DrawAmountListCell.h"

@interface DrawAmountListViewController ()<UITableViewDelegate>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,weak)IBOutlet UILabel * availableLabel;
@property(nonatomic,weak)IBOutlet UILabel * alreadyLabel;
@property(nonatomic,strong)NSArray * dataArray;

@end

@implementation DrawAmountListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DrawAmountListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DrawAmountListCell class])];
    self.tableView.rowHeight = 50;
    [self getDrawRecord];
    [self getMymoney];
}

/// 提现记录
- (void)getDrawRecord{
    [NetworkWorker networkPost:[NetworkUrlGetter getMyDrawRecordUrl] params:@{@"page":@"1",@"limit":@"20"} success:^(NSDictionary *result) {
            
    } failure:^(NSString *errorMessage) {
        
    }];
}

/// 查询余额
- (void)getMymoney{
    [NetworkWorker networkGet:[NetworkUrlGetter getMyMoneyUrl] success:^(NSDictionary *result) {
        self.availableLabel.text = [NSString stringWithFormat:@"%@",result[@"myMoney"]];
        self.alreadyLabel.text = [NSString stringWithFormat:@"%@",result[@"myDraw"]];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DrawAmountListCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DrawAmountListCell class]) forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
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
