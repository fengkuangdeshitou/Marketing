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
#import "MemberAlertView.h"
#import "MembersViewController.h"
#import "TermsServiceAlertView.h"

@interface HomeViewController ()<UISearchBarDelegate,MemberAlertViewDelegate,MembersViewControllerDelegate>

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
@property(nonatomic,strong)NSDictionary * numberDataDictionary;
/// 1:今天,2:昨天,3:更早
@property(nonatomic,assign)NSInteger time;
@property(nonatomic,strong)UIView * flagView;
@property(nonatomic,weak)IBOutlet UIView * segmentView;
@property(nonatomic,weak)IBOutlet UIButton * saveButton;
@property(nonatomic,assign)BOOL permissions;

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
    
    self.page = 1;
    self.time = 2;
    
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
    
//    [[self.segmentView viewWithTag:11] addSubview:self.flagView];
    [self getVIPInfo];
    [self getFindGroupNumberData];
    if ([[DeviceTool shareInstance].reviewStatus isEqualToString:REVIEWING]) {
        [TermsServiceAlertView showTermsServiceAlertView];
    }
    
}

/// 获取VIP信息
- (void)getVIPInfo{
    [NetworkWorker networkGet:[NetworkUrlGetter getMyVipUrl] success:^(NSDictionary *result) {
        if ([result[@"vip"] isKindOfClass:[NSDictionary class]]) {
            self.permissions = YES;
        }
    } failure:^(NSString *errorMessage) {
        
    }];
}

/// 各类别数量
- (void)getFindGroupNumberData{
    [NetworkWorker networkGet:[NetworkUrlGetter getFindGroupNumberUrl] success:^(NSDictionary *result) {
        self.numberDataDictionary = result[@"result"];
        [self.todayButton setTitle:[NSString stringWithFormat:@"今日(%@)",self.numberDataDictionary[@"today"]] forState:UIControlStateNormal];
        [self.yesterdayButton setTitle:[NSString stringWithFormat:@"昨日(%@)",self.numberDataDictionary[@"yesToday"]] forState:UIControlStateNormal];
        // self.numberDataDictionary[@"earlier"]
        [self.moreButton setTitle:[NSString stringWithFormat:@"更早(9999+)"] forState:UIControlStateNormal];
        [self segmengClick:self.yesterdayButton];
    } failure:^(NSString *errorMessage) {
        
    }];
}

/// 首页数据
- (void)getFindGroupListWithFlag:(NSInteger)flag{
    NSString * sTime = @"";
    NSString * eTime = @"";
    if (self.time == 1) {
        sTime = [self.numberDataDictionary[@"todayArea"] componentsSeparatedByString:@"#"].firstObject;
        eTime = [self.numberDataDictionary[@"todayArea"] componentsSeparatedByString:@"#"].lastObject;
    }else if(self.time == 2){
        sTime = [self.numberDataDictionary[@"yesTodayArea"] componentsSeparatedByString:@"#"].firstObject;
        eTime = [self.numberDataDictionary[@"yesTodayArea"] componentsSeparatedByString:@"#"].lastObject;
    }else{
        sTime = [self.numberDataDictionary[@"earlierArea"] componentsSeparatedByString:@"#"].firstObject;
        eTime = [self.numberDataDictionary[@"earlierArea"] componentsSeparatedByString:@"#"].lastObject;
    }
    NSDictionary * params = @{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],@"limit":@"1",@"wxgType":@"group",@"time":[NSString stringWithFormat:@"%d",self.time],@"sTime":sTime,@"eTime":eTime};
    [NetworkWorker networkPost:[NetworkUrlGetter getFindGroupListUrl] params:params success:^(NSDictionary *result) {
        if (self.page == 1) {
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<10000; i++) {
                [self.dataArray addObject:@""];
            }
        }
        NSArray * list = result[@"page"][@"list"];
        NSArray * modelArray = [GroupModel mj_objectArrayWithKeyValuesArray:list];
        [self.dataArray replaceObjectAtIndex:self.page withObject:modelArray.firstObject];
        [self formatNumber];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

- (void)formatNumber{
    GroupModel * model = self.dataArray[self.page];
    [ImageLoader loadImage:self.icon url:model.img_urls placeholder:[UIImage imageNamed:@"placehold1"]];
    self.contentLabel.text = model.wxg_desc;
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 发布于 %@",model.nickname,[model.add_time substringWithRange:NSMakeRange(5, model.add_time.length-5)]];
    self.pageLabel.text = [NSString stringWithFormat:@"%ld",self.page];
    self.pageLabel.layer.borderWidth = 1;
    self.pageLabel.layer.borderColor = [PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR].CGColor;
    [ImageLoader downloadImageByUrl:model.img_urls success:^(UIImage *image) {
        float imageRatio = image.size.width / image.size.height;
        CGFloat imageWidth = CGRectGetHeight(self.icon.frame)*imageRatio;
        self.saveButton.frame = CGRectMake(imageWidth/2+SCREEN_WIDTH/2-11, CGRectGetMaxY(self.icon.frame)-11, 22, 22);
    } fail:^(NSError *error) {
        
    }];
    
}

/// 保存图片
/// @param sender 按钮
- (IBAction)saveImageToPhoto:(UIButton *)sender{
    UIImageWriteToSavedPhotosAlbum(self.icon.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        [self.view makeToast:@"保存成功"];
    }else{
        [self.view makeToast:@"保存失败"];
    }
}

/// 日期切换
/// @param sender 按钮
- (IBAction)segmengClick:(UIButton *)sender{
    if (sender.tag == 10 && self.permissions == false) {
        [self pushToMembersController];
        return;
    }
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
    [self getFindGroupListWithFlag:self.page];
}

/// 下载
- (void)rightItemClick{
    if (![PreHelper isLogin]) {
        [PreHelper pushToLoginController];
        return;
    }
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
    if (self.page-1 > 0) {
        id obj = self.dataArray[self.page-1];
        if ([obj isKindOfClass:[NSString class]]) {
            [self getFindGroupListWithFlag:self.page-1];
        }else{
            self.page--;
            [self formatNumber];
        }
    }
}

/// 下一张
/// @param sender 按钮
- (IBAction)nextAction:(id)sender{
    if (self.permissions == YES) {
        if (self.page+1 < self.dataArray.count) {
            id obj = self.dataArray[self.page+1];
            if ([obj isKindOfClass:[NSString class]]) {
                self.page++;
                [self getFindGroupListWithFlag:self.page+1];
            }else{
                self.page++;
                [self formatNumber];
            }
        }
    }else{
        if (self.time == 2 && self.page == 3) {
            // 昨天可查看3张
            [self pushToMembersController];
        }else if(self.time == 3 && self.page == 5){
            // 更早可查看5张
            [self pushToMembersController];
        }else{
            id obj = self.dataArray[self.page+1];
            if ([obj isKindOfClass:[NSString class]]) {
                self.page ++;
                [self getFindGroupListWithFlag:self.page+1];
            }else{
                self.page++;
                [self formatNumber];
            }
        }
    }
}

- (IBAction)inpunNumber:(UITapGestureRecognizer *)sender{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = @"跳转至";
        textField.textAlignment = 1;
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * done = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.permissions) {
            self.page = alert.textFields.firstObject.text.integerValue;
            [self getFindGroupListWithFlag:self.page];
        }else{
            [self pushToMembersController];
        }
    }];
    [alert addAction:cancel];
    [alert addAction:done];
    [self presentViewController:alert animated:YES completion:nil];
}

/// 会员充值
- (void)pushToMembersController{
    if (![PreHelper isLogin]) {
        if ([[DeviceTool shareInstance].reviewStatus isEqualToString:REVIEWING]) {
            [PreHelper pushToLoginController];
        }else{
            [PreHelper pushToWechatLoginController];
        }
    }else{
        [MemberAlertView showMemberAlertViewWithDelegate:self];
    }
}

- (void)memberDidSelectAction{
    MembersViewController * member = [[MembersViewController alloc] init];
    member.title = @"会员中心";
    member.delegate = self;
    member.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:member animated:YES];
}

- (void)onRechargeMemberSuccess{
    self.permissions = YES;
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
