//
//  InvitationViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import "InvitationViewController.h"
#import "InvitationListCell.h"

@interface InvitationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong) NSArray * dataArray;

@end

@implementation InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.rowHeight = 68;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InvitationListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([InvitationListCell class])];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvitationListCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InvitationListCell class]) forIndexPath:indexPath];
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
