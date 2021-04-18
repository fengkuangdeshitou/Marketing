//
//  HomeViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "HomeViewController.h"
#import "SettingViewController.h"
#import "SearchViewController.h"
#import "CustomNavagationController.h"
#import "DownloadAlertView.h"
#import "GroupModel.h"

@interface HomeViewController ()<UISearchBarDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,weak)IBOutlet UIButton * beforeButton;
@property(nonatomic,weak)IBOutlet UIButton * nextButton;
@property(nonatomic,weak)IBOutlet UIButton * todayButton;
@property(nonatomic,weak)IBOutlet UIButton * yesterdayButton;
@property(nonatomic,weak)IBOutlet UIButton * moreButton;
@property(nonatomic,weak)IBOutlet UILabel * contentLabel;
@property(nonatomic,weak)IBOutlet UILabel * timeLabel;
@property(nonatomic,weak)IBOutlet UILabel * pageLabel;
@property(nonatomic,weak)IBOutlet UIImageView * icon;
@property(nonatomic,assign)NSInteger page;
/// 1:今天,2:昨天,3:更早
@property(nonatomic,assign)NSInteger time;
@property(nonatomic,assign)NSInteger currentFlag;
@property(nonatomic,strong)UIView * flagView;
@property(nonatomic,weak)IBOutlet UIView * segmentView;

@end

@implementation HomeViewController

- (UIView *)flagView{
    if (!_flagView) {
        _flagView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6-13, 46, 26, 3)];
        _flagView.backgroundColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR];
    }
    return _flagView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.currentFlag = 0;
    self.page = 1;
    self.time = 1;
    
    self.beforeButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.beforeButton.layer.borderWidth = 1;
        
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(15, 7, SCREEN_WIDTH-70, 30)];
    searchView.layer.cornerRadius = 5;
    searchView.layer.borderColor = [PreHelper colorWithHexString:@"#DEDEDE"].CGColor;
    searchView.layer.borderWidth = 0.5;
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:searchView.bounds];
    searchBar.delegate = self;
    if (@available(iOS 13.0, *)) {
        searchBar.searchTextField.font = [UIFont systemFontOfSize:14];
    } else {
        // Fallback on earlier versions
    }
    searchBar.placeholder = @"请输入关键字进行搜索";
    searchBar.backgroundImage = [UIImage new];
    [searchView addSubview:searchBar];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:searchView];
    self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem * downloadItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_download"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = downloadItem;
    
    [[self.segmentView viewWithTag:10] addSubview:self.flagView];
    
    [self getFindGroupList];
}

- (void)getFindGroupList{
    [NetworkWorker networkPost:[NetworkUrlGetter getFindGroupListUrl] params:@{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],@"limit":@"1",@"wxgType":@"group",@"direction":@"random",@"time":[NSString stringWithFormat:@"%d",self.time]} success:^(NSDictionary *result) {
        if (self.page == 1) {
            self.dataArray = [[NSMutableArray alloc] init];
        }
        NSArray * list = result[@"page"][@"list"];
        NSArray * modelArray = [GroupModel mj_objectArrayWithKeyValuesArray:list];
        [self.dataArray addObject:modelArray.firstObject];
        [self formatNumber];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

- (void)formatNumber{
    GroupModel * model = self.dataArray[self.currentFlag];
    [ImageLoader loadImage:self.icon url:model.img_urls placeholder:nil];
    self.contentLabel.text = model.wxg_desc;
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 发表于%@",model.nickname,[PreHelper dateFromString:model.add_time]];
    self.pageLabel.text = [NSString stringWithFormat:@"%d/999",self.dataArray.count];
    self.currentFlag ++;
}

/// 日期切换
/// @param sender 按钮
- (IBAction)segmengClick:(UIButton *)sender{
    for (UIView * subview in self.segmentView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            ((UIButton *)subview).titleLabel.font = [UIFont systemFontOfSize:16];
            [((UIButton *)subview) setTitleColor:[PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR] forState:UIControlStateNormal];
        }
    }
    [sender setTitleColor:[PreHelper colorWithHexString:COLOR_MAIN_COLOR] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [sender addSubview:self.flagView];
    if (sender == self.todayButton) {
        self.time = 1;
    }else if(sender == self.yesterdayButton){
        self.time = 2;
    }else{
        self.time = 3;
    }
    self.page = 1;
    self.currentFlag = 0;
    [self getFindGroupList];
}

/// 下载
- (void)rightItemClick{
    [DownloadAlertView showDownloadAlertView];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchViewController * search = [[SearchViewController alloc] init];
    search.hidesBottomBarWhenPushed = true;
    CustomNavagationController * nav = [[CustomNavagationController alloc] initWithRootViewController:search];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:true completion:^{
            
    }];
    return NO;
}

/// 上一张
/// @param sender 按钮
- (IBAction)beforeAction:(id)sender{
    if (self.currentFlag > 1) {
        self.currentFlag--;
    }
    [self formatNumber];
}

/// 下一张
/// @param sender 按钮
- (IBAction)nextAction:(id)sender{
    self.page++;
    [self getFindGroupList];
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
