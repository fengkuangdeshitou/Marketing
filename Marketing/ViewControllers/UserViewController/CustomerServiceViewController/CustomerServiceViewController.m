//
//  CustomerServiceViewController.m
//  Marketing
//
//  Created by maiyou on 2021/3/12.
//

#import "CustomerServiceViewController.h"
#import "CustomerServiceCell.h"
#import "ServiceAlertView.h"

@interface CustomerServiceViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet NSLayoutConstraint * backButtonTopConstraint;
@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation CustomerServiceViewController

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL hidden = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.delegate = self;
    self.backButtonTopConstraint.constant = StatusBarHeight;
    self.dataArray = @[@{@"title":@" 1、我已经买了会员，为什么还提示要开通会员？",@"content":@"会员等级不同对应的权限不同，请在会员中心查看不同会员对应的功能权限 。"}];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomerServiceCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CustomerServiceCell class])];
}

- (IBAction)backViewController:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}

/// 联系客服弹框
/// @param sender 点击手势
- (IBAction)showServiceAlert:(UITapGestureRecognizer *)sender{
    [ServiceAlertView showServiceAlertView];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomerServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomerServiceCell class]) forIndexPath:indexPath];
    
    cell.isShowContent = self.selectedIndex == indexPath.row;
    cell.dataDic = self.dataArray[indexPath.row];
    cell.moreBtnBlock = ^{
        if (self.selectedIndex != indexPath.row){
            self.selectedIndex = indexPath.row;
        }else{
            self.selectedIndex = -1;
        }
        [tableView reloadData];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.navigationController popViewControllerAnimated:true];
    if (self.selectedIndex == indexPath.row){
//            MyServiceDetailController * detail = [MyServiceDetailController new];
//            detail.dataDic = self.dataArray[indexPath.row];
//            detail.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:detail animated:YES];
    }else{
        self.selectedIndex = indexPath.row;
        [self.tableView reloadData];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    view.backgroundColor = [PreHelper colorWithHexString:@"#F6F6F6"];

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, view.height)];
    label.text = @"常见问题";
    label.textColor = [PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR];
    label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [view addSubview:label];

    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.selectedIndex == indexPath.row ? 100 : 44;
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
