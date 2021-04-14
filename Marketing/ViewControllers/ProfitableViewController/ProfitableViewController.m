//
//  ProfitableViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import "ProfitableViewController.h"
#import "ProfitHeaderCell.h"
#import "ProfitShareCell.h"
#import "BindingAliViewController.h"
#import "DrawAmountViewController.h"
#import "InvitationViewController.h"
#import "BankModel.h"
#import "ShareModel.h"

@interface ProfitableViewController ()<UITableViewDelegate,UITableViewDataSource,BindingAliViewControllerDelegate,DrawAmountViewControllerDelegate>

@property(nonatomic,strong)UserModel * userModel;
@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,weak)IBOutlet UIView * todayView;
@property(nonatomic,weak)IBOutlet UIView * totalView;
@property(nonatomic,weak)IBOutlet UIView * invitationView;
@property(nonatomic,strong) NSArray * titleArray;

@property(nonatomic,weak)IBOutlet UIImageView * headerImageView;
@property(nonatomic,weak)IBOutlet UILabel * userNameLabel;
@property(nonatomic,weak)IBOutlet UILabel * userIdLabel;
@property(nonatomic,weak)IBOutlet UILabel * moneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * todayMoneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * totalMoneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * myShareCountLabel;

@property(nonatomic,strong)NSDictionary * dataDictionary;
@property(nonatomic,assign)BOOL isBindAli;
@property(nonatomic,strong)BankModel * model;

@end

@implementation ProfitableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"赚钱";
    
    self.userModel = [UserManager getUser];
    [ImageLoader loadImage:self.headerImageView url:self.userModel.headimgurl placeholder:nil];
    self.userNameLabel.text = self.userModel.nickname;
    
    [self addShadowWithView:self.todayView];
    [self addShadowWithView:self.totalView];
    [self addShadowWithView:self.invitationView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProfitHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ProfitHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProfitShareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ProfitShareCell class])];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadShareTextData];
    }];
    
    [self loadMyMoneyData];
    [self getMyBankType];
    [self.tableView.mj_header beginRefreshing];
    
}

/// 分享文案数据
- (void)loadShareTextData{
    [NetworkWorker networkGet:[NetworkUrlGetter getShareTextUrl] success:^(NSDictionary *result) {
        NSArray * list = result[@"List"];
        self.dataArray = [ShareModel mj_objectArrayWithKeyValuesArray:list];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSString *errorMessage) {
        [self.tableView.mj_header endRefreshing];
        [self.view makeToast:errorMessage];
    }];
}

/// 请求余额
- (void)loadMyMoneyData{
    [NetworkWorker networkGet:[NetworkUrlGetter getMyMoneyUrl] success:^(NSDictionary *result) {
        self.dataDictionary = result;
        self.moneyLabel.text = [NSString stringWithFormat:@"%@",result[@"myMoney"]];
        self.totalMoneyLabel.text = [NSString stringWithFormat:@"%@",result[@"totalMoney"]];
        self.myShareCountLabel.text = [NSString stringWithFormat:@"%@人",result[@"myShareCount"]];
        self.todayMoneyLabel.text = [NSString stringWithFormat:@"%@",result[@"todayMoney"]];
    } failure:^(NSString *errorMessage) {
        
    }];
}

/// 查找我的提现方式
- (void)getMyBankType{
    [NetworkWorker networkGet:[NetworkUrlGetter getMyBankUrl] success:^(NSDictionary *result) {
        self.isBindAli = [result[@"List"] count] > 0;
        if (self.isBindAli) {
            self.model = [BankModel mj_objectArrayWithKeyValuesArray:result[@"List"]].firstObject;
        }
    } failure:^(NSString *errorMessage) {
        
    }];
}

/// 提现
/// @param sender 按钮
- (IBAction)drawAmount:(UIButton *)sender{
    if (self.isBindAli) {
        DrawAmountViewController * drawAmount = [[DrawAmountViewController alloc] init];
        drawAmount.title = @"提现";
        self.model.myMoney = self.moneyLabel.text;
        drawAmount.model = self.model;
        drawAmount.delegate = self;
        drawAmount.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:drawAmount animated:true];
    }else{
        BindingAliViewController * binding = [[BindingAliViewController alloc] init];
        binding.title = @"绑定支付宝";
        binding.delegate = self;
        binding.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:binding animated:true];
    }
}

/// 绑定回调
- (void)onBindAliSuccess{
    self.isBindAli = YES;
}

/// 提现成功回调
- (void)onDeawAmountSuccess{
    [self loadMyMoneyData];
}

/// 邀请记录
/// @param sender 按钮
- (IBAction)InvitationAction:(UIButton *)sender{
    InvitationViewController * invitation = [[InvitationViewController alloc] init];
    invitation.title = @"邀请记录";
    invitation.monthMoney = [NSString stringWithFormat:@"%@",self.dataDictionary[@"monthMoney"]];
    invitation.myShareCount = [NSString stringWithFormat:@"%@",self.dataDictionary[@"myShareCount"]];
    invitation.totalMoney = [NSString stringWithFormat:@"%@",self.dataDictionary[@"totalMoney"]];
    invitation.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:invitation animated:true];
}
- (void)addShadowWithView:(UIView *)view{
    view.layer.shadowColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:0.35].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,0);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 5;
    view.layer.cornerRadius = 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareModel * model = self.dataArray[indexPath.section];
    model.index = indexPath.section;
    if (indexPath.row == 0) {
        ProfitHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProfitHeaderCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else{
        ProfitShareCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProfitShareCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return UITableViewAutomaticDimension;
    }else{
        return 71;
    }
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
