//
//  SettingViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "SettingViewController.h"
#import "AboutViewController.h"
#import "WebViewController.h"
#import "SettingCell.h"
#import "UpdateAlertView.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong) NSArray * titleArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"关于我们",@"版本更新",@"用户协议",@"隐私政策",@"注销账户"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SettingCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SettingCell class])];
    self.tableView.tableFooterView = [self tableFooterView];
    
}

- (UIView *)tableFooterView{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 99)];
    UIButton * exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame = CGRectMake(15, 50, SCREEN_WIDTH-30, 49);
    [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitButton.backgroundColor = [PreHelper colorWithHexString:@"#FF664B"];
    exitButton.layer.cornerRadius = 5;
    exitButton.layer.masksToBounds = true;
    exitButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [exitButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:exitButton];
    return footerView;
}

- (void)logout{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否注销当前账号" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UserManager deleteUser];
        if ([[DeviceTool shareInstance].reviewStatus isEqualToString:REVIEWING]) {
            [PreHelper pushToTabbarController];
        }else{
            [PreHelper pushToWechatLoginController];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:doneAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SettingCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.detailIcon.image = [UIImage imageNamed:@"setting_cell_more"];
    cell.detailIconWidth.constant = 5.5;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AboutViewController * about = [[AboutViewController alloc] init];
        about.title = @"关于我们";
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.row == 1){
        [self getAppUpdateVersion];
    }else if (indexPath.row == 2) {
        WebViewController * web = [[WebViewController alloc] initWithHtml:[NetworkUrlGetter getUserAgreementUrl]];
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 3) {
        WebViewController * web = [[WebViewController alloc] initWithHtml:[NetworkUrlGetter getPrivacyPolicyUrl]];
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 4){
        [self logout];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

/// 版本更新
- (void)getAppUpdateVersion{
    [NetworkWorker networkGet:[NetworkUrlGetter getAppVersion] success:^(NSDictionary *result) {
        
        NSArray * list = result[@"List"];
        
        if (list.count == 0) {
            return;
        }
        
        NSDictionary * updateInfo = list.firstObject;
        
        NSString * currentVersionString = [DeviceTool shareInstance].appVersion;
        NSString * onlineVersionString = updateInfo[@"title"];
        
        if ([currentVersionString isEqualToString:onlineVersionString]) {
            [self.view makeToast:@"已是最新版本"];
            return;
        }
        
        if (currentVersionString.length < onlineVersionString.length) {
            currentVersionString = [currentVersionString stringByAppendingString:@".0"];
        }else if (onlineVersionString.length < currentVersionString.length){
            onlineVersionString = [onlineVersionString stringByAppendingString:@".0"];
        }
        
        NSInteger currentVersion = [currentVersionString stringByReplacingOccurrencesOfString:@"." withString:@""].integerValue;
        NSInteger onlineVersion = [onlineVersionString stringByReplacingOccurrencesOfString:@"." withString:@""].integerValue;
        
        if (currentVersion < onlineVersion) {
            [self showUpdateView:updateInfo];
        }
        
    } failure:^(NSString *errorMessage) {
        
    }];
}

- (void)showUpdateView:(NSDictionary *)result{
    [UpdateAlertView showUpdateAlertViewWithData:result];
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
