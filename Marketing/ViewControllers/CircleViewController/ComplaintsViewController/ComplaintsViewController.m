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

@interface ComplaintsViewController ()<UITableViewDelegate,UITableViewDataSource>

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ComplaintReasonHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintReasonHeaderCell class]) forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 1){
        ComplaintReasonCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintReasonCell class]) forIndexPath:indexPath];
        return cell;
    }else{
        ComplaintImageCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintImageCell class]) forIndexPath:indexPath];
        return cell;
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
