//
//  SearchViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/11.
//

#import "SearchViewController.h"
#import "SearchItemCollectionCell.h"

@interface SearchViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UISearchBarDelegate>

@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,weak)IBOutlet UICollectionView * collectionView;

@property(nonatomic,weak)IBOutlet UIButton * beforeButton;
@property(nonatomic,weak)IBOutlet UIButton * nextButton;
@property(nonatomic,weak)IBOutlet UILabel * contentLabel;
@property(nonatomic,weak)IBOutlet UILabel * pageLabel;
@property(nonatomic,weak)IBOutlet UIImageView * icon;
@property(nonatomic,assign)NSInteger currentFlag;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(15, 7, SCREEN_WIDTH-70, 30)];
    searchView.layer.cornerRadius = 5;
    searchView.layer.borderColor = [PreHelper colorWithHexString:@"#DEDEDE"].CGColor;
    searchView.layer.borderWidth = 0.5;
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:searchView.bounds];
    searchBar.backgroundImage = [UIImage new];
    searchBar.placeholder = @"请输入关键字检索（字越少结果越多）";
    searchBar.delegate = self;
    searchBar.returnKeyType = UIReturnKeySearch;
    [searchView addSubview:searchBar];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:searchView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController)];
    
    self.dataArray = @[@"1",@"2"];
    self.collectionView.backgroundColor = [PreHelper colorWithHexString:COLOR_TABBAR_TOPLINE_COLOR];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchItemCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SearchItemCollectionCell class])];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"searchHeader"];
    
    [self addObserver:self forKeyPath:@"currentFlag" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
}

- (void)dismissViewController{
    [self dismissViewControllerAnimated:true completion:^{
            
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",change);
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

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

#pragma mark - UICollectionViewDelegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchItemCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchItemCollectionCell class]) forIndexPath:indexPath];
    return cell;
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
    return 10;
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
