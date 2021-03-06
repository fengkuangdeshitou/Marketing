//
//  UserViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "UserViewController.h"
#import "UserHeaderCell.h"
#import "UserCell.h"
#import "CircleViewController.h"
#import "AddValueServicesController.h"
#import "BindingMobileViewController.h"
#import "AuthenticationViewController.h"
#import "UserInfoViewController.h"
#import "SettingViewController.h"
#import "CustomerServiceViewController.h"
#import "MembersViewController.h"
#import "GlobalNotification.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource,AuthenticationViewControllerDelegate>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong) NSArray * titleArray;
@property(nonatomic,strong) UserModel * userModel;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"个人中心";
    self.titleArray = @[@"增值服务",@"我的发布",@"实名认证",@"绑定手机",@"联系客服",@"设置"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessAction) name:NOTIFICATION_LOGIN_SUCCESS object:nil];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([UserHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([UserCell class])];
    self.userModel = [UserManager getUser];
    [self.tableView reloadData];
}

/// 登录成功
- (void)loginSuccessAction{
    self.userModel = [UserManager getUser];
    [self.tableView reloadData];
}

/// 绑定回调
- (void)onAuthemticationSuccess{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UserHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserHeaderCell class]) forIndexPath:indexPath];
        cell.model = self.userModel;
        [cell.memberButton addTarget:self action:@selector(membersAction) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        UserCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserCell class]) forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_title_%d",indexPath.row]];
        if (indexPath.row == 2 && [UserManager getUser].cert_no.length > 0) {
            cell.descLabel.text = @"已认证";
        }else{
            cell.descLabel.text = @"";
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![PreHelper isLogin]) {
        [PreHelper pushToLoginController];
        return;
    }
    if (indexPath.section == 0) {
        UserInfoViewController * userInfo = [[UserInfoViewController alloc] init];
        userInfo.title = @"我的个人名片";
        userInfo.reloadUserInfo = ^{
            self.userModel = [UserManager getUser];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        userInfo.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:userInfo animated:true];
    }else{
        if (indexPath.row == 0) {
            AddValueServicesController * services = [[AddValueServicesController alloc] init];
            services.title = @"增值服务";
            services.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:services animated:true];
        }else if(indexPath.row == 1){
            CircleViewController * circle = [[CircleViewController alloc] initWithUserId:[UserManager getUser].mb_id];
            circle.title = @"我的发布";
            circle.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:circle animated:true];
        }else if (indexPath.row == 2){
            if ([UserManager getUser].cert_no.length > 0) {
                return;
            }
            AuthenticationViewController * authentication = [[AuthenticationViewController alloc] init];
            authentication.title = @"实名认证";
            authentication.delegate = self;
            authentication.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:authentication animated:true];
        }else if (indexPath.row == 3){
            BindingMobileViewController * binding = [[BindingMobileViewController alloc] init];
            binding.title = @"绑定手机";
            binding.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:binding animated:true];
        }else if (indexPath.row == 4){
            CustomerServiceViewController * server = [[CustomerServiceViewController alloc] init];
            server.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:server animated:true];
        }else if (indexPath.row == 5) {
            SettingViewController * setting = [[SettingViewController alloc] init];
            setting.title = @"设置";
            setting.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:setting animated:true];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 168 : 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

/// 会员中心
- (void)membersAction{
    if (![PreHelper isLogin]) {
        [PreHelper pushToLoginController];
        return;
    }
    MembersViewController * memeber = [[MembersViewController alloc] init];
    memeber.title = @"会员中心";
    memeber.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:memeber animated:true];
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
