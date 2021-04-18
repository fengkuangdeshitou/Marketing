//
//  InvitationViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import "InvitationViewController.h"
#import "InvitationListCell.h"
#import "InvitationModel.h"

@interface InvitationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,weak)IBOutlet UIButton * hasPaymentButton;
@property(nonatomic,strong) NSMutableArray * dataArray;
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
    
    self.page = 1;
    self.monthMoneyLabel.text = self.monthMoney;
    self.totalMoneyLabel.text = self.totalMoney;
    self.myShareCountLabel.text = self.myShareCount;
    self.tableView.rowHeight = 68;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InvitationListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([InvitationListCell class])];
    [self isBuyAction:self.hasPaymentButton];
}

- (void)loadDataWithParams:(NSDictionary *)params{
    NSMutableDictionary * mutablePatams = [NSMutableDictionary dictionaryWithDictionary:params];
    [mutablePatams setValue:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
    [mutablePatams setValue:@"10" forKey:@"limit"];
    [NetworkWorker networkPost:[NetworkUrlGetter getMyShareRecordUrl] params:mutablePatams success:^(NSDictionary *result) {
        if (self.page == 1){
            self.dataArray = [[NSMutableArray alloc] init];
        }
        NSArray * list = result[@"page"][@"list"];
        [self.dataArray addObjectsFromArray:[InvitationModel mj_objectArrayWithKeyValuesArray:list]];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
}

/// 购买数据
/// @param sender 按钮
- (IBAction)isBuyAction:(UIButton *)sender{
    [sender addSubview:self.flagView];
    self.page = 1;
    NSDictionary * params = @{@"isBuy":@"y"};
    [self loadDataWithParams:params];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadDataWithParams:params];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self loadDataWithParams:params];
    }];
}

/// 注册数据
/// @param sender 按钮
- (IBAction)isLoginAction:(UIButton *)sender{
    [sender addSubview:self.flagView];
    self.page = 1;
    [self loadDataWithParams:@{}];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadDataWithParams:@{}];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self loadDataWithParams:@{}];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvitationListCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InvitationListCell class]) forIndexPath:indexPath];
    InvitationModel * model = self.dataArray[indexPath.row];
    cell.model = model;
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
