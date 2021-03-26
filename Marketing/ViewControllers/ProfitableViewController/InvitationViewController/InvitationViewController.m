//
//  InvitationViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import "InvitationViewController.h"
#import "InvitationListCell.h"

@interface InvitationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,weak)IBOutlet UIButton * hasPaymentButton;
@property(nonatomic,strong) NSArray * dataArray;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,strong) UIView * flagView;

@property(nonatomic,weak)IBOutlet UILabel * monthMoneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * totalMoneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * myShareCountLabel;

@end

@implementation InvitationViewController

- (UIView *)flagView{
    if (!_flagView) {
        _flagView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4-25, 40, 50, 1)];
        _flagView.backgroundColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR];
    }
    return _flagView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.page = 0;
    self.monthMoneyLabel.text = self.monthMoney;
    self.totalMoneyLabel.text = self.totalMoney;
    self.myShareCountLabel.text = self.myShareCount;
    self.tableView.rowHeight = 68;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InvitationListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([InvitationListCell class])];
    [self isBuyAction:self.hasPaymentButton];
}

- (void)loadDataWithParams:(NSDictionary *)params{
    [NetworkWorker networkPost:[NetworkUrlGetter getMyShareRecordUrl] params:params success:^(NSDictionary *result) {
            
    } failure:^(NSString *errorMessage) {
        
    }];
}

/// 购买数据
/// @param sender 按钮
- (IBAction)isBuyAction:(UIButton *)sender{
    [sender addSubview:self.flagView];
    self.page = 1;
    [self loadDataWithParams:@{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],@"limit":@"15",@"isBuy":@"y"}];
}

/// 注册数据
/// @param sender 按钮
- (IBAction)isLoginAction:(UIButton *)sender{
    [sender addSubview:self.flagView];
    self.page = 1;
    [self loadDataWithParams:@{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],@"limit":@"15"}];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvitationListCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InvitationListCell class]) forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
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
