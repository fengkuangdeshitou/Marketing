//
//  AboutViewController.m
//  Marketing
//
//  Created by maiyou on 2021/4/15.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSArray * titleArray;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleArray = @[
        @{@"title":@"官方网站", @"value":@"www.wecein.com"},
        @{@"title":@"客服电话", @"value":@"029-85792545"},
        @{@"title":@"联系邮箱", @"value":@"wekefu@weceinfo.com"}
    ];
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.centerX - 32, headerView.centerY - 50, 64, 64)];
    imageView.image = [UIImage imageNamed:@"AppIcon60x60"];
    imageView.layer.cornerRadius = 6;
    imageView.layer.masksToBounds = YES;
    [headerView addSubview:imageView];
    
    UILabel * versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame) + 15, SCREEN_WIDTH - 40, 20)];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.text = [NSString stringWithFormat:@"V %@", [DeviceTool shareInstance].appVersion];
    versionLabel.textColor = [PreHelper colorWithHexString:@"#666666"];
    versionLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:versionLabel];
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"AboutTableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArray[indexPath.row][@"title"];
    cell.textLabel.textColor = [PreHelper colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.detailTextLabel.text = self.titleArray[indexPath.row][@"value"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
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
