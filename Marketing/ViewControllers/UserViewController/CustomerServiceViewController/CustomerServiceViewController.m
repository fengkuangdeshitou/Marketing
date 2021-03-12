//
//  CustomerServiceViewController.m
//  Marketing
//
//  Created by maiyou on 2021/3/12.
//

#import "CustomerServiceViewController.h"
#import "CustomerServiceCell.h"

@interface CustomerServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation CustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

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

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 1)
//    {
//        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
//        view.backgroundColor = [UIColor whiteColor];
//
//        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenW - 30, view.height)];
//        label.text = @"常见问题";
//        label.textColor = FontColor28;
//        label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
//        [view addSubview:label];
//
//        return view;
//    }
//    return [UIView new];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0.001 : 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 52;
    }
    return UITableViewAutomaticDimension;
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
