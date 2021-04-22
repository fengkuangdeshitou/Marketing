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
#import "CircleVideoCell.h"
#import "CircleMoreActionAlertView.h"
#import "AddFriendAlertView.h"
#import "CircleModel.h"
#import "UIImage+YYCompress.h"
#import "CreateCircleCiewController.h"
#import "HXPhotoPicker.h"
#import "HXPhotoCustomNavigationBar.h"
#import <ContactsUI/ContactsUI.h>
#import <SJVideoPlayer/SJVideoPlayer.h>
#import <SJBaseVideoPlayer/UIScrollView+ListViewAutoplaySJAdd.h>
#import "UIScrollView+ListViewAutoplaySJAdd.h"
#import "NetworkUrl.h"

@interface CircleViewController ()<UITableViewDelegate,UITableViewDataSource,CreateCircleCiewControllerDelegate,CircleVideoCellDelegate,SJPlayerAutoplayDelegate,CNContactViewControllerDelegate>

@property(nonatomic,copy)NSString * userId;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint * navigationBarHeight;
@property(nonatomic,weak)IBOutlet UIView * customNavigationBar;
@property(nonatomic,weak)IBOutlet UIView * createCircleButton;
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UIImageView * coverImageView;
@property(nonatomic,strong) UIImageView * avatarImageView;

@property (strong, nonatomic) HXPhotoCustomNavigationBar *customNavBar;
@property (strong, nonatomic) UINavigationItem *navItem;
@property (strong, nonatomic) HXPhotoManager *photoManager;
@property (strong, nonatomic) CAGradientLayer *topMaskLayer;
@property (strong, nonatomic) UIView *topView;
@property (nonatomic, strong) SJVideoPlayer *player;

@end

@implementation CircleViewController

- (instancetype)initWithUserId:(NSString *)userId
{
    self = [super init];
    if (self) {
        self.userId = userId;
    }
    return self;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIImageView *)coverImageView{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 330)];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
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

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-32, StatusBarHeight, 64, NavagationBarHeight)];
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _titleLabel.textColor = [PreHelper colorWithHexString:@"#282828"];
        _titleLabel.textAlignment = 1;
    }
    return _titleLabel;
}

- (HXPhotoManager *)photoManager {
    if (!_photoManager) {
        _photoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _photoManager.configuration.type = HXConfigurationTypeWXMoment;
        _photoManager.configuration.localFileName = @"hx_WxMomentPhotoModels";
        _photoManager.configuration.showOriginalBytes = YES;
        _photoManager.configuration.showOriginalBytesLoading = YES;
//        _photoManager.configuration.clarityScale = 2.f;
//#if HasSDWebImage
        // 先导入了SDWebImage
        _photoManager.configuration.photoEditConfigur.requestChartletModels = ^(void (^ _Nonnull chartletModels)(NSArray<HXPhotoEditChartletTitleModel *> * _Nonnull)) {
            
//            HXPhotoEditChartletTitleModel *netModel = [HXPhotoEditChartletTitleModel modelWithNetworkNURL:[NSURL URLWithString:@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/chartle/xxy_s_highlighted.png"]];
//            NSString *prefix = @"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/chartle/xxy%d.png";
//            NSMutableArray *netModels = @[].mutableCopy;
//            for (int i = 1; i <= 40; i++) {
//                [netModels addObject:[HXPhotoEditChartletModel modelWithNetworkNURL:[NSURL URLWithString:[NSString stringWithFormat:prefix ,i]]]];
//            }
//            netModel.models = netModels.copy;
//
//            if (chartletModels) {
//                chartletModels(@[netModel]);
//            }
        };
//#endif
    }
    return _photoManager;
}

- (HXPhotoCustomNavigationBar *)customNavBar {
    if (!_customNavBar) {
        _customNavBar = [[HXPhotoCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, HX_ScreenWidth, hxNavigationBarHeight)];
        _customNavBar.tintColor = [UIColor whiteColor];
        [_customNavBar setBackgroundImage:[UIImage hx_imageWithColor:[UIColor clearColor] havingSize:CGSizeMake(HX_ScreenWidth, hxNavigationBarHeight)] forBarMetrics:UIBarMetricsDefault];
        [_customNavBar setShadowImage:[UIImage new]];
        [_customNavBar pushNavigationItem:self.navItem animated:NO];
    }
    return _customNavBar;
}

- (UINavigationItem *)navItem {
    if (!_navItem) {
        _navItem = [[UINavigationItem alloc] init];// hotweibo_back_icon
        _navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage hx_imageNamed:@"hx_camera_overturn"] style:UIBarButtonItemStylePlain target:self action:@selector(creactCircleAction)];
    }
    return _navItem;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HX_ScreenWidth, hxNavigationBarHeight)];
        [_topView.layer addSublayer:self.topMaskLayer];
        self.topMaskLayer.frame = CGRectMake(0, 0, HX_ScreenWidth, hxNavigationBarHeight + 30);
    }
    return _topView;
}

- (CAGradientLayer *)topMaskLayer {
    if (!_topMaskLayer) {
        _topMaskLayer = [CAGradientLayer layer];
        _topMaskLayer.colors = @[
                                    (id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor,
                                    (id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor
                                    ];
        _topMaskLayer.startPoint = CGPointMake(0, 1);
        _topMaskLayer.endPoint = CGPointMake(0, 0);
        _topMaskLayer.locations = @[@(0.15f),@(0.9f)];
        _topMaskLayer.borderWidth  = 0.0;
    }
    return _topMaskLayer;
}

/// 导航渐变
/// @param scrollView tableview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /// 开始渐变位置
    CGFloat startPoint = 260;
    /// 结束渐变位置
    CGFloat endPoint = startPoint+UIApplication.sharedApplication.statusBarFrame.size.height;
    if (scrollView.contentOffset.y >= startPoint && scrollView.contentOffset.y <= endPoint) {
        self.customNavBar.backgroundColor = [PreHelper colorWithHexString:@"#F6F6F6" alpha:(scrollView.contentOffset.y-startPoint)/(endPoint-startPoint)];
        self.titleLabel.text = @"品圈";
        self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"circle_create_black"] style:UIBarButtonItemStylePlain target:self action:@selector(creactCircleAction)];
        self.customNavBar.tintColor = [UIColor blackColor];
    }else if (scrollView.contentOffset.y < startPoint){
        self.customNavBar.backgroundColor = [PreHelper colorWithHexString:@"#FFFFFF" alpha:0];
        self.titleLabel.text = @"";
        self.customNavBar.tintColor = [UIColor whiteColor];
    }else{
        self.customNavBar.backgroundColor = [PreHelper colorWithHexString:@"#F6F6F6"];
        self.titleLabel.text = @"品圈";
        self.customNavBar.tintColor = [UIColor blackColor];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.userId) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player vc_viewWillDisappear];
    if (!self.userId) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)onCreateCircleSuccess{
    self.page = 1;
    [self loadCircleData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player vc_viewDidAppear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player vc_viewDidDisappear];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isHiddenLoadString = YES;
    self.page = 1;
    if (!self.userId) {
        self.navigationBarHeight.constant = NavagationHeight;
        [self.view addSubview:self.topView];
        [self.view addSubview:self.customNavBar];
        [self.customNavBar addSubview:self.titleLabel];
        self.tableView.contentInset = UIEdgeInsetsMake(-UIApplication.sharedApplication.statusBarFrame.size.height - 44, 0, 0, 0);
        UIView * headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
        headerView.backgroundColor = UIColor.whiteColor;
        [headerView addSubview:self.coverImageView];
        [headerView addSubview:self.avatarImageView];
        self.tableView.tableHeaderView = headerView;
        
        [self loadCircleFriendsBackgroundImageData];
        [ImageLoader loadImage:self.avatarImageView url:[UserManager getUser].headimgurl placeholder:[UIImage imageNamed:@"placehold"]];
    }

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadCircleData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self loadCircleData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleContentCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleStatusCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleStatusCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleMoreCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleMoreCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleNineImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleNineImageCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleVideoCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleVideoCell class])];
    
}

/// 品圈 Header 图
- (void)loadCircleFriendsBackgroundImageData{
    [NetworkWorker networkGet:[NetworkUrlGetter getConfigUrlWithKey:circleFriendsBackgroundUrl] success:^(NSDictionary *result) {
        [ImageLoader loadImage:self.coverImageView url:result[@"str"] placeholder:[UIImage imageNamed:@"placehold2"]];
    } failure:^(NSString *errorMessage) {
        
    }];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (void)coverItemWasTapped:(CircleVideoCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self sj_playerNeedPlayNewAssetAtIndexPath:indexPath];
}

- (void)sj_playerNeedPlayNewAssetAtIndexPath:(NSIndexPath *)indexPath {
    
    CircleModel *model = self.dataArray[indexPath.section];
    if ( !_player ) {
        _player = [SJVideoPlayer player];
    }

    _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:model.video_url] playModel:[SJPlayModel playModelWithTableView:self.tableView indexPath:indexPath]];
    _player.URLAsset.title = model.nikename;
}

/// 品圈数据
- (void)loadCircleData{
    [NetworkWorker networkPost:[NetworkUrlGetter getFindCircleUrl] params:@{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],@"limit":@"10",@"mbId":self.userId != nil ? self.userId : @""} success:^(NSDictionary *result) {
        if (self.page == 1) {
            self.dataArray = [[NSMutableArray alloc] init];
        }
        NSArray * list = [result objectForKey:@"page"][@"list"];
        [self.dataArray addObjectsFromArray:[CircleModel mj_objectArrayWithKeyValuesArray:list]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

/// 发布
- (IBAction)creactCircleAction{
//    if (!self.getLocalCompletion) {
//        [self.photoManager getLocalModelsInFile];
//    }
    if (self.photoManager.localModels.count) {
        // 有保存草稿的数据，将草稿数据添加后直接跳转
        [self.photoManager addLocalModels];
        [self setupManagerConfig];
        [self presentMomentPublish];
        return;
    }
    HXPhotoBottomViewModel *model1 = [[HXPhotoBottomViewModel alloc] init];
    model1.title = [NSBundle hx_localizedStringForKey:@"拍摄"];
    model1.subTitle = [NSBundle hx_localizedStringForKey:@"照片或视频"];
    model1.subTitleDarkColor = [UIColor hx_colorWithHexStr:@"#999999"];
    model1.cellHeight = 65.f;
    
    HXPhotoBottomViewModel *model2 = [[HXPhotoBottomViewModel alloc] init];
    model2.title = [NSBundle hx_localizedStringForKey:@"从手机相册选择"];
    [HXPhotoBottomSelectView showSelectViewWithModels:@[model1, model2] headerView:nil cancelTitle:nil selectCompletion:^(NSInteger index, HXPhotoBottomViewModel * _Nonnull model) {
        [self setupManagerConfig];
        // 去掉dismiss的动画方便选择完成后present
        self.photoManager.selectPhotoFinishDismissAnimated = NO;
        self.photoManager.cameraFinishDismissAnimated = NO;
        if (index == 0) {
            [self hx_presentCustomCameraViewControllerWithManager:self.photoManager delegate:self];
        }else if (index == 1){
            [self hx_presentSelectPhotoControllerWithManager:self.photoManager delegate:self];
        }
    } cancelClick:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CircleVideoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[CircleVideoCell class]]) {
        CircleModel * model = self.dataArray[indexPath.section];
        cell.model = model;
        cell.delegate = self;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CircleModel * model = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        CircleHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleHeaderCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if(indexPath.row == 1){
        CircleContentCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleContentCell class]) forIndexPath:indexPath];
        cell.contentLabel.text = model.text;
        return cell;
    }else if(indexPath.row == 2){
        CircleStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleStatusCell class]) forIndexPath:indexPath];
        cell.model = model;
        cell.cellHeightChangeBlock = ^{
            [UIView performWithoutAnimation:^{
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        };
        return cell;
    }else if(indexPath.row == 3){
        if (model.video_url.length > 0) {
            CircleVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleVideoCell class]) forIndexPath:indexPath];
            return cell;
        }else{
            CircleNineImageCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleNineImageCell class]) forIndexPath:indexPath];
            cell.model = model;
            return cell;
        }
    }else{
        CircleMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleMoreCell class]) forIndexPath:indexPath];
        cell.model = model;
        cell.model.isShowDeleteButton = self.userId != nil;
        [cell.addFriendButton addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreButton addTarget:self action:@selector(circleMoreAction:) forControlEvents:UIControlEventTouchUpInside];
        HXWeakSelf
        cell.DeleteCircleBlock = ^(NSString * _Nonnull circleId) {
            [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
            [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        return cell;
    }
}

- (void)addFriendAction:(UIButton *)btn{
    CircleMoreCell * cell = (CircleMoreCell *)[[btn superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    CircleModel * model = self.dataArray[indexPath.section];
    [AddFriendAlertView addFriendWithModel:model];
}

- (void)circleMoreAction:(UIButton *)btn{
    CircleMoreCell * cell = (CircleMoreCell *)[[btn superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    CircleModel * model = self.dataArray[indexPath.section];
    [CircleMoreActionAlertView showMoreAcrionAlertViewWithCircleModel:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CircleModel * model = [self.dataArray objectAtIndex:indexPath.section];
    return [CircleBaseCell cellHeightWithIndexPath:indexPath dataModel:model];;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ComplaintsViewController * complaint = [[ComplaintsViewController alloc] init];
    complaint.title = @"违规举报";
    complaint.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:complaint animated:true];
}

- (void)setupManagerConfig {
    // 因为公用的同一个manager所以这些需要在跳转前设置一下
    self.photoManager.type = HXPhotoManagerSelectedTypePhotoAndVideo;
    self.photoManager.configuration.singleJumpEdit = NO;
    self.photoManager.configuration.singleSelected = NO;
    self.photoManager.configuration.lookGifPhoto = YES;
    self.photoManager.configuration.lookLivePhoto = YES;
    self.photoManager.configuration.photoEditConfigur.aspectRatio = HXPhotoEditAspectRatioType_None;
    self.photoManager.configuration.photoEditConfigur.onlyCliping = NO;
//    self.photoManager.configuration.photoEditConfigur.aspectRatio = HXPhotoEditAspectRatioType_1x1;
//    self.photoManager.configuration.photoEditConfigur.onlyCliping = YES;
//    self.photoManager.configuration.photoEditConfigur.isRoundCliping = YES;
}

- (void)presentMomentPublish {
    // 恢复dismiss的动画
    self.photoManager.selectPhotoFinishDismissAnimated = YES;
    self.photoManager.cameraFinishDismissAnimated = YES;
    
    CreateCircleCiewController *vc = [[CreateCircleCiewController alloc] init];
    vc.photoManager = self.photoManager;
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.modalPresentationCapturesStatusBarAppearance = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - < HXCustomCameraViewControllerDelegate >
- (void)customCameraViewController:(HXCustomCameraViewController *)viewController didDone:(HXPhotoModel *)model {
    [self.photoManager afterListAddCameraTakePicturesModel:model];
}
- (void)customCameraViewControllerFinishDismissCompletion:(HXPhotoPreviewViewController *)previewController {
    [self presentMomentPublish];
}
#pragma mark - < HXCustomNavigationControllerDelegate >
- (void)photoNavigationViewControllerFinishDismissCompletion:(HXCustomNavigationController *)photoNavigationViewController {
    [self presentMomentPublish];
}

- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(CNContact *)contact{
    if (contact) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"点击了取消，保存失败");
    }
    [viewController dismissViewControllerAnimated:YES completion:nil];
//    [[PreHelper getCurrentVC].navigationController popViewControllerAnimated:true];
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
