//
//  MembersViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "MembersViewController.h"

@interface MembersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong)IBOutlet UITableViewCell * headerCell;
@property(nonatomic,strong)IBOutlet UITableViewCell * interestsCell;
@property(nonatomic,strong)IBOutlet UIView * interestsView;

@end

@implementation MembersViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [PreHelper colorWithHexString:@"#202228"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName:[UIColor whiteColor]
    };
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName:[UIColor blackColor]
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray * titleArray = @[@"以图搜图",@"无限发布",@"无限群发",@"无限工具箱",@"发布视频"];
    for (int i=0; i<titleArray.count; i++) {
        UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake((((SCREEN_WIDTH-38*2-50*4)/3)+50)*(i%4), 95*(i/4), 50, 75)];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_member_%d",i]];
        [contentView addSubview:imageView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75-13, 95, 13)];
        titleLabel.text = titleArray[i];
        titleLabel.textColor = [PreHelper colorWithHexString:@"#282828"];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [contentView addSubview:titleLabel];
        
        [self.interestsView addSubview:contentView];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.headerCell;
    }else{
        return self.interestsCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 422 : 235;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? 5 : 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [[UIView alloc] init];
    footer.backgroundColor = [PreHelper colorWithHexString:@"#F6F5FA"];
    return footer;
}

// 根据颜色生成UIImage
- (UIImage*)imageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开始画图的上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 设置背景颜色
    [color set];
    // 设置填充区域
    UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // 返回UIImage
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
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
