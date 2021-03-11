//
//  CircleViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "CircleViewController.h"
#import "ComplaintsViewController.h"
#import "CircleHeaderCell.h"
#import "CircleContentCell.h"
#import "CircleStatusCell.h"
#import "CircleMoreCell.h"
#import "CircleNineImageCell.h"
#import "CircleMoreActionAlertView.h"
#import "AddFriendAlertView.h"

@interface CircleViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong) UIImageView * coverImageView;
@property(nonatomic,strong) UIImageView * avatarImageView;

@end

@implementation CircleViewController

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL hidden = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:hidden animated:NO];
}

- (UIImageView *)coverImageView{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 330)];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}

- (UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-85, 278, 70, 70)];
        _avatarImageView.layer.cornerRadius = 8;
        _avatarImageView.layer.masksToBounds = true;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.dataArray = [[NSMutableArray alloc] init];
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    NSDictionary * dict = @{
        @"content":@"拉库房阿里积分垃圾了法律上看见放辣椒拉减肥垃圾垃圾"
    };
    [self.dataArray addObject:dict];
    
    NSDictionary * dict2 = @{
        @"content":@"拉库房阿里积分垃圾了法律上垃圾垃圾房间爱了就垃圾阿拉基垃圾平均分假发票忘记放设计费配偶无分机安静泡脚搜啊就撒;就是解放路卡解放啦撒酒疯拉进来看家里放假拉丝机弗兰克斯家乐福阿里积分放假阿里"
    };
    [self.dataArray addObject:dict];
    [self.dataArray addObject:dict2];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleContentCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleStatusCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleStatusCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleMoreCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleMoreCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleNineImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleNineImageCell class])];
    
    UIView * headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
    headerView.backgroundColor = UIColor.whiteColor;
    [headerView addSubview:self.coverImageView];
    [headerView addSubview:self.avatarImageView];
    self.tableView.tableHeaderView = headerView;
    
    [ImageLoader loadImage:self.coverImageView url:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=163656268,2073708275&fm=26&gp=0.jpg" placeholder:nil];
    [ImageLoader loadImage:self.avatarImageView url:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3043529068,4013011478&fm=26&gp=0.jpg" placeholder:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * object = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        CircleHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleHeaderCell class]) forIndexPath:indexPath];
        return cell;
    }else if(indexPath.row == 1){
        CircleContentCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleContentCell class]) forIndexPath:indexPath];
        cell.contentLabel.text = object[@"content"];
        return cell;
    }else if(indexPath.row == 2){
        CircleStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleStatusCell class]) forIndexPath:indexPath];
        return cell;
    }else if(indexPath.row == 3){
        CircleNineImageCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleNineImageCell class]) forIndexPath:indexPath];
        return cell;
    }
    
    else{
        CircleMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleMoreCell class]) forIndexPath:indexPath];
        [cell.addFriendButton addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreButton addTarget:self action:@selector(circleMoreAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)addFriendAction:(UIButton *)btn{
    CircleMoreCell * cell = (CircleMoreCell *)[[btn superview] superview];
    AddFriendAlertView * alertView = [[AddFriendAlertView alloc] init];
}

- (void)circleMoreAction:(UIButton *)btn{
    [self.view.window addSubview:[CircleMoreActionAlertView showMoreAcrionAlertViewWithId:@""]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [self.dataArray objectAtIndex:indexPath.section];
    return [CircleBaseCell cellHeightWithIndexPath:indexPath dataModel:object];;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ComplaintsViewController * complaint = [[ComplaintsViewController alloc] init];
    complaint.title = @"违规举报";
    complaint.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:complaint animated:true];
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
