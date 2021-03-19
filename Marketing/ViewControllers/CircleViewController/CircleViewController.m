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
#import "CircleModel.h"
#import "UIImage+YYCompress.h"
#import "CreateCircleCiewController.h"
#import "HXPhotoPicker.h"
#import "HXPhotoCustomNavigationBar.h"

@interface CircleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)NSString * userId;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint * navigationBarHeight;
@property(nonatomic,weak)IBOutlet UIView * customNavigationBar;
@property(nonatomic,weak)IBOutlet UIView * createCircleButton;
@property(nonatomic,strong) UIImageView * coverImageView;
@property(nonatomic,strong) UIImageView * avatarImageView;

@property (strong, nonatomic) HXPhotoCustomNavigationBar *customNavBar;
@property (strong, nonatomic) UINavigationItem *navItem;
@property (strong, nonatomic) HXPhotoManager *photoManager;
@property (strong, nonatomic) CAGradientLayer *topMaskLayer;
@property (strong, nonatomic) UIView *topView;

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
            
            HXPhotoEditChartletTitleModel *netModel = [HXPhotoEditChartletTitleModel modelWithNetworkNURL:[NSURL URLWithString:@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/chartle/xxy_s_highlighted.png"]];
            NSString *prefix = @"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/chartle/xxy%d.png";
            NSMutableArray *netModels = @[].mutableCopy;
            for (int i = 1; i <= 40; i++) {
                [netModels addObject:[HXPhotoEditChartletModel modelWithNetworkNURL:[NSURL URLWithString:[NSString stringWithFormat:prefix ,i]]]];
            }
            netModel.models = netModels.copy;
            
            if (chartletModels) {
                chartletModels(@[netModel]);
            }
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
        _navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage hx_imageNamed:@"hx_camera_overturn"] style:UIBarButtonItemStylePlain target:self action:@selector(cgrectCircleAction)];
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
    if (scrollView.contentOffset.y > startPoint && scrollView.contentOffset.y < endPoint) {
        self.customNavBar.backgroundColor = [PreHelper colorWithHexString:@"#F6F6F6" alpha:(scrollView.contentOffset.y-startPoint)/(endPoint-startPoint)];
    }else if (scrollView.contentOffset.y < startPoint){
        self.customNavBar.backgroundColor = [PreHelper colorWithHexString:@"#FFFFFF" alpha:0];
    }else{
        self.customNavBar.backgroundColor = [PreHelper colorWithHexString:@"#F6F6F6"];
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
    if (!self.userId) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!self.userId) {
        self.navigationBarHeight.constant = NavagationHeight;
        [self.view addSubview:self.topView];
        [self.view addSubview:self.customNavBar];
        self.tableView.contentInset = UIEdgeInsetsMake(-UIApplication.sharedApplication.statusBarFrame.size.height - 44, 0, 0, 0);
        UIView * headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
        headerView.backgroundColor = UIColor.whiteColor;
        [headerView addSubview:self.coverImageView];
        [headerView addSubview:self.avatarImageView];
        self.tableView.tableHeaderView = headerView;
        
        [ImageLoader loadImage:self.coverImageView url:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=163656268,2073708275&fm=26&gp=0.jpg" placeholder:nil];
        [ImageLoader loadImage:self.avatarImageView url:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3043529068,4013011478&fm=26&gp=0.jpg" placeholder:nil];
    }

    NSDictionary * dict = @{
        @"content":@"拉库房阿里积分垃圾了法律上看见放辣椒拉减肥垃圾垃圾"
    };
    [self.dataArray addObject:dict];
    
    
    NSArray * array = @[
    @{
        @"title":@"张三",
        @"content":@"拉库房阿里积分垃圾了法律上垃圾垃圾房间爱了就垃圾阿拉基垃圾平均分假发票忘记放设计费配偶无分机安静泡脚搜啊就撒;就是解放路卡解放啦撒酒疯拉进来看家里放假拉丝机弗兰克斯家乐福阿里积分放假阿里",
        @"time":@"123212323",
        @"avatar":@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3043529068,4013011478&fm=26&gp=0.jpg",
        @"images":@[@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2005235653,1742582269&fm=26&gp=0.jpg"]
    },
        @{
            @"title":@"瑞文",
            @"content":@"圣诞节啦了垃圾垃圾假两件阿拉基倒垃圾老孔",
            @"time":@"123242323",
            @"avatar":@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3043529068,4013011478&fm=26&gp=0.jpg",
            @"images":@[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1569653248,3049509889&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=147444100,3816927537&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1569653248,3049509889&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=147444100,3816927537&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1569653248,3049509889&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=147444100,3816927537&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1569653248,3049509889&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=147444100,3816927537&fm=26&gp=0.jpg"]
        },
        @{
            @"title":@"卡特琳娜",
            @"content":@"陪我皮卡OK 排污口破我拉了打卡磕碰 OK颇为考完;奥施康定安监局撒世纪大劫案解放军按实际福利假按揭捡垃圾安静安静多少级阿拉斯加放辣椒垃圾恐龙当家安吉莉卡圣诞节拉进来卡",
            @"time":@"123212323",
            @"avatar":@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3043529068,4013011478&fm=26&gp=0.jpg"},
    ];
    self.dataArray = [CircleModel mj_objectArrayWithKeyValuesArray:array];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleContentCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleStatusCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleStatusCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleMoreCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleMoreCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleNineImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircleNineImageCell class])];
    
}

/// 发布
- (IBAction)cgrectCircleAction{
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CircleModel * model = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        CircleHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleHeaderCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if(indexPath.row == 1){
        CircleContentCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleContentCell class]) forIndexPath:indexPath];
        cell.contentLabel.text = model.content;
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
        CircleNineImageCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircleNineImageCell class]) forIndexPath:indexPath];
        cell.model = model;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
