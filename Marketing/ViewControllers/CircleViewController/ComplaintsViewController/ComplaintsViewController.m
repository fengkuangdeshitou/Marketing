//
//  ComplaintsViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "ComplaintsViewController.h"
#import "ComplaintReasonHeaderCell.h"
#import "ComplaintReasonCell.h"
#import "ComplaintImageCell.h"
#import "ReportReasonsViewController.h"

@interface ComplaintsViewController ()<UITableViewDelegate,UITableViewDataSource,ReportReasonsViewControllerDelegate,ComplaintImageCellDelegate>

@property(nonatomic,copy)NSString * circleId;
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,strong)NSMutableArray * urlArray;
@property(nonatomic,strong)ComplaintsModel * complaintsModel;
@property(nonatomic,strong)UITextView * textView;
@property(nonatomic,weak)IBOutlet UITableView * tableView;

@end

@implementation ComplaintsViewController

- (instancetype)initWithCircleId:(NSString *)circleId
{
    self = [super init];
    if (self) {
        self.circleId = circleId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ComplaintReasonHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ComplaintReasonHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ComplaintReasonCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ComplaintReasonCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ComplaintImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ComplaintImageCell class])];
    
}

- (void)onDidSelectedReasonsModel:(ComplaintsModel *)model{
    self.complaintsModel = model;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)complaintImageCellDidSelectedImage:(NSArray<HXPhotoModel *> *)imageArray{
    self.imageArray = imageArray;
}

- (void)uploadImageWithData:(NSData *)data{
    [NetworkWorker networkPost:[NetworkUrlGetter getUploadImgUrl] formPostData:data andFileName:[ImageLoader getCreateImageName:[UserManager getUser].mb_no] success:^(NSDictionary *result) {
        [self.urlArray addObject:result[@"url"]];
        if (self.urlArray.count == self.imageArray.count) {
            [self complaintCircle];
        }
    } failure:^(NSString *errorMessage) {
        
    }];
}

- (IBAction)complaintsAction:(UIButton *)sender{
    
    if (self.complaintsModel == nil) {
        [self.view makeToast:@"请选择举报原因"];
        return;
    }
    
    if (self.imageArray.count > 0) {
        self.urlArray = [[NSMutableArray alloc] init];
        [self.imageArray hx_requestImageDataWithCompletion:^(NSArray<NSData *> * _Nullable imageDataArray) {
            [imageDataArray enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self uploadImageWithData:obj];
            }];
        }];
    }else{
        [self complaintCircle];
    }
}

- (void)complaintCircle{
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:self.complaintsModel.dict_name forKey:@"complaintType"];
    [params setValue:self.circleId forKey:@"circleId"];
    if (self.textView.text.length != 0) {
        [params setValue:self.textView.text forKey:@"complaintContent"];
    }
    if (self.urlArray.count > 0) {
        [params setValue:[self.urlArray componentsJoinedByString:@","] forKey:@"imgUrls"];
    }
    
    [NetworkWorker networkPost:[NetworkUrlGetter getAddComplaintUrl] params:params success:^(NSDictionary *result) {
        [self.view makeToast:@"举报成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ComplaintReasonHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintReasonHeaderCell class]) forIndexPath:indexPath];
        cell.contentLabel.text = self.complaintsModel.dict_name;
        return cell;
    }else if(indexPath.section == 1){
        ComplaintReasonCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintReasonCell class]) forIndexPath:indexPath];
        self.textView = cell.textView;
        return cell;
    }else{
        ComplaintImageCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ComplaintImageCell class]) forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ReportReasonsViewController * reasons = [[ReportReasonsViewController alloc] init];
        reasons.delegate = self;
        reasons.title = @"举报原因";
        [self.navigationController pushViewController:reasons animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 55;
    }else if(indexPath.section == 1){
        return 220;
    }else{
        return 260;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }else if(section == 1){
        return 0.5;
    }else{
        return 0.0001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
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
