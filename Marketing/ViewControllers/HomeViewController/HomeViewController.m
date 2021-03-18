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

@interface HomeViewController ()<UISearchBarDelegate>

@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,weak)IBOutlet UIButton * beforeButton;
@property(nonatomic,weak)IBOutlet UIButton * nextButton;
@property(nonatomic,weak)IBOutlet UILabel * contentLabel;
@property(nonatomic,weak)IBOutlet UILabel * timeLabel;
@property(nonatomic,weak)IBOutlet UILabel * pageLabel;
@property(nonatomic,weak)IBOutlet UIImageView * icon;
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
    self.beforeButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.beforeButton.layer.borderWidth = 1;
    
    [self addObserver:self forKeyPath:@"currentFlag" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(15, 7, SCREEN_WIDTH-70, 30)];
    searchView.layer.cornerRadius = 5;
    searchView.layer.borderColor = [PreHelper colorWithHexString:@"#DEDEDE"].CGColor;
    searchView.layer.borderWidth = 0.5;
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:searchView.bounds];
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入关键字进行搜索";
    searchBar.backgroundImage = [UIImage new];
    [searchView addSubview:searchBar];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:searchView];
    self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem * downloadItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_download"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = downloadItem;
    
    [[self.segmentView viewWithTag:10] addSubview:self.flagView];
    
    self.contentLabel.text = @"Peachcon元宵节特惠活动图版任选两副¥188，活动时间：2月19日~3月5日晚17点结束";
    [ImageLoader loadImage:self.icon url:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1760198708,397765846&fm=26&gp=0.jpg" placeholder:nil];
    self.timeLabel.text = [NSString stringWithFormat:@"木木 发表于%@",[PreHelper compareCurrentTime:1615476018]];
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
}

- (void)rightItemClick{
    [DownloadAlertView showDownloadAlertViewWithUrl:@"htto"];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [ImageLoader loadImage:self.icon url:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1760198708,397765846&fm=26&gp=0.jpg" placeholder:nil];
    if (self.currentFlag == 0) {
        self.beforeButton.enabled = NO;
    }else if (self.currentFlag == self.dataArray.count) {
        self.nextButton.enabled = NO;
    }else{
        self.beforeButton.enabled = YES;
        self.nextButton.enabled = YES;
    }
}

- (IBAction)beforeAction:(id)sender{
    if (self.currentFlag > 0) {
        self.currentFlag--;
    }
}

- (IBAction)nextAction:(id)sender{
    if (self.currentFlag < self.dataArray.count) {
        self.currentFlag ++;
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"currentFlag"];
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
