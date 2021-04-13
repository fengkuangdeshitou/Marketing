//
//  ComplaintsViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "ComplaintsViewController.h"
#import "ComplaintReasonHeaderCell.h"
#import "ComplaintReasonCell.h"
#import "ComplaintImageCell.h"
#import "ReportReasonsViewController.h"

@interface ComplaintsViewController ()<UITableViewDelegate,UITableViewDataSource,ReportReasonsViewControllerDelegate>

@property(nonatomic,strong)ComplaintsModel * complaintsModel;
@property(nonatomic,weak)IBOutlet UITableView * tableView;

@end

@implementation ComplaintsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ComplaintReasonHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ComplaintReasonHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ComplaintReasonCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ComplaintReasonCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ComplaintImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ComplaintImageCell class])];
    
}

- (void)onDidSelectedReasonsModel:(ComplaintsModel *)model{
    self.complaintsModel = model;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ComplaintReasonHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintReasonHeaderCell class]) forIndexPath:indexPath];
        cell.contentLabel.text = self.complaintsModel.dict_name;
        return cell;
    }else if(indexPath.section == 1){
        ComplaintReasonCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintReasonCell class]) forIndexPath:indexPath];
        return cell;
    }else{
        ComplaintImageCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintImageCell class]) forIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ReportReasonsViewController * reasons = [[ReportReasonsViewController alloc] init];
        reasons.delegate = self;
        reasons.title = @"举报原因";
        [self.navigationController pushViewController:reasons animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 55;
    }else if(indexPath.section == 1){
        return 220;
    }else{
        return 170;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }else if(section == 1){
        return 0.5;
    }else{
        return 0.0001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
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
