//
//  UserInfoViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "UserInfoViewController.h"
#import "UserInfoHeaderCell.h"
#import "SettingCell.h"

@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong) NSArray * titleArray;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"名称",@"微信号",@"微信绑定手机号",@"微信二维码"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserInfoHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([UserInfoHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SettingCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SettingCell class])];
    self.tableView.tableFooterView = [UIView new];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UserInfoHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoHeaderCell class]) forIndexPath:indexPath];
//        cell.detailIcon.image = [UIImage imageNamed:@"setting_cell_more"];
        return cell;
    }else{
        SettingCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SettingCell class]) forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.detailIcon.image = [UIImage imageNamed:@"setting_cell_more"];
        if (indexPath.row == self.titleArray.count-1) {
            cell.detailIconWidth.constant = 0;
        }else{
            cell.detailIconWidth.constant = 5.5;
        }
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 64 : 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
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
