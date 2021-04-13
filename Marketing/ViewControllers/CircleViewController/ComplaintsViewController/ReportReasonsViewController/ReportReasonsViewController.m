//
//  ReportReasonsViewController.m
//  Marketing
//
//  Created by maiyou on 2021/4/13.
//

#import "ReportReasonsViewController.h"
#import "ComplaintReasonHeaderCell.h"

@interface ReportReasonsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;

@end

@implementation ReportReasonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ComplaintReasonHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ComplaintReasonHeaderCell class])];
    
    [self loadReasonsData];
    
}

- (void)loadReasonsData{
    [NetworkWorker networkGet:[NetworkUrlGetter getComplaintTypeListUrl] success:^(NSDictionary *result) {
        NSArray * list = [result objectForKey:@"List"];
        self.dataArray = [ComplaintsModel mj_objectArrayWithKeyValuesArray:list];
        [self.tableView reloadData];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ComplaintReasonHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintReasonHeaderCell class]) forIndexPath:indexPath];
    ComplaintsModel * model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.dict_name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ComplaintsModel * model = self.dataArray[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDidSelectedReasonsModel:)]) {
        [self.delegate onDidSelectedReasonsModel:model];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
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
