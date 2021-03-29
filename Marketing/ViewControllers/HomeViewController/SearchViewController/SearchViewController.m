//
//  SearchViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/11.
//

#import "SearchViewController.h"
#import "SearchItemCollectionCell.h"
#import "GroupModel.h"

@interface SearchViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UISearchBarDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,weak)IBOutlet UICollectionView * collectionView;
@property(nonatomic,strong)UISearchBar * searchBar;
@property(nonatomic,weak)IBOutlet UIButton * beforeButton;
@property(nonatomic,weak)IBOutlet UIButton * nextButton;
@property(nonatomic,weak)IBOutlet UILabel * contentLabel;
@property(nonatomic,weak)IBOutlet UILabel * timeLabel;
@property(nonatomic,weak)IBOutlet UILabel * pageLabel;
@property(nonatomic,weak)IBOutlet UIImageView * icon;
@property(nonatomic,assign)NSInteger currentFlag;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,copy)NSString * selectText;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.page = 1;
    self.currentFlag = 0;
    
    self.beforeButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.beforeButton.layer.borderWidth = 1;
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(15, 7, SCREEN_WIDTH-90, 30)];
    searchView.layer.cornerRadius = 5;
    searchView.layer.borderColor = [PreHelper colorWithHexString:@"#DEDEDE"].CGColor;
    searchView.layer.borderWidth = 0.5;
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:searchView.bounds];
    searchBar.backgroundImage = [UIImage new];
    searchBar.placeholder = @"请输入关键字检索（字越少结果越多）";
    searchBar.delegate = self;
    searchBar.returnKeyType = UIReturnKeySearch;
    [searchView addSubview:searchBar];
    self.searchBar = searchBar;
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:searchView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController)];
    
    self.collectionView.backgroundColor = [PreHelper colorWithHexString:COLOR_TABBAR_TOPLINE_COLOR];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchItemCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SearchItemCollectionCell class])];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"searchHeader"];
    
    [self addObserver:self forKeyPath:@"currentFlag" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [self getHotSearch];
}

- (void)dismissViewController{
    [self dismissViewControllerAnimated:true completion:^{
            
    }];
}

- (void)getFindGroupList{
    [NetworkWorker networkPost:[NetworkUrlGetter getFindGroupListUrl] params:@{@"page":[NSString stringWithFormat:@"%ld",self.page],@"limit":@"10",@"wxgType":@"group",@"direction":@"random",@"time":@"1",@"key":self.searchBar.text,@"selectLabelList":self.selectText} success:^(NSDictionary *result) {
        if (self.page == 1) {
            self.dataArray = [[NSMutableArray alloc] init];
        }
        NSArray * list = result[@"page"][@"list"];
        [self.dataArray addObjectsFromArray:[GroupModel mj_objectArrayWithKeyValuesArray:list]];
        self.currentFlag ++;
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

/// 获取热门分类
- (void)getHotSearch{
    [NetworkWorker networkPost:[NetworkUrlGetter getHotSearchUrl] params:@{} success:^(NSDictionary *result) {
        self.dataArray = result[@"list"];
        [self.collectionView reloadData];
    } failure:^(NSString *errorMessage) {
        
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (self.currentFlag == 0) {
        return;
    }
    
    if (self.currentFlag <= self.dataArray.count) {
        GroupModel * model = self.dataArray[self.currentFlag-1];
        [ImageLoader loadImage:self.icon url:model.img_urls placeholder:nil];
        self.contentLabel.text = model.wxg_desc;
        self.timeLabel.text = [NSString stringWithFormat:@"%@ 发表于%@",model.nickname,[PreHelper dateFromString:model.add_time]];
        self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentFlag,self.dataArray.count];
    }
}

- (IBAction)beforeAction:(id)sender{
    if (self.currentFlag > 1) {
        self.currentFlag--;
    }
}

- (IBAction)nextAction:(id)sender{
    if (self.currentFlag == self.dataArray.count-1) {
        self.page += 1;
        [self getFindGroupList];
        return;
    }
    
    self.currentFlag ++;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.collectionView.hidden = YES;
    [searchBar resignFirstResponder];
    self.page = 1;
    self.currentFlag = 0;
    self.selectText = @"";
    [self getFindGroupList];
}

#pragma mark - UICollectionViewDelegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchItemCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchItemCollectionCell class]) forIndexPath:indexPath];
    NSDictionary * item = self.dataArray[indexPath.row];
    cell.contentLabel.text = item[@"label"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.collectionView.hidden = YES;
    self.selectText = self.dataArray[indexPath.row][@"label"];
    self.page = 1;
    self.currentFlag = 0;
    self.searchBar.text = @"";
    [self getFindGroupList];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"searchHeader" forIndexPath:indexPath];
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 50)];
        titleLabel.text = @"热门分类";
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textColor = [PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR];
        [header addSubview:titleLabel];
        return header;
    }else{
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 50);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-60)/4, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
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
